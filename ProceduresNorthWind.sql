USE Northwind
GO
--Exercise 1
--Find the top ten product sales

/*CREATE OR ALTER PROCEDURE TOPTEN 
AS	
	SELECT TOP 10 p.ProductName,  sum (od.Quantity) AS [Units Sold]
	FROM [Order Details] od
	INNER JOIN [Products] p ON od.ProductID = p.ProductID
	GROUP BY  p.ProductName
	ORDER BY [Units Sold] DESC*/


/*CREATE OR ALTER PROCEDURE Secondplace1
AS

--Exercise 2
--Find the second product that has the second highest price in the company
	SELECT ProductID, ProductName, UnitPrice
	FROM [Products] ORDER BY UnitPrice DESC
	-- This way represent de simple form, through a list with all rows in the database*/
/*CREATE OR ALTER PROCEDURE Secondplace2
AS
	--Using (n-1) SQL logic, in this case through a subquery it's created a table to compare the unit price per product
	--in a new fictitius table an replacind in a new order only choosing the desired result
	SELECT ProductName, UnitPrice
	FROM [Products] p1
	WHERE 1 = (SELECT COUNT(DISTINCT UnitPrice)
				FROM Products p2
				WHERE p2.UnitPrice > p1.UnitPrice)*/

/*CREATE OR ALTER PROCEDURE SOLDRANK
AS
--Exercise 3
--Create a RANK with the sold products order by city and quantity
	SELECT p.ProductName, c.City, od.Quantity,
	DENSE_RANK () OVER (PARTITION BY c.City ORDER BY od.Quantity DESC) AS RANK 
	--This create a rank group by conditions represented in () in this case based in quantity
	FROM [Customers] c
	INNER JOIN Orders o ON (c.CustomerID = o.CustomerID)
	INNER JOIN [Order Details] od ON (o.OrderID = od.OrderID)
	INNER JOIN [Products] p ON (p.ProductID = od.ProductID)
	WHERE Country = 'USA'
	ORDER BY od.Quantity DESC*/


/*CREATE OR ALTER PROCEDURE DELAYEDORDERS
AS

--Exercise 4
--Find orders that took more than 2 days to be delivered after being placed by the user, where the value is greater than 10,000
--Show days number, date order, customerID and Country Ship

	SELECT   o.OrderID, o.CustomerID, o.OrderDate, o.ShippedDate, o.ShipCountry,
	DATEDIFF(DAY, OrderDate, ShippedDate) as DurationtoShip,
	SUM(od.Quantity * od.UnitPrice) AS [Total Sale Amount]
	FROM [Orders] o
	INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
	WHERE DATEDIFF(DAY, OrderDate, ShippedDate) > 2
	GROUP BY o.OrderID, o.CustomerID, o.OrderDate, o.ShippedDate, o.ShipCountry
	HAVING SUM(od.Quantity*od.UnitPrice) > 10000*/
	
/*CREATE OR ALTER PROCEDURE TOPCUSTOMERS
AS

--Excercise 5
--Find the top 10 most valuable customers
	SELECT TOP 10 c.CompanyName, c.Country, c.City,
	SUM(od.Quantity * od.UnitPrice) as [Total Sale]
	FROM [Customers] c
	INNER JOIN [Orders] o ON c.CustomerID = o.CustomerID
	INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
	-- WHERE YEAR(o.OrderDate) = '' --With this row is possible determinate which year we want the top customers
	GROUP BY c.CompanyName, c.Country, c.City
	ORDER BY [Total Sale] DESC*/

/*CREATE OR ALTER PROCEDURE Biggest30kAmount
AS
--Exercise 6
--Displays products that generated a total sales amount greater than or equal to $30,000 and shows the units sold of each product in 2018.
	SELECT p.ProductName, sum(od.Quantity) as [Number of Unities], sum(od.Quantity*od.UnitPrice) as [Total Sale Amount]
	FROM [Orders] o
	INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
	INNER JOIN [Products] p ON od.ProductID = p.ProductID
	WHERE YEAR(o.OrderDate) = '2018'
	GROUP BY p.ProductName
	HAVING SUM(od.Quantity*od.UnitPrice) >= 30000*/

/*CREATE OR ALTER PROCEDURE CustomerClassification
AS
--Exercise 7
--Classificate clients by total sales amount
-->=30000 Level A
-->=20000 y < 30000 Level B
--< 20000 Level C
	SELECT c.CompanyName,
	SUM(od.Quantity*od.UnitPrice) AS [Total Sales Amount],
	CASE
		WHEN (SUM(od.Quantity*od.UnitPrice) >= 30000) THEN 'A'
		WHEN (SUM(od.Quantity*od.UnitPrice) < 30000 AND SUM(od.Quantity*od.UnitPrice) >= 20000) THEN 'B'
		ELSE 'C'
		END
	FROM [Customers] c
	INNER JOIN [Orders] o ON c.CustomerID = o.CustomerID
	INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
	GROUP BY  c.CompanyName
	ORDER BY SUM(od.Quantity*od.UnitPrice) DESC*/

/*CREATE OR ALTER PROCEDURE BestCustomers
AS
--Exercise 8
--Which customers generated sales above the average of total sales? Filter by year
	SELECT c.CompanyName, c.City, c.Country,
	SUM(od.Quantity*od.UnitPrice) AS TOTAL
	FROM [Customers] c
	INNER JOIN [Orders] o ON c.CustomerID = o.CustomerID
	INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
	WHERE YEAR(o.OrderDate) = '2018'
	GROUP BY  c.CompanyName, c.City, c.Country
	HAVING SUM(od.Quantity*od.UnitPrice) > AVG(od.Quantity*od.UnitPrice)
	ORDER BY TOTAL DESC*/

/*CREATE OR ALTER PROCEDURE CustomerNotBought
AS
--Exercise 9
--Which customers have not purchased in the last 20 months?
	SELECT c.CompanyName, MAX(o.OrderDate),
	DATEDIFF(MONTH, MAX(o.OrderDate), GETDATE()) AS [Months Since Last Order]
	FROM [Customers] c
	INNER JOIN [Orders] o ON c.CustomerID = o.CustomerID
	GROUP BY c.CompanyName
	HAVING DATEDIFF(MONTH, MAX(o.OrderDate), GETDATE()) > 20
	ORDER BY c.CompanyName ASC*/

/*CREATE OR ALTER PROCEDURE OrderQuantityperClient
AS
--Exercise 10 
--Order Quantity per Client
	SELECT c.CompanyName,
	COUNT (o.OrderID) AS [Number of Orders]
	FROM [Customers] c
	INNER JOIN [Orders] o ON c.CustomerID = o.CustomerID
	GROUP BY c.CompanyName
	ORDER BY [Number of Orders] DESC*/

/*CREATE OR ALTER PROCEDURE CustomerRecurrence
AS
--Exercise 11
--Finds the duration of days between orders for each customer
	SELECT c.CompanyName, a.CustomerID,  a.OrderDate, b.OrderDate,
	DATEDIFF (DAY, a.OrderDate, b.OrderDate) AS [Days Between 2 orders]
	FROM[Orders] a
	INNER JOIN [Orders] b ON a.OrderID = b.OrderID - 1
	INNER JOIN [Customers] c ON c.CustomerID = a.CustomerID*/


/*CREATE OR ALTER PROCEDURE TOPEMPLOYEES
AS
--Exercise 12
--Display the employees with more sales
--Calculate their sales bonus with 2%

	SELECT TOP 3 CONCAT(e.FirstName, e.LastName) AS [Full Name],
	SUM(od.Quantity*od.UnitPrice) AS [Total Sales],
	ROUND(SUM(od.Quantity*od.UnitPrice)*0.02,0) AS Bonus
	FROM [Employees] e
	INNER JOIN [Orders] o ON o.EmployeeID = e.EmployeeID
	INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
	WHERE YEAR(o.OrderDate) = '2017' AND MONTH(o.OrderDate) = '6'  -- This row is editable for time that we want, but is possible choose
								       --these options during execute or is better create a function? And how?
	GROUP BY CONCAT(e.FirstName, e.LastName)
	ORDER BY SUM(od.Quantity*od.UnitPrice) DESC*/

/*CREATE OR ALTER PROCEDURE EmployeesQuantity
AS
--Exercise 13
--How many employees do you have per position and per city?
	SELECT title, city, COUNT(EmployeeID) AS Quantity
	FROM [Employees]
	GROUP BY title, city
	ORDER BY Quantity DESC*/

/*CREATE OR ALTER PROCEDURE TimeWorkEmployees
AS
--Exercise 14
--How long have your employees been working?
	SELECT CONCAT(FirstName, LastName) AS [Full Name], Title,
	DATEDIFF(YEAR, HireDate, GETDATE()) AS [Work years in the company]
	FROM[Employees]
	ORDER BY DATEDIFF(YEAR, HireDate, GETDATE()) DESC*/

/*CREATE OR ALTER PROCEDURE Above70yoldEmp
AS
--Exercise 15
--How many employees are over 70 years old?
	SELECT CONCAT(FirstName, LastName) AS [Full Name], Title,
	DATEDIFF(YEAR, BirthDate, GETDATE()) AS [AGE]
	FROM [Employees]
	WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) >= 70
	ORDER BY DATEDIFF(YEAR, BirthDate, GETDATE()) DESC*/

EXECUTE TimeWorkEmployees
