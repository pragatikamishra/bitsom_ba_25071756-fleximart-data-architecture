NoSQL Analysis for FlexiMart

Section A: Limitations of RDBMS

Relational databases are structured around fixed schemas, which makes handling products
 with diverse attributes challenging. For example, laptops require fields like RAM and processor, 
 while shoes need size and color. Adding new product types necessitates altering table structures, 
 leading to frequent schema migrations that can be time-consuming and error-prone. Additionally, 
 storing nested or hierarchical data such as customer reviews is cumbersome in an RDBMS. 
 Reviews often contain multiple fields like user details, rating, and comments. 
 Representing them requires creating separate tables and using joins, which increases query complexity 
 and can degrade performance. Overall, a relational database struggles to adapt to rapidly changing product 
 types and complex, nested information efficiently.


Section B: NoSQL Benefits

MongoDB, a document-oriented NoSQL database, addresses these limitations effectively. 
Its flexible schema allows each product document to have unique attributes, 
so laptops can have RAM and processor fields while shoes have size and color, without altering the collection structure. 
Embedded documents make storing nested data, such as customer reviews, straightforward—reviews 
can reside directly within the product document, simplifying queries and reducing the need for joins. 
MongoDB also supports horizontal scalability through sharding, enabling FlexiMart to distribute large volumes of 
product data across multiple servers, ensuring performance and growth without significant restructuring. 
This flexibility and scalability make MongoDB ideal for a diverse and evolving product catalog.

Section C: Trade-offs

While MongoDB provides flexibility, there are trade-offs. First, it lacks the strong ACID transaction support of MySQL, 
which can be a concern for critical operations like payment processing. Second, querying complex relationships across
 collections is less efficient than relational joins, potentially requiring data duplication. These trade-offs should 
 be considered when deciding between MongoDB and MySQL for the product catalog.