import pandas as pd
import numpy as np
from sqlalchemy import create_engine
import sys

# --- CONFIGURATION ---
# Update this connection string with your database credentials
# Format: mysql+pymysql://username:password@host/database_name
DB_CONNECTION = 'mysql+pymysql://root:password@localhost/fleximart'

def robust_date_parser(series):
    """Handles mixed date formats (DD/MM/YYYY and MM-DD-YYYY)."""
    parsed = pd.to_datetime(series, dayfirst=True, errors='coerce')
    still_na = parsed.isna() & series.notna()
    if still_na.any():
        parsed[still_na] = pd.to_datetime(series[still_na], dayfirst=False, errors='coerce')
    return parsed

def to_int_id(series):
    """Converts alpha-numeric IDs (C001, P001) to clean Integers (1)."""
    return series.str.extract('(\d+)').astype(float).astype('Int64')

def run_etl():
    print("--- 1. EXTRACT: Loading Raw Data ---")
    try:
        sales = pd.read_csv('sales_raw.csv')
        products = pd.read_csv('products_raw.csv')
        customers = pd.read_csv('customers_raw.csv')
    except FileNotFoundError as e:
        print(f"CRITICAL ERROR: {e}")
        return

    print("--- 2. TRANSFORM: Cleaning & Normalizing ---")
    
    # A. Clean Customers
    customers_c = customers.drop_duplicates(subset=['customer_id']).copy()
    customers_c['customer_id'] = to_int_id(customers_c['customer_id'])
    customers_c['registration_date'] = robust_date_parser(customers_c['registration_date'])
    customers_c['email'] = customers_c['email'].fillna('unknown@fleximart.com')
    # Clean phone: extract digits and keep last 10
    customers_c['phone'] = customers_c['phone'].astype(str).str.extract('(\d+)', expand=False).str[-10:]
    
    # B. Clean Products
    products_c = products.copy()
    products_c['product_id'] = to_int_id(products_c['product_id'])
    products_c['category'] = products_c['category'].str.strip().str.title()
    # Impute missing prices from sales transactions
    price_map = sales.groupby('product_id')['unit_price'].median().to_dict()
    products_c['price'] = products_c.apply(
        lambda x: price_map.get(x['product_id'], x['price']) if pd.isna(x['price']) else x['price'], axis=1
    )
    products_c['stock_quantity'] = products_c['stock_quantity'].fillna(0).astype(int)

    # C. Clean Sales & Split into Orders/Items
    # Drop rows missing IDs to maintain referential integrity
    sales_c = sales.dropna(subset=['customer_id', 'product_id']).drop_duplicates().copy()
    sales_c['order_id'] = to_int_id(sales_c['transaction_id'])
    sales_c['customer_id'] = to_int_id(sales_c['customer_id'])
    sales_c['product_id'] = to_int_id(sales_c['product_id'])
    sales_c['order_date'] = robust_date_parser(sales_c['transaction_date'])
    sales_c['subtotal'] = sales_c['quantity'] * sales_c['unit_price']

    # Create Normalized Orders Table (Header)
    orders_cleaned = sales_c.groupby('order_id').agg({
        'customer_id': 'first',
        'order_date': 'first',
        'subtotal': 'sum',
        'status': 'first'
    }).rename(columns={'subtotal': 'total_amount'}).reset_index()

    # Create Normalized Order Items Table (Detail)
    order_items_cleaned = sales_c[['order_id', 'product_id', 'quantity', 'unit_price', 'subtotal']].copy()
    order_items_cleaned.index.name = 'order_item_id'
    order_items_cleaned = order_items_cleaned.reset_index()

    # Save local copies for documentation
    customers_c.to_csv('customers_cleaned.csv', index=False)
    products_c.to_csv('products_cleaned.csv', index=False)
    orders_cleaned.to_csv('orders_cleaned.csv', index=False)
    order_items_cleaned.to_csv('order_items_cleaned.csv', index=False)
    print("SUCCESS: Data cleaned and local CSVs generated.")

    print("--- 3. LOAD: Inserting into Database ---")
    try:
        engine = create_engine(DB_CONNECTION)
        
        # Define loading order to respect Foreign Key constraints
        load_map = {
            'customers': customers_c,
            'products': products_c,
            'orders': orders_cleaned,
            'order_items': order_items_cleaned
        }

        for table_name, df in load_map.items():
            try:
                # Use if_exists='append' to populate our predefined SQL tables
                df.to_sql(table_name, con=engine, if_exists='append', index=False)
                print(f"LOADED: {len(df)} records into '{table_name}'.")
            except Exception as inner_e:
                print(f"ERROR: Failed to load {table_name}. Details: {inner_e}")

    except Exception as outer_e:
        print(f"CRITICAL: Could not connect to database. {outer_e}")

    print("--- ETL PROCESS COMPLETE ---")

if __name__ == "__main__":
    run_etl()