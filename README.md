# FlexiMart Data Architecture Project

**Student Name:** Pragatika Mishra
**Student ID:** bitsom_ba_25071756
**Email:** pragatika18mishra@gmail.com
**Date:** 08/01/2026

## Project Overview
The FlexiMart Data Warehouse and Analytics project focuses on designing and implementing a star schema–based data warehouse to analyze historical sales data. The objective is to transform transactional sales information into a structured format optimized for analytical querying and business intelligence.

The project involves creating dimension tables for date, product, and customer data, along with a central fact table that captures sales metrics such as quantity sold, revenue, and discounts. This design enables efficient OLAP operations including drill-down, roll-up, and aggregation across multiple dimensions.

By loading realistic sample data and writing analytical SQL queries, the project demonstrates how data warehouses support strategic decision-making, such as identifying top-performing products, understanding customer value segments, and analyzing time-based sales trends.

Overall, this project provides hands-on experience with data warehousing concepts, schema design, data loading, and OLAP analytics in a real-world retail scenario.

## Repository Structure
├── part1-database-etl/
│   ├── etl_pipeline.py
│   ├── schema_documentation.md
│   ├── business_queries.sql
│   └── data_quality_report.txt
├── part2-nosql/
│   ├── nosql_analysis.md
│   ├── mongodb_operations.js
│   └── products_catalog.json
├── part3-datawarehouse/
│   ├── star_schema_design.md
│   ├── warehouse_schema.sql
│   ├── warehouse_data.sql
│   └── analytics_queries.sql
└── README.md

## Technologies Used

- Python 3.x, pandas, mysql-connector-python
- MySQL 8.0 
- MongoDB 6.0

## Setup Instructions

### Database Setup

```bash
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run Part 1 - ETL Pipeline
python part1-database-etl/etl_pipeline.py

# Run Part 1 - Business Queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

# Run Part 3 - Data Warehouse
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql


### MongoDB Setup

mongosh < part2-nosql/mongodb_operations.js

## Key Learnings

This project helped me understand the complete data warehousing lifecycle, from star schema design to analytical reporting.
I learned how choosing the right granularity enables effective drill-down and roll-up analysis.
The use of surrogate keys and dimension tables improved data consistency and query performance.
Writing OLAP queries strengthened my ability to convert business questions into meaningful insights.
Overall, the project demonstrated how data warehouses support strategic business decision-making.s

## Challenges Faced

1. Choosing the correct granularity
Challenge: Selecting the appropriate grain for the fact table was difficult, as an incorrect level could limit analysis.
Solution: Defined the grain as one row per product per order line item, which enabled detailed drill-down and flexible aggregations.

2. Maintaining referential integrity
Challenge: Foreign key constraints caused insertion errors when fact data was loaded before dimension data.
Solution: Loaded dimension tables first, validated surrogate keys, and then inserted records into the fact table.

3. Creating realistic sample data
Challenge: Generating data that reflected real-world sales patterns (weekend spikes, varied quantities and prices).
Solution: Distributed higher sales volumes on weekends and used varied pricing and discounts to simulate real business behavior.

4. Writing complex OLAP queries
Challenge: Queries involving CTEs, window functions, and multiple aggregations were initially complex.
Solution: Broke queries into logical steps using CTEs and validated results at each stage.

5. Translating business questions into SQL
Challenge: Converting high-level business requirements into technical queries was challenging.
Solution: First defined required metrics and dimensions, then mapped them systematically to fact and dimension tables.



========================================================================================================================================================================
data extraction
========================================================================================================================================================================
imported the required libraries
numpy
pandas
phonenumbers
re
datetime 
mysql.connector


imported customer_raw data
imported product_raw data
imported sales_raw data


========================================================================================================================================================================
data transformation
========================================================================================================================================================================
identified 5 missing emails (null values) and removed those records in customer_raw table using user-defined function find_treat_missing_values()

standardized phone numbers by extracting the last 10 digits to handle country codes and formatting differences using standardize_phone_numbers()

drop the column 'phone' from customer table 

added country code to the phone numbers +91-
-------------------------------------------------------------------------------------------------------------------------
treating missing values
-------------------------------------------------------------------------------------------------------------------------
remaned the product_raw['price'] to product_raw['unoit_price']

merged the sales_raw and product_raw to get a sales table to fetch the missing values of the sales_raw['product_id'] based on the unit price of the product_raw['unit_price']

dropped columns=['product_id_x','product_name','category','stock_quantity'] from the sales table 

dropped the records from product table where the price was missing for the category as there were no sales found for those categories

dates are converted to standard form YY-MM-DD

trimmed/ stripped extra space from product_name, first_name and last_name

removed duplicates from the tables

Standardized category names (e.g., "electronics", "Electronics", "ELECTRONICS" → "Electronics")

Add surrogate keys (auto-incrementing IDs)


loading:

established the connection to mysql serverto load the data

loaded customers table: 19 rows inserted
loaded products table : 16 rows inserted


orders table:

created orders table to from sales and customer table
removed all records with missing values
uploaded to mysql dababase fleximart: 28 rows inserted

order_items table:

created order_items table from orders, customer and product
removed all records with missing values as contraints are not null 
uploaded to mysql database fleximart: 26 rows inserted