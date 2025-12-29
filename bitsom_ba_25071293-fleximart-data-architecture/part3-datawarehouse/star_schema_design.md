## **Section 1: Schema Overview**



### **FACT TABLE: fact\_sales**



* **Grain:** One row per product per order line item.
* **Business Process:** Sales transactions captured at the point of sale.
* **Measures (Numeric Facts):**

  * quantity\_sold: Number of units sold.
  * unit\_price: Price per unit at the time of sale.
  * discount\_amount: Discount applied to the line item.
  * total\_amount: Final calculation ($quantity \\times unit\\\_price - discount$).

* **Foreign Keys:**

  * date\_key → dim\_date
  * product\_key → dim\_product
  * customer\_key → dim\_customer



### **DIMENSION TABLE: dim\_date**



* **Purpose:** Provides a time-based framework for trend analysis.
* **Type**: Conformed Dimension
* **Attributes:**

  * date\_key (PK): Surrogate key (integer, format: YYYYMMDD)
  * full\_date: Actual date
  * day\_of\_week: Monday, Tuesday, etc.
  * month: 1-12
  * month\_name: January, February, etc.
  * quarter: Q1, Q2, Q3, Q4
  * year: 2023, 2024, etc.
  * is\_weekend: Boolean



### **DIMENSION TABLE: dim\_product**



* **Purpose:** Stores descriptive attributes for product filtering and grouping.
* **Type**: Type 2 SCD (Slowly Changing Dimension).
* **Attributes:**

  * product\_key (PK): Surrogate key.
  * product\_id: Original natural key (from MySQL).
  * product\_name: Name of the product.
  * category: Broad classification (Electronics, Fashion).
  * subcategory: Specific classification (Smartphones, Jeans).
  * brand: Manufacturer name.



### **DIMENSION TABLE: dim\_customer**



* **Purpose:** Captures demographic data for customer segmentation.
* **Type**: Type 1 SCD (Slowly Changing Dimension).
* **Attributes:**

  * customer\_key (PK): Surrogate key.
  * customer\_id: Original natural key (from MySQL).
  * full\_name: Combined first and last name.
  * email: Customer contact.
  * city: Geographical location.
  * registration\_year: Year the customer joined.

## 

## **Section 2: Design Decisions**

1. **Granularity:** I chose the **transaction line-item level** because it provides the most flexibility. High granularity allows us to answer questions about specific products, categories, or order details that would be lost if the data were pre-aggregated at the order level.
2. **Surrogate Keys:** We use **integer surrogate keys** (date\_key, product\_key) instead of natural keys (like product\_id) to insulate the data warehouse from changes in the source system. This ensures that even if a product\_id changes in the MySQL database, the historical data in the warehouse remains linked.
3. **Drill-down \& Roll-up:** This design supports **drill-down** (e.g., viewing sales by Quarter > Month > Date) and **roll-up** (e.g., summing individual sales > Category > Total Revenue) operations by using standardized hierarchies within the dimension tables.

## 

## **Section 3: Sample Data Flow**



### **Source Transaction (MySQL):**



Order #101, Customer "John Doe", Product "Laptop", Qty: 2, Price: 50000



### **Data Warehouse Representation:**



**fact\_sales:**



**JSON**

{  
"date\_key": 20240115,  
"product\_key": 5,  
"customer\_key": 12,  
"quantity\_sold": 2,  
"unit\_price": 50000,  
"total\_amount": 100000  
}



dim\_date: {"date\_key": 20240115, "full\_date": "2024-01-15", "month": 1, "month\_name": "January", "quarter": "Q1", "year": 2024}

Dim\_product: {"product\_key": 5, "product\_id": "ELEC002", "product\_name": "Laptop", "category": "Electronics", "brand": "Apple"}

Dim\_customer: {"customer\_key": 12, "customer\_id": 1, "full\_name": "John Doe", "city": "Mumbai"}

