/*Find the total sales across all order
Additionally provide details such as ID,order date*/

SELECT 
OrderID,
OrderDate,
ProductID,
SUM(Sales) OVER(PARTITION BY ProductID)TotalSAlesByProduct 
FROM Sales.Orders



SELECT
OrderID,
OrderDate,
ProductID,
OrderStatus,
SUM(Sales) OVER() TotalSales,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProdcucts,
SUM(Sales) OVER(PARTITION BY ProductID,OrderStatus) TotalSalesByProdcuctsAndStatus
FROM Sales.Orders


/* rank each order based on thier sales from highest to 
to lowest,additionally provide details such orderID.OrderDate*/

SELECT
OrderID,
OrderDate,
Sales,
RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders


/* */

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders


SELECT
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomer
FROM Sales.Orders
GROUP BY CustomerID
















