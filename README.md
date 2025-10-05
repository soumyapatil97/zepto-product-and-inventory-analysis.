# zepto-product-and-inventory-analysis.
This project analyzes product, pricing, and inventory data from a Zepto-style dataset using **MySQL**.   The goal was to clean, transform, and extract insights from over **3,700 product records** across multiple categories.
 *Data Cleaning Steps*
- Standardized column names (e.g., `discountPercent` → `discount_percent`)
- Converted prices from **paise to rupees**
- Removed duplicate and invalid entries
- Ensured discounted prices are always lower than MRP
- Normalized category names for consistency

---

Key SQL Analyses
1. **High-MRP Out-of-Stock Products**
   ```sql
   SELECT name, category, mrp/100 AS mrp_in_rupees
   FROM zepto
   WHERE outOfStock = TRUE
   ORDER BY mrp DESC
   LIMIT 10;
Best Value Products (Price per Gram)

sql
Copy code
SELECT name, category, 
       ROUND((discountedSellingPrice/100.0)/weightInGms, 4) AS price_per_gram
FROM zepto
WHERE weightInGms > 100
ORDER BY price_per_gram ASC
LIMIT 10;
Category-Level Insights

sql
Copy code
SELECT category, 
       ROUND(AVG(discountPercent), 2) AS avg_discount,
       SUM(availableQuantity) AS total_stock
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC;
 *Insights Discovered*
Certain high-priced items were consistently out of stock, indicating strong demand.

Found best-value products by comparing price per gram across 3,000+ items above 100g.

Fruits & Vegetables and Dairy categories showed highest discounts.

Identified total inventory value and category-level stock contributions.

 *Tools Used*
MySQL Workbench

Excel (for initial data)


📈 Results
Analyzed 3,732 rows × 9 columns

Cleaned 100% of data using SQL

Derived 5+ actionable business insights from queries
