-- SELECT
-- CustomerID,
-- SUM(Sales) TotalSales,
-- RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomer
-- FROM Sales.Orders
-- GROUP BY CustomerID;


-- SELECT
-- OrderID,
-- OrderDate,
-- ProductID,
-- OrderStatus,
-- SUM(Sales) OVER() TotalSales,
-- SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProdcucts,
-- SUM(Sales) OVER(PARTITION BY ProductID,OrderStatus) TotalSalesByProdcuctsAndStatus
-- FROM Sales.Orders;

use SalesDB;
SELECT 
OrderID,
OrderDate,
ProductID,
SUM(Sales) OVER(PARTITION BY ProductID)TotalSAlesByProduct 
FROM Sales.Orders;