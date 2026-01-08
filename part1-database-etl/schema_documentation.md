Entity-Relationship Description

ENTITY: customers
Purpose: Stores customer information
Attributes:
  - customer_id: Unique identifier (Primary Key)
  - first_name: Customer's first name
  - last_name: customer's last name
  - email: customer's email address
  - phone: customner's phone number with country code
  - city: customer's city of residence
  - registration_date: customer's date of registration
Relationships:
  - One customer can place MANY orders (1:M with orders table)



ENTITY: products
Purpose: Stores product information
Attributes:
  - product_id: Unique identifier (Primary Key)
  - product_name: name of the product
  - category: category of the product
  - price: unit price of the product
  - stock_quantity: available quantity of products
  
Relationships:
  - One product can be ordered by MANY customers (1:M with orders table )


ENTITY: orders
Purpose: Stores order information
Attributes:
  - order_id: Unique identifier (Primary Key)
  - customer_id: customer unique identifier (foreign key)
  - order_date: date of order placed
  - total_amount: total order value
  - status: status of the order ( completed/pending )

Relationships:
  - Many orders can be placed by One custoner (M:1 with customers table)

  
  ENTITY: order_items
Purpose: Stores order_items information
Attributes:
  - order_items_id: Unique identifier (Primary Key)
  - order_id: order unique identifier (foreign key)
  - product_id: product unique identifier (foriegn key)
  - quantity: product quantity ordered
  - unit_price: unit price of the product ordered
  - subtotal: total of the order item placed

Relationships:
  - Many orders can be placed of One product (M:1 with product table)




  Normalization Explanation:

The given database design satisfies Third Normal Form (3NF) because it eliminates redundancy, ensures data integrity, and enforces clear dependency rules between attributes.

First, the design is in First Normal Form (1NF) because each table contains atomic (indivisible) values, there are no repeating groups or multivalued attributes, and each record can be uniquely identified using a primary key. For example, customer, product, and sales tables store one value per field and use unique identifiers such as customer_id and product_id.

Second, the design meets Second Normal Form (2NF) because all non-key attributes are fully functionally dependent on the entire primary key. Since each table uses a single-column primary key (e.g., customer_id in customers, product_id in products, and sale_id in sales), there are no partial dependencies. Attributes like customer name, email, or product price depend entirely on their respective primary keys and not on a subset of them.

Finally, the design satisfies Third Normal Form (3NF) by eliminating transitive dependencies. Non-key attributes depend only on the primary key and not on other non-key attributes. For instance, customer details such as name, email, and city are stored only in the customers table and not repeated in the sales table. Similarly, product attributes like product name and unit price are stored exclusively in the products table. The sales table references customers and products using foreign keys, ensuring that sales-specific data (quantity, date, total amount) does not duplicate customer or product information.

By separating entities into well-defined tables and using foreign keys to represent relationships, the design minimizes data duplication, simplifies updates, and maintains consistency—key characteristics of a 3NF-compliant database design.


Identify functional dependencies

1. Customers Table

Functional dependencies:

customer_id → first_name, last_name, email, phone, city

customer_id uniquely identifies all customer attributes.

email → customer_id, first_name, last_name, phone, city

Email is unique, it also functionally determines the other attributes.


2. Products Table

Functional dependencies:

product_id → product_name, unit_price, category

Each product has a unique ID that determines all other product attributes.

(Optional) product_name → product_id, unit_price, category

If product names are unique in your system, they can also serve as a determinant.


3. Orders Table

Functional dependencies:

order_id → customer_id, order_date, status, total_amount

Each order has a unique order_id, which determines the customer, date, status, and total order amount.

customer_id, order_date → order_id (if a customer places only one order per day)

Optional, only if system constraints guarantee one order per customer per day.

status depends only on order_id, not on other attributes:

order_id → status


4. Order_Items Table

Functional dependencies:

order_item_id → order_id, product_id, quantity, unit_price, subtotal

Each order line item has a unique identifier.

(order_id, product_id) → quantity, unit_price, subtotal

Within a single order, a product appears only once; the combination of order_id and product_id uniquely identifies the line item details.

quantity, unit_price → subtotal

subtotal is derived from quantity × unit_price.




Explain how the design avoids update, insert, and delete anomalies


1. Update Anomalies

Update anomalies occur when the same information is duplicated in multiple places, so updating it in one place requires multiple changes.


How this design avoids it:

Customer details are stored only in the Customers table.

Product details (name, price) are stored only in the Products table.

The Orders and Order_Items tables reference these via foreign keys (customer_id, product_id).

This ensures that changing a customer email or product price requires only one update, eliminating redundancy-related update anomalies.

2. Insert Anomalies

Insert anomalies occur when you cannot insert a new piece of information without adding unnecessary data or violating constraints.

How this design avoids it:

Products and customers exist independently of orders.

You can insert a new product or new customer without needing an order.

Similarly, an order can be created as soon as there is a valid customer, without forcing extra product details.

This avoids the need for “dummy data” to satisfy constraints.

3. Delete Anomalies

Delete anomalies occur when removing data unintentionally deletes other important information.

How this design avoids it:

Customer and product data are in separate tables.

Deleting an order or order item does not remove customer or product data, because the tables are independent.

Only foreign key references are removed, maintaining referential integrity.




Sample Data Representation:

Customers table

1	Sanjay	Agarwal	sanjay.agarwal@gmail.com	+91-9876543276	Lucknow	2024-03-28
2	Priyanka	Jain	priyanka.jain@yahoo.com	+91-9876543287	Indore	2024-03-15
3	Nikhil	Bose	nikhil.bose@gmail.com	+91-9988776600	Kolkata	2024-03-10

products table 

1	Samsung Galaxy S21	Electronics	45999.00	150
2	Nike Running Shoes	Fashion	3499.00	80
3	Levi's Jeans	Fashion	2999.00	120
4	Sony Headphones	Electronics	1999.00	200

orders table

1	14	2023-02-20	5998.00	Completed
2	13	2023-05-22	1950.00	Completed
3	12	2023-06-18	12999.00	Completed
4	17	2023-08-15	1299.00	Completed
5	11	2023-09-30	4599.00	Cancelled

order_items table 

1	1	3	2	2999.00	5998.00
2	2	7	3	650.00	1950.00
3	3	9	1	12999.00	12999.00
4	4	6	1	1299.00	1299.00