-- ZEPTO E-COMMERCE SQL DATA ANALYSIS
-- Tool: PostgreSQL | Dataset: Zepto Inventory (Kaggle)

-- ============================================================




-- SECTION 1: TABLE CREATION

drop table if exists zepto ;

create table zepto (
sku_id SERIAL PRIMARY KEY,
catagory VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC (8,2),
discountPercent NUMERIC(5,2),
avilableQuantity INTEGER,
discountSellingPrice NUMERIC(8,2),
weightInGms INTEGER ,
outOfStock BOOLEAN ,
quantity INTEGER
);

SELECT * FROM zepto ;





-- SECTION 2: DATA EXPLORATION

--count of rows
SELECT COUNT(*) FROM zepto;

--sample data
SELECT * FROM zepto
LIMIT 10;

--null values
SELECT * FROM zepto 
WHERE name IS NULL 
OR 
catagory IS NULL 
OR 
mrp IS NULL 
OR 
discountPercent IS NULL 
OR 
avilableQuantity IS NULL 
OR 
discountSellingPrice IS NULL 
OR 
weightInGms IS NULL 
OR 
outOfStock IS NULL 
OR 
quantity IS NULL ;


--difrent product catagories
SELECT DISTINCT catagory 
FROM zepto 
ORDER BY catagory ;

--products in stock vs out of stock
SELECT outOfStock ,COUNT(sku_id)
FROM zepto
GROUP BY outOfStock ;

--product names present multiple time
SELECT name , COUNT(sku_id) as "Number of SKUs"
FROM zepto
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC ;

--product with price = 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountSellingPrice = 0;




-- SECTION 3: DATA CLEANING

DELETE FROM zepto 
WHERE mrp = 0 ;

--convert paisa to rupees
UPDATE zepto
SET mrp = mrp/100.0 ,
discountSellingPrice = discountSellingPrice/100.0 ;

SELECT * FROM zepto ;
SELECT mrp , discountSellingPrice FROM zepto ;






-- SECTION 4: BUSINESS INSIGHTS

--Q1. Find the top 10 best-value products based on the discount percentage

SELECT DISTINCT name , mrp ,discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT(10) ; 


--Q2. what are the product with high MRP but out of stock

SELECT DISTINCT name , mrp  ,outOfStock
FROM zepto 
WHERE outOfStock = TRUE AND mrp > 200.00
ORDER BY mrp DESC ;

--Q3. calculate Estimated Revenue for each catagory

SELECT catagory,
SUM(discountSellingPrice * avilableQuantity) AS total_revenue 
FROM zepto
GROUP BY catagory
ORDER BY total_revenue ;

--Q4. Find all products where MRP is greater than 500 and discount is less than 10% .

SELECT DISTINCT name , mrp , discountPercent
FROM zepto
WHERE mrp > 500.00 AND discountPercent < 10.00
ORDER BY mrp DESC , discountPercent DESC ;

--Q5. Identify the top 5 catagories offering the highest average discount percentage.

SELECT AVG(discountPercent)
FROM zepto ;

SELECT catagory ,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY catagory 
ORDER BY avg_discount DESC
LIMIT 5 ;

--Q6. Find the price per gram for products above 100g and sort by best values.

SELECT DISTINCT name ,weightInGms , discountSellingPrice,
ROUND(discountSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100 
ORDER BY price_per_gram DESC;


--Q7. Group the products into categories like low,medium,bulk .

SELECT DISTINCT name ,weightInGms
FROM zepto 
GROUP BY weightInGms , name 
ORDER BY weightInGms DESC ;


SELECT DISTINCT name , weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
     WHEN weightInGms < 5000 THEN 'Medium'
	 ELSE 'Bulk'
	 END AS weight_catagory
FROM zepto
ORDER BY weightInGms DESC ;

--Q8. What is the Total Inventory Weight Per Catagory .

SELECT catagory ,
SUM(weightInGms * avilableQuantity) AS total_weight
FROM zepto 
GROUP BY catagory
ORDER BY total_weight DESC ;



































