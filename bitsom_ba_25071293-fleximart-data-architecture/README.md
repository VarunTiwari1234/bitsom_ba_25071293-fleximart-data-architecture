\# FlexiMart Data Architecture Project

**Student Name:** Varun Rishikesh Tiwari  
**Student ID:** bitsom\*\_ba\_\*25071293  
**Email:** varunrtv0@gmail.com  
**Date:** 29th Dec 2025



---



\## Project Overview  
This project involves building a multi-tier data architecture for FlexiMart, a retail giant. I developed a **Relational (RDBMS) ETL pipeline** for transactional data, a **NoSQL (MongoDB) catalog** for flexible product attributes and reviews, and an **Analytical Data Warehouse (Star Schema)** to generate high-level business intelligence and sales trends.

---

\## Repository Structure  
├── part1-database-etl/  
│   ├── etl\*\_pipeline.py           # Python script for data cleaning and SQL loading\*  
*│   ├── schema\_documentation.md   # 3NF design and ERD description  
│   ├── business\_queries.sql      # SQL for customer and product performance*  
*│   └── data\_quality\_report.txt   # Log of processed and cleaned records*  
*├── part2-nosql/*  
*│   ├── nosql\_analysis.md         # Theory report on RDBMS vs NoSQL  
│   ├── mongodb\_operations.js     # CRUD and Aggregation for product catalog*  
*│   └── products\_catalog.json     # Sample nested product data  
├── part3-datawarehouse/  
│   ├── star\_schema\_design.md     # Documentation of Fact and Dimension tables  
│   ├── warehouse\_schema.sql      # DDL for the Data Warehouse*  
*│   ├── warehouse\_data.sql        # 40+ rows of realistic sales data  
│   └── analytics\_queries.sql     # OLAP queries (Drill-down, Segmentation)*  
*└── README.md                     # Project documentation (this file)*



*---*



*## Technologies Used*  
*- **Python 3.x:** Pandas for ETL, MySQL-Connector for database linking.*  
*- **MySQL 8.0:** Host for both transactional (3NF) and analytical (Star Schema) databases.*  
*- **MongoDB 6.0:** Document-oriented storage for diverse product catalogs and reviews.*  
*- **SQL/NoSQL:** Advanced aggregation, Window functions, and Aggregation Pipelines.*



*—*



*## Setup Instructions*

*### Database Setup*



*# 1. Create databases*  


*mysql -u root -p -e "CREATE DATABASE fleximart;"*  
\*mysql -u root -p -e "CREATE DATABASE fleximart\_\*dw;"



\# 2. Run Part 1 - ETL Pipeline  
# (Ensure your CSV files are in the directory)  


python part1-database-etl/etl\*\_pipeline.py\*



*# 3. Run Part 1 - Business Queries*  


\*mysql -u root -p fleximart < part1-database-etl/business\_\*queries.sql



\# 4. Run Part 3 - Data Warehouse Setup \& Analysis  


mysql -u root -p fleximart\*\_dw < part3-datawarehouse/warehouse\_*schema.sql  
mysql -u root -p fleximart*\_dw < part3-datawarehouse/warehouse\_*data.sql  
mysql -u root -p fleximart*\_dw < part3-datawarehouse/analytics\_\*queries.sql



### **MongoDB Setup**



\# 1. Import the product catalog  


mongoimport --db fleximart --collection products --file part2-nosql/products\_catalog.json --jsonArray



\# 2. Run MongoDB operations  


mongosh fleximart < part2-nosql/mongodb\_operations.js



## **Key Learnings**



Throughout this project, I mastered the transition from **Operational data (3NF)** to **Analytical data (Star Schema)**, understanding how to optimize each for its respective use cases. I learned how to handle **schema drift** using NoSQL document structures and how to implement **Window Functions** in SQL for complex calculations like running totals and revenue percentages. Additionally, I gained hands-on experience in building a robust **Python-based ETL pipeline** that ensures data integrity before it reaches the end-user.



## **Challenges Faced**



1. **Date Standardization:** The raw CSV data contained inconsistent date formats (DD/MM/YYYY vs MM-DD-YYYY).

   * **Solution:** Used pd.to\_datetime with errors='coerce' in Python to standardize all timestamps before SQL insertion.



2. **Joining across Granularity:** Joining orders with order\_items in Query 1.1 caused duplicate order counts.

   * **Solution:** Implemented COUNT(DISTINCT order\_id) to ensure accurate transaction counting even when multiple line items existed.



3. **NoSQL Aggregation:** Calculating average ratings from nested arrays in MongoDB required a specific pipeline approach.

   * **Solution:** Utilized the $avg operator within an $addFields stage to extract and compute values from the reviews array effectively.
