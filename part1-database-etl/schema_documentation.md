## 1. Entity-Relationship Description {#entity-relationship-description}

### ENTITY: customers

- **Purpose:** Stores essential profile information for individuals
  registered on the Fleximart platform.

- **Attributes:**

  - customer_id: Unique identifier (Primary Key).

  - first_name: Customer\'s given name.

  - last_name: Customer\'s family name.

  - email: Contact email address (used for login and notifications).

  - phone: 10-digit contact number.

  - city: Geographical location of the customer.

  - registration_date: The date the account was created.

- **Relationships:** One customer can place **MANY** orders (1:M with
  orders table).

### ENTITY: products

- **Purpose:** Maintains a catalog of all items available for sale,
  including pricing and stock levels.

- **Attributes:**

  - product_id: Unique identifier (Primary Key).

  - product_name: Full name of the product.

  - category: Broad classification (e.g., Electronics, Fashion).

  - price: Current selling price (monetary value).

  - stock_quantity: Number of units currently available in the
    warehouse.

- **Relationships:** One product can appear in **MANY** line items
  across different orders (1:M with order_items table).

### ENTITY: orders

- **Purpose:** Serves as the transaction header, recording \"who\"
  bought and \"when,\" along with the status of the overall purchase.

- **Attributes:**

  - order_id: Unique identifier (Primary Key).

  - customer_id: Reference to the buyer (Foreign Key).

  - order_date: Date the transaction was initiated.

  - total_amount: Total value of the entire order.

  - status: Current state (e.g., Completed, Cancelled).

- **Relationships:** One order can contain **MANY** specific items (1:M
  with order_items table).

### ENTITY: order_items

- **Purpose:** The junction/detail table that tracks the specific
  \"what\" of a transaction, linking orders to products.

- **Attributes:**

  - order_item_id: Unique identifier for the line item (Primary Key).

  - order_id: Reference to the parent order (Foreign Key).

  - product_id: Reference to the specific item sold (Foreign Key).

  - quantity: Number of units of this product in this order.

  - unit_price: Price of the product at the time of sale.

  - subtotal: Calculated as quantity \* unit_price.

- **Relationships:** Many line items belong to **ONE** order; many line
  items can refer to **ONE** product.

## 

## 2. Normalization Explanation (3NF) {#normalization-explanation-3nf}

The Fleximart database is designed in **Third Normal Form (3NF)** to
ensure high data integrity and performance.

### Functional Dependencies

Every table is organized so that every non-key attribute is functionally
dependent **only** on the Primary Key (the \"whole key\" and \"nothing
but the key\"). For instance, in the customers table, email and city are
determined solely by the customer_id. In products, the category and
price depend only on product_id.

### Justification for 3NF

The design achieves 3NF by eliminating **transitive dependencies**. For
example, in the original messy data, product details were mixed with
transaction dates. By splitting the data into four tables, we ensured
that a change in a product\'s name (in products) doesn\'t require
updating dozens of rows in the sales records. We have removed any
attribute that depends on another non-key attribute.

**Avoiding Anomalies**

1.  **Insert Anomaly:** We can add a new product to the products table
    without needing a customer to buy it first.

2.  **Update Anomaly:** If a customer changes their phone number, we
    only update one row in the customers table, rather than searching
    through every historical order they\'ve ever placed.

3.  **Delete Anomaly:** If we cancel an order and delete it from orders,
    we don\'t accidentally lose the customer\'s profile or the
    product\'s description from our system, as they reside in separate,
    linked tables.

## 3. Sample Data Representation {#sample-data-representation}

### Table: customers

|                 |                |               |                        |           |
|-----------------|----------------|---------------|------------------------|-----------|
| **customer_id** | **first_name** | **last_name** | **email**              | **city**  |
| 1               | Rahul          | Sharma        | rahul.sharma@gmail.com | Bangalore |
| 2               | Priya          | Patel         | priya.patel@yahoo.com  | Mumbai    |

### Table: products

|                |                    |              |           |                    |
|----------------|--------------------|--------------|-----------|--------------------|
| **product_id** | **product_name**   | **category** | **price** | **stock_quantity** |
| 1              | Samsung Galaxy S21 | Electronics  | 45999.00  | 150                |
| 3              | Apple MacBook Pro  | Electronics  | 52999.00  | 45                 |

### Table: orders

|              |                 |                |                  |            |
|--------------|-----------------|----------------|------------------|------------|
| **order_id** | **customer_id** | **order_date** | **total_amount** | **status** |
| 1            | 1               | 2024-01-15     | 45999.00         | Completed  |
| 2            | 2               | 2024-01-16     | 5998.00          | Completed  |

### Table: order_items

|                   |              |                |              |                |
|-------------------|--------------|----------------|--------------|----------------|
| **order_item_id** | **order_id** | **product_id** | **quantity** | **unit_price** |
| 0                 | 1            | 1              | 1            | 45999.00       |
| 1                 | 2            | 4              | 2            | 2999.00        |
