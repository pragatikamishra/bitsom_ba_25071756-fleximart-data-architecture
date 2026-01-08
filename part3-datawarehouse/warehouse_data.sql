USE fleximart_dw;

-- =========================
-- dim_date (30 records)
-- January–February 2024
-- =========================
INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,false),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,false),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,false),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,false),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,false),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,true),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,true),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,false),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,false),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,false),
(20240111,'2024-01-11','Thursday',11,1,'January','Q1',2024,false),
(20240112,'2024-01-12','Friday',12,1,'January','Q1',2024,false),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,true),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,true),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,false),
(20240116,'2024-01-16','Tuesday',16,1,'January','Q1',2024,false),
(20240117,'2024-01-17','Wednesday',17,1,'January','Q1',2024,false),
(20240118,'2024-01-18','Thursday',18,1,'January','Q1',2024,false),
(20240119,'2024-01-19','Friday',19,1,'January','Q1',2024,false),
(20240120,'2024-01-20','Saturday',20,1,'January','Q1',2024,true),
(20240121,'2024-01-21','Sunday',21,1,'January','Q1',2024,true),
(20240122,'2024-01-22','Monday',22,1,'January','Q1',2024,false),
(20240123,'2024-01-23','Tuesday',23,1,'January','Q1',2024,false),
(20240124,'2024-01-24','Wednesday',24,1,'January','Q1',2024,false),
(20240125,'2024-01-25','Thursday',25,1,'January','Q1',2024,false),
(20240126,'2024-01-26','Friday',26,1,'January','Q1',2024,false),
(20240127,'2024-01-27','Saturday',27,1,'January','Q1',2024,true),
(20240128,'2024-01-28','Sunday',28,1,'January','Q1',2024,true),
(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,false),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,false);

-- =========================
-- dim_product (15 products, 3 categories)
-- =========================
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Laptop Pro','Electronics','Computers',85000),
('P002','Smartphone X','Electronics','Mobiles',60000),
('P003','Bluetooth Earbuds','Electronics','Accessories',3000),
('P004','LED TV 55"','Electronics','Television',75000),
('P005','Tablet S','Electronics','Tablets',35000),

('P006','Office Chair','Furniture','Chairs',12000),
('P007','Wooden Desk','Furniture','Tables',25000),
('P008','Sofa Set','Furniture','Living Room',90000),
('P009','Bookshelf','Furniture','Storage',8000),
('P010','Dining Table','Furniture','Dining',45000),

('P011','Mixer Grinder','Appliances','Kitchen',7000),
('P012','Microwave Oven','Appliances','Kitchen',18000),
('P013','Washing Machine','Appliances','Laundry',40000),
('P014','Air Conditioner','Appliances','Cooling',100000),
('P015','Vacuum Cleaner','Appliances','Cleaning',15000);

-- =========================
-- dim_customer (12 customers, 4 cities)
-- =========================
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','John Doe','Mumbai','Maharashtra','Premium'),
('C002','Amit Sharma','Delhi','Delhi','Regular'),
('C003','Neha Verma','Bengaluru','Karnataka','Premium'),
('C004','Ravi Kumar','Chennai','Tamil Nadu','Regular'),
('C005','Pooja Singh','Mumbai','Maharashtra','Regular'),
('C006','Rahul Mehta','Delhi','Delhi','Corporate'),
('C007','Ananya Iyer','Bengaluru','Karnataka','Premium'),
('C008','Suresh Rao','Chennai','Tamil Nadu','Regular'),
('C009','Karan Malhotra','Mumbai','Maharashtra','Corporate'),
('C010','Sneha Patel','Delhi','Delhi','Regular'),
('C011','Vikram Joshi','Bengaluru','Karnataka','Corporate'),
('C012','Meena Das','Chennai','Tamil Nadu','Premium');

-- =========================
-- fact_sales (40 transactions)
-- Higher volume on weekends
-- =========================
INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
(20240106,1,1,2,85000,5000,165000),
(20240106,2,2,3,60000,3000,177000),
(20240107,3,3,5,3000,0,15000),
(20240107,4,4,1,75000,2000,73000),
(20240113,5,5,2,35000,3000,67000),
(20240113,6,6,4,12000,0,48000),
(20240114,7,7,1,25000,1000,24000),
(20240114,8,8,1,90000,5000,85000),
(20240120,9,9,3,8000,0,24000),
(20240120,10,10,1,45000,2000,43000),

(20240121,11,11,2,7000,0,14000),
(20240121,12,12,1,18000,1000,17000),
(20240122,13,1,1,40000,2000,38000),
(20240123,14,2,1,100000,5000,95000),
(20240124,15,3,2,15000,0,30000),
(20240125,1,4,1,85000,3000,82000),
(20240126,2,5,2,60000,2000,118000),
(20240127,3,6,6,3000,0,18000),
(20240127,4,7,1,75000,5000,70000),
(20240128,5,8,2,35000,2000,68000),

(20240201,6,9,3,12000,0,36000),
(20240201,7,10,1,25000,0,25000),
(20240202,8,11,1,90000,7000,83000),
(20240202,9,12,4,8000,0,32000),
(20240105,10,1,1,45000,1500,43500),
(20240104,11,2,2,7000,0,14000),
(20240103,12,3,1,18000,1000,17000),
(20240102,13,4,1,40000,2000,38000),
(20240101,14,5,1,100000,10000,90000),
(20240108,15,6,2,15000,0,30000),

(20240109,1,7,1,85000,2000,83000),
(20240110,2,8,2,60000,0,120000),
(20240111,3,9,3,3000,0,9000),
(20240112,4,10,1,75000,3000,72000),
(20240115,5,11,2,35000,2000,68000),
(20240116,6,12,1,12000,0,12000),
(20240117,7,1,1,25000,0,25000),
(20240118,8,2,1,90000,4000,86000),
(20240119,9,3,3,8000,0,24000),
(20240120,10,4,1,45000,2000,43000);