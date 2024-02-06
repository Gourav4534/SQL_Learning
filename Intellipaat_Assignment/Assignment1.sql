-- Salesman Table
CREATE TABLE Salesman (
    SalesmanId INT,
    SalesmanName VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);


INSERT INTO Salesman (SalesmanId, SalesmanName, Commission, City, Age)
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);



-- Customer Table
CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT,
    );

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);

-- Orders Table
CREATE TABLE Orders (
OrderId int,
CustomerId int,
SalesmanId int,
Orderdate Date,
Amount money
);

INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)



--Task 1(Insert a new record in your Orders table)--
Insert Into Orders
Values
(5005,2679,107,'2023-03-18',2000)


--Task2(Add Primary key constraint for SalesmanId column in Salesman table. Add default 
--constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
--column in Customer table. Add not null constraint in Customer_name column for the
--Customer table)

--Add primary Key Constraint For SalesmanId Column in Salesman Table
Alter Table Salesman
Alter Column Salesmanid int Not Null
Alter Table Salesman
Add Constraint Pk_Salesman_SalesmanId Primary key(Salesmanid);

--Adding Default Columns Constraint For City Column in Salesman Table--
Alter Table Salesman
Add Constraint Df_Salesman_city Default 'Unknown'for City;

--Adding Foreign Key Constraint For SalesmanId Column In Customer Table_-
Alter Table Customer 
Add Constraint Fk_customer_salesmanid Foreign key(Salesmanid)
References Salesman(Salesmanid);

--Adding Not Null constraint For CustomerName Column In Customer Table--
Alter Table Customer
Alter Column CustomerName Varchar(255) Not Null;



--Task 3(Fetch the data where the Customer’s name is ending with either ‘N’ also get the
--purchase amount value greater than 500)
Select *
From Customer
Where CustomerName like '%n' And PurchaseAmount >500;



--Task 4 Using SET operators, retrieve the first result with unique SalesmanId values from two
--tables, and the other result containing SalesmanId without duplicates from two tables.)

-- Unique Salesmanid Values From Two Table
Select  Salesmanid
From  Salesman
Union All
Select  Salesmanid
From Customer;

-- Salesman Id Without Duplicate From Two Tables
Select  Salesmanid 
From Salesman
Union 
Select  Salesmanid
From Customer;



--Task 5(Display the below columns which has the matching data.
--Orderdate, Salesman Name, Customer Name, Commission, and City which has the
--range of Purchase Amount between 1500 to 3000)

Select O.Orderdate,
S.SalesmanName,
C.CustomerName,
S.Commission,
S.City,
c.purchaseamount
From Salesman S
Join Customer C  on S.SalesmanId= C.SalesmanId
Join Orders O on  C.CustomerId = O.CustomerId
Where PurchaseAmount Between 1500 And 3000;


--Task 6(Using right join fetch all the results from Salesman And Orders table)--
Select *
From Salesman S
Right join Orders O on S.SalesmanId=O.SalesmanId;



