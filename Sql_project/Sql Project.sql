--Task 1 ( Get all the details from the person table including email ID, phone
--number and phone number type)
select pp.* ,
Pe.EmailAddress,
Ppp.PhoneNumber,
Ppp.PhoneNumberTypeID
From person.Person As Pp
Join person.EmailAddress As Pe On Pp.BusinessEntityID=Pe.BusinessEntityID
join Person.PersonPhone As PPP On PP.BusinessEntityID=Ppp.BusinessEntityID

--Task 2(Get the details of the sales header order made in May 2011)
Select * from 
Sales.SalesOrderHeader
Where Year(OrderDate)= 2011 And Month(OrderDate)=05;

--Task 3(Get the details of the sales details order made in the month of May
--2011)
Select * from 
Sales.SalesOrderDetail Sod
join Sales.SalesOrderHeader As Soh On Sod.SalesOrderID= Soh.SalesOrderID  
Where Year(OrderDate)= 2011 And Month(orderdate)=05;

-- Task 4(Get the total sales made in May 2011)
SELECT SUM(SubTotal) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE MONTH(OrderDate) = 5 AND YEAR(OrderDate) = 2011;

--Task 5(Get the total sales made in the year 2011 by month order by
--increasing sales)
SELECT DateName(Month,OrderDate) As OrderMonth,SUM(SubTotal) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE  YEAR(OrderDate) = 2011
Group by DateName(Month, OrderDate)
Order By TotalSales;

--Task 6(Get the total sales made to the customer with FirstName='Gustavo'
--and LastName='Achong')
SELECT SUM(soh.Subtotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Person.person p ON soh.rowguid= p.rowguid
WHERE p.FirstName = 'Gustavo' And p.LastName= 'Achong';








