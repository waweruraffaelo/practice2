# MSSQL PROJECT 
# PROJECT TITLE: PERFORMANCE ANALYSIS

### PROJECT OVERVIEW:
<P> 
Analyze a fictional company's sales data to gain insights into sales performance, Sales person behavior, and product trends. I'll  query a database to answer key business questions and showcase my SQL skills.
</P>

## Step 1 Data cleaning cheking for Duplicates

### Check for duplicates
```sql
WITH CTE_Duplicates AS(
  SELECT 
    ROW_NUMBER() OVER( PARTITION BY product,sales_Person,Geo,date,Amount,Customers,Boxes ORDER BY Date DESC) UniqueID,
    *
    FROM sales
)

SELECT*
FROM
CTE_Duplicates WHERE UniqueID =1

```
### Perfomance Analysis

**Find Total sales for each product**


```sql
SELECT 
Product,
Geo,
SUM(Amount) OVER(PARTITION BY Product) TotalSales
FROM Sales

```

**Total Sales Per Month and Geo location**

```SQL
SELECT
Product,
Geo,
FORMAT(Date, 'MMM') AS Month,
SUM(Amount) OVER(PARTITION BY FORMAT(Date, 'MMM'), Geo ) TotalSales
FROM Sales

```

**Sales person with the highest sales**
``` SQL
SELECT
p.Sales_Person,
s.product,
g.Geo,
Amount,
ROW_NUMBER() OVER (PARTITION BY s.Product,g.Geo ORDER BY Amount DESC) ProductRank
FROM sales s 
LEFT JOIN geo g 
ON s.Geo = g.GeoID
LEFT JOIN people p
ON s.Sales_Person = p.SP_ID

```
**Best performing salesperson per product in each country**

```SQL
SELECT *
FROM
(
    SELECT 
    ps.Product,
    p.Sales_person,
    g.Geo,
    Amount,
    ROW_NUMBER() OVER(PARTITION BY s.Product,s.Geo ORDER BY Amount DESC) RankBySalesperson
    FROM sales s
    LEFT JOIN geo g 
    ON s.Geo = g.GeoID
    LEFT JOIN people p
    ON s.Sales_Person = p.SP_ID
    LEFT JOIN products ps 
    ON s.Product = ps.Product_ID
) t WHERE RankBySalesperson = 1
```

**Lowest performance based on total sales**
```SQL
SELECT
*
FROM(
    SELECT
    Sales_Person,
    SUM(Amount) TotalSales,
    ROW_NUMBER() OVER(ORDER BY SUM(Amount) ) Rank
    FROM sales
    GROUP BY Sales_Person
) t WHERE Rank < = 2
```







