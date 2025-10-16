drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY ,
category VARCHAR (120),
name VARCHAR (150) NOT NULL,
mrp NUMERIC (8,2),
discountpercent NUMERIC(5,2),
availableQuantity INTEGER,
DiscountedSellingPrice Numeric(8,2),
weightInGms INTEGER,
OutofStock BOOLEAN ,
Quantity INTEGER
);
--DATA EXPLORATION
--COUNT OF ROWS
SELECT * FROM zepto
limit 10;

--null values 
SELECT * FROM zepto 
WHERE name IS NULL
OR
CATEGORY IS NULL
OR
mrp IS NULL
OR
discountPercent  IS NULL
OR
discountedSellingPrice  IS NULL
OR
WeightInGms  IS NULL
OR
AvailableQuantity  IS NULL
OR
OutofStock IS NULL
OR
quantity  IS NULL;

--different product categories 
SELECT DISTINCT category
FROM zepto
ORDER BY category;

---product in stock vs out of stock
SELECT outofstock, COUNT(sku_id)
FROM zepto
GROUP BY outofstock;


--product names present multiple times
SELECT name, Count(sku_id) as "Number of SKUs "
FROM zepto
GROUP BY name 
HAVING count(sku_id) >1
ORDER BY count(sku_id) DESC;
--data clean

--product with price=0
SELECT *FROM ZEPTO 
WHERE mrp =0 OR discountedSellingPrice = 0;

DELETE FROM zepto 
WHERE mrp =0;

--convert paise to rupees
UPDATE zepto
SET mrp=mrp/100.0,
DiscountedSellingPrice = DiscountedSellingPrice/100.0;



SELECT mrp, discountedSellingPrice FROM zepto

--top 10 best vale product based on discount percentage
SELECT DISTINCT name , mrp , discountPercent
FROM zepto
ORDER BY  discountPercent DESC
LIMIT 10;

--WHAT ARE THE PRODUCTS WITH HIGH MRP BUT OUT OF STOCK.
SELECT DISTINCT name , mrp 
FROM zepto
WHERE outofstock = TRUE and mrp > 300
ORDER BY mrp DESC;

--CALCULATE THE TOTAL REVENUE OF EACH CATEGORY
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category 
ORDER BY total_revenue;

--FIND ALL PRODUCTS WHERE MRP IS GREATER THAN RS 500 AND DISCOUNT IS LESS THAN 10 PER
SELECT DISTINCT name, mrp ,discountPercent
FROM zepto
WHERE mrp> 500 AND discountPercent <10
ORDER BY mrp DESC , DiscountPercent DESC;

--WHICH PRODUCT CATEGORY OFFERING THE HIGHEST  AVERAGE DISCOUNT PERCENTAGE
SELECT category ,
ROUND(AVG (discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
limit 5;

--FIND price per grm for product above 100gm and sort by best value
SELECT DISTINCT name , weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_grms
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_grms ;

--group the products as low medium bulk .
SELECT DISTINCT name , weightIngms,
CASE WHEN weightInGms < 1000 Then 'low'
 WHEN weightInGms < 5000 Then 'Medium'
 Else 'Bulk'
 END AS weight_category
 FROM zepto;
 ---what is total inventory weight per category 
 SELECT category,
 SUM (weightIngms * availableQuantity ) AS total_weight
 FROM zepto
 GROUP BY category 
 ORDER BY total_weight;
 
 
 
 







