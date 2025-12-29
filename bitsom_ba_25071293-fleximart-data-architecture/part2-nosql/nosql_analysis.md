## **Section A: Limitations of RDBMS**

The current **RDBMS (MySQL)** structure, while excellent for structured transactions, faces significant hurdles as FlexiMart scales:

1. **Attribute Diversity:** In a relational model, every product must fit into a fixed set of columns. To store specific details for laptops (RAM, GPU) alongside shoes (Size, Material), the table must either have hundreds of **NULL columns** or complex, multi-table "Entity-Attribute-Value" (EAV) designs that drastically slow down queries.  
2. **Schema Rigidity:** Adding a new category requires an ALTER TABLE command. In a live production environment with millions of rows, schema changes can **lock the database**, causing downtime.  
3. **Nested Data (Reviews):** Storing reviews requires a separate table and a JOIN operation. As the number of reviews grows, these joins become computationally expensive, making it difficult to display a product page quickly.

## 

## **Section B: NoSQL Benefits**

MongoDB offers a **schema-less** approach that directly addresses FlexiMart's growth:

1. **Flexible Schema:** MongoDB stores data in **BSON (JSON-like) documents**.1 This allows a "Laptop" document and a "Shoe" document to exist in the same collection with entirely different fields. New product types can be added instantly without any database-wide changes.

2. **Embedded Documents:** Customer reviews can be stored as an **array within the product document**. This allows FlexiMart to retrieve a product and all its reviews in a **single read operation**, eliminating the need for expensive joins and improving page load speeds.  
3. **Horizontal Scalability:** Unlike MySQL, which usually scales by adding more power to one server (Vertical), MongoDB is designed for **Sharding**.2 It can distribute data across many cheap servers (Horizontal), making it easier to handle massive traffic spikes.3

## **Section C: Trade-offs**

While MongoDB provides flexibility, there are two key disadvantages compared to MySQL:

1. **Data Redundancy:** Since MongoDB encourages embedding (denormalization), data like a "Customer Name" might be repeated in multiple review documents. If a customer changes their name, FlexiMart must update multiple documents, increasing the risk of **data inconsistency**.  
2. **Lack of Complex Joins:** MongoDB is not designed for complex multi-collection joins. If the business needs deep relational reporting (like cross-referencing global inventory with detailed customer demographics), writing these queries is more difficult and less efficient than in MySQL.