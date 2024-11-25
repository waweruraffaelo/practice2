use ac;


SELECT * FROM sales

SELECT 

ROW_NUMBER() OVER(ORDER BY Date,sales_Person) UniqueID,
*
FROM sales

-- Find all Total sales

SELECT 
Product,
Geo,
SUM(Amount) OVER(PARTITION BY Product) TotalSales
FROM Sales;


SELECT
Product,
Geo,
FORMAT(Date, 'MMM') AS Month,
SUM(Amount) OVER(PARTITION BY FORMAT(Date, 'MMM'), Geo ) TotalSales
FROM Sales


SELECT
p.Sales_Person,
pr.product,
g.Geo,
Amount,
ROW_NUMBER() OVER (PARTITION BY s.Product,s.Geo ORDER BY Amount DESC) ProductRank
FROM sales s 
LEFT JOIN geo g 
ON s.Geo = g.GeoID
LEFT JOIN people p
ON s.Sales_Person = p.SP_ID
LEFT JOIN products pr 
ON s.Product = pr.Product_ID


SELECT * FROM products



SELECT 
TOP 5 pr.product,
SUM(s.Amount) OVER(PARTITION BY geo)AS TotalSales
FROM sales s
LEFT JOIN products pr 
ON s.Product = pr.Product_ID
GROUP BY pr.product



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



WITH CTE_Duplicates AS(
  SELECT 
    ROW_NUMBER() OVER( PARTITION BY product,sales_Person,Geo,date,Amount,Customers,Boxes ORDER BY Date DESC) UniqueID,
    *
    FROM sales
)

SELECT*
FROM
CTE_Duplicates WHERE UniqueID =1