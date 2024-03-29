--Task 1(Display the number of states present in the LocationTable)
Select Count(Distinct State)As Number_ofStates
From Location;


--Task 2(How many products are of regular Type)
Select Count(product_type) As TotalProduct_ofRegularType
From Product
Where Type='Regular';


--Task 3(How much spending has been done on marketing of product ID 1?)
Select ProductId,
Sum(Marketing) As SpendingOnmarketing
From Fact
Where ProductId =1
Group By ProductId;


--Task 4(What is the minimum sales of a product?)
Select p.product,
f.ProductId,
Min(F.Sales) As MinSales
From Fact f
Join  Product p on f.productid= p.ProductId
Group By
P.product, f.ProductId;


--Task 5(Display the max Cost of Good Sold (COGS))
Select  max(COGS) As Max_OfCogs
fROM fact;


--Task 6(Display the details of the product where product type is coffee)
Select *
From Product
Where Product_Type = 'Coffee';

--Task 7(Display the details where total expenses are greater than 40)
Select * 
From Fact 
Where Total_Expenses >40;

--Task 8(What is the average sales in area code 719?)
Select avg(Sales) As Avg_Sales_On719
From Fact
Where Area_code = 719;


--Task 9(. Find out the total profit generated by Colorado state)
SELECT Sum(f.profit) AS Total_profit
FROM  Fact f
JOIN Location l ON f.Area_Code = l.Area_Code
WHERE  l.State = 'Colorado';

--Task 10(Display the average inventory for each product ID)
Select ProductID,
AVG(Inventory) As Avg_inventory
From Fact
Group By ProductId;

--Task11(Display state in a sequential order in a Location Table.)
Select * 
From Location
Order By State;


--Task 12(Display the average budget of the Product where the average budget
--margin should be greater than 10)

SELECT p.ProductId,
p.Product,
AVG(f.Budget_Profit) AS AverageBudgetProfit,
AVG(f.Budget_COGS) AS AverageBudgetCOGS,
AVG(f.Budget_Margin) AS AverageBudgetMargin,
AVG(f.Budget_Sales) AS AverageBudgetSales
FROM
Fact f
JOIN
 Product p ON f.ProductID = p.ProductID
GROUP BY p.Product,p.ProductId
HAVING AVG(f.Budget_Margin) > 100;


--Task 13(What is the total sales done on date 2010-01-01)
Select Sum(Sales) As Total_Sales,
Date
From Fact
Where Date = '2010-01-01'
Group By Date;

--Task 14(Display the average total expense of each product ID on an individual date)
Select Date,
Productid,
avg(total_expenses) As Avg_TotalExpenses
From Fact
Group By  Date, ProductId;

--Task 15(display the table with the following attributes such as date, productID, product_type, product, sales, profit, state,area_code.)
Select
f.Date,
f.Productid,
p.product_type,
p.Product,
f.Sales,
f.Profit,
l.State,
l.Area_Code
From Fact f
join Product P On f.productid=p.productid 
Join
Location l on f.Area_Code =l.Area_Code
Group By
f.Date,
f.Productid,
p.product_type,
p.Product,
f.Sales,
f.Profit,
l.State,
l.Area_Code;

--Task 16(Display the rank without any gap to show the sales wise rank)
Select ProductId,
Sales,
Dense_RANK() Over (Order By Sales Desc) As Sales_WiseRank
From fact

-- Task 17( Find the state wise profit And Sales)
Select l.state,
Sum(f.Profit) As Total_Profit,
Sum(f.Sales) As Total_Sales
From fact f
join location l on f.Area_Code = l.Area_Code
Group by
l.State;

-- Task 18(Find the state wise profit and sales along with the product name)
 Select l.state,
 P.product,
Sum(f.Profit) As Total_Profit,
Sum(f.Sales) As Total_Sales
From fact f
join location l on f.Area_Code = l.Area_Code
Join Product p on f.ProductId = p.ProductId
group by
l.State,
p.Product;

-- Task 19(If there is an increase in sales of 5%, calculate the increased Sales)
Select ProductId,
Sales,
Sales * 1.05 As IncreasedSales
From Fact;   

--Task 20(Find the maximum profit along with the product ID and producttype)
Select max(f.profit) As Max_Profit,
f.ProductId,
p.product_type
From fact f
Join Product p on f.ProductId =p.ProductId
Group By
p.Product_Type,
f.ProductId;

--Task 21 (Create a stored procedure to fetch the result according to the product type
--from Product Table)
Create Procedure fetch_producttype
@producttype varchar(50)
As
Begin
   Select *
   From Product
   Where Product_type = @producttype;
End;

--E.g
Exec fetch_producttype 'coffee'

--Task 22(Write a query by creating a condition in which if the total expenses is less than
--60 then it is a profit or else loss)
Select ProductId,
Total_Expenses,
Case
   When  Total_expenses < 60 Then 'It Is Profit'
   Else 'It is Loss'
   End As ProfitOrLoss
From Fact;

--Task 23(Give the total weekly sales value with the date and product ID details. Use
--roll-up to pull the data in hierarchical order)
Select Sum(sales) As WeeklySales,
Date,
Productid 
From fact 
Group By 
RollUp(Date, ProductId);


--Task 24 (Apply union and intersection operator on the tables which consist of
--attribute area code)
Select Area_Code From  fact 
Union
Select Area_Code From Location ;

Select Area_Code From Fact
Intersect
Select Area_Code From Location;


--Task 25(Create a user-defined function for the product table to fetch a particular
--product type based upon)
Create Function Particular_Prodcuttype
 (
 @Producttype varchar(50)
 )
Returns Table
 As
 Return
 (select *
 From Product
 Where Product_Type = @Producttype
 )
--E.g.
Select * From  Particular_Prodcuttype('Tea')

 --Task 26(Change the product type from coffee to tea where product ID is 1 and undo
--it.)
 update Product
 Set Product_type = 'Coffee'
 Where ProductId = 1
 --Undo
  update Product
 Set Product_type = 'Tea'
 Where ProductId = 1

 --Task 27(Display the date, product ID and sales where total expenses are
--between 100 to 2)
 Select Date,
 ProductId,
 Sales,
 Total_expenses
 From Fact
 Where Total_Expenses between 100 and 200;

 --Task 28(Delete the records in the Product Table for regular Type)
 Delete  From product
 Where type ='Regular'

 --Task 29(Display the ASCII value of the fifth character from the columnProduct)
 Select Product,
 ASCII(SUBSTRING(product, 5, 1)) As ASCIIvalue
 From Product;

 


 































