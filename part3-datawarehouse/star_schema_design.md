Star Schema Design for FlexiMart
Section 1: Schema Overview

FACT TABLE: fact_sales

Grain: One row per product per order line item

Business Process: Sales transactions

Measures (Numeric Facts):

quantity_sold: Number of units sold

unit_price: Price per unit at time of sale

discount_amount: Discount applied

total_amount: Final amount (quantity_sold × unit_price - discount_amount)

Foreign Keys:

date_key → dim_date.date_key

product_key → dim_product.product_key

customer_key → dim_customer.customer_key

DIMENSION TABLE: dim_date

Purpose: Date dimension for time-based analysis

Type: Conformed dimension

Attributes:

date_key (PK): Surrogate key (integer, format YYYYMMDD)

full_date: Actual date

day_of_week: Monday, Tuesday, etc.

month: 1-12

month_name: January, February, etc.

quarter: Q1, Q2, Q3, Q4

year: 2023, 2024, etc.

is_weekend: Boolean

DIMENSION TABLE: dim_product

Purpose: Product-related analysis

Type: Slowly Changing Dimension (Type 2 optional for versioning)

Attributes:

product_key (PK): Surrogate key

product_id: Original product identifier

product_name

category

subcategory

brand

current_price

status: Active/Discontinued

DIMENSION TABLE: dim_customer

Purpose: Customer-related analysis

Attributes:

customer_key (PK): Surrogate key

customer_id: Original customer identifier

customer_name

email

phone

city

state

country

loyalty_status: e.g., Gold, Silver, Bronze



Section 2: Design Decisions

The chosen granularity is transaction line-item level, capturing every product sold per order. This enables detailed analysis like product-level sales trends, customer buying patterns, and order-level profitability.

We use surrogate keys instead of natural keys to simplify joins, maintain consistency across slowly changing dimensions, and prevent issues if natural keys change in the source systems.

This star schema supports drill-down and roll-up operations efficiently. Analysts can roll up daily sales to weekly, monthly, or quarterly totals using dim_date, or drill down by category, product, or customer to understand performance at a granular level. The design balances query performance and ease of maintenance, as fact tables are narrow and dimension tables contain descriptive attributes for filtering, grouping, and slicing.



Section 3: Sample Data Flow

Source Transaction:

Order #101, Customer "John Doe", Product "Laptop", Qty: 2, Price: 50000


Becomes in Data Warehouse:

fact_sales:

{
  "date_key": 20240115,
  "product_key": 5,
  "customer_key": 12,
  "quantity_sold": 2,
  "unit_price": 50000,
  "discount_amount": 0,
  "total_amount": 100000
}


dim_date:

{
  "date_key": 20240115,
  "full_date": "2024-01-15",
  "day_of_week": "Monday",
  "month": 1,
  "month_name": "January",
  "quarter": "Q1",
  "year": 2024,
  "is_weekend": false
}


dim_product:

{
  "product_key": 5,
  "product_name": "Laptop",
  "category": "Electronics",
  "subcategory": "Computers",
  "brand": "Generic",
  "current_price": 50000,
  "status": "Active"
}


dim_customer:

{
  "customer_key": 12,
  "customer_name": "John Doe",
  "email": "johndoe@example.com",
  "phone": "9999999999",
  "city": "Mumbai",
  "state": "Maharashtra",
  "country": "India",
  "loyalty_status": "Gold"
}




                     ┌───────────────┐
                     │   dim_date     │
                     │───────────────│
                     │ date_key (PK) │
                     │ full_date     │
                     │ day_of_week   │
                     │ month         │
                     │ month_name    │
                     │ quarter       │
                     │ year          │
                     │ is_weekend    │
                     └───────▲───────┘
                             │
                             │
┌───────────────┐     ┌───────┴────────┐     ┌────────────────┐
│  dim_product  │◄────┤   fact_sales   ├────►│ dim_customer   │
│───────────────│     │────────────────│     │────────────────│
│ product_key   │     │ date_key (FK)  │     │ customer_key   │
│ product_id    │     │ product_key FK │     │ customer_id    │
│ product_name  │     │ customer_keyFK │     │ customer_name  │
│ category      │     │ quantity_sold  │     │ email          │
│ subcategory   │     │ unit_price     │     │ phone          │
│ brand         │     │ discount_amt   │     │ city           │
│ current_price │     │ total_amount  │     │ state          │
│ status        │     └────────────────┘     │ country        │
└───────────────┘                            │ loyalty_status │
                                             └────────────────┘
