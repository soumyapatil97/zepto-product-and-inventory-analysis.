use customers;
select * from zepto;
-- count of rows
select count(*) from zepto;
-- sample data
select * from zepto limit 10;
select * from zepto where name is null
or
category is null
or
mrp is null
or
discount_percent is null
or
available_quantity is null 
or
discounted_selling_price is null
or
weight_in_gms is null
or
quantity is null
or
outofstock is null;
-- different product categories
select distinct category from zepto order by category;
-- products  in stock vs out of stock
select outofstock, count(*) from zepto group by outofstock; 
-- product names present multiple times
select name, count(*) from zepto  group by name having count(*)>1 order by count(8) DESC; 
-- rename columns 
ALTER TABLE zepto
RENAME COLUMN discountPercent TO discount_percent,
RENAME COLUMN discountedSellingPrice TO discounted_selling_price,
RENAME COLUMN availableQuantity TO available_quantity,
RENAME COLUMN weightInGms TO weight_in_gms;
-- Check invalid entries
SELECT * FROM zepto
WHERE mrp <= 0 OR discounted_selling_price <= 0 OR weight_in_gms <= 0;
-- Remove or update them
DELETE FROM zepto
WHERE mrp <= 0 OR discounted_selling_price <= 0 OR weight_in_gms <= 0;
SELECT * 
FROM zepto
WHERE discounted_selling_price > mrp;
-- data cleaning
-- products with price=0
select * from zepto where mrp=0;
delete from zepto where mrp=0;
-- convert paise into rupees
update zepto set mrp=mrp/100.0, discounted_selling_price= discounted_selling_price/100.0;
-- Q1 find top 10 products based on discount_percent
select distinct name, mrp, discount_percent from zepto order by discount_percent DESC LIMIt 10;
-- Q2 what are the products with high mrp but out of stock
select distinct name, mrp from zepto where outOfstock = TRUE and mrp > 300 order by mrp DESC;
-- Q3 calculate estimated revenue for each category
select category, sum(discounted_selling_price * available_quantity) as total_revenue from zepto group by category
order by total_revenue;
-- Q4 find all products where mrp is greater than 500 and discount is less than 10%
select distinct name,mrp,discount_percent from zepto where mrp>500 and discount_percent<10
order by mrp desc, discount_percent desc;
-- Q5 identify the top 5 categories offering the highest avg discount percentage
select category, ROUND(AVG(discount_percent),2) as avg_discount from zepto group by category order by avg_discount
DESC LIMIT 5; 
-- find the price per gram for products above 100g and sort by best values
select distinct name, weight_in_gms,discounted_selling_price,round(discounted_selling_price/weight_in_gms)
AS price_per_gram from zepto where weight_in_gms >=100 order by price_per_gram;
-- group the products into categories like low, med, bulk
select distinct name,weight_in_gms, CASE when weight_in_gms < 1000 then 'low'
when weight_in_gms <5000 then 'Medium'
else 'bulk'
end as weight_category
from zepto;
-- Q8 what is the total inventory weight per category
select category, sum(weight_in_gms * available_quantity) AS total_weight
from zepto group by category order by total_weight;



