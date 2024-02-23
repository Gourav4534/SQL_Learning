--Task 1 ( Display the count of customers in each region who have done the
--transaction in the year 2020.)
Select  count(Cs.customer_id) As number_of_employee,
c.region_name
From Continent c
join Customers Cs on c.region_id = Cs.region_id
join Transactions t on cs.customer_id =t.customer_id
Where Year(t.txn_date) = 2020
group by
c.region_name;

--Task 2(Display the maximum and minimum transaction amount of each
--transaction Type)
select min(txn_amount) As Min_transaction,
max(txn_amount) As Max_transaction,
txn_type
From Transactions
Group By txn_type


--Task 3(Display the customer id, region name and transaction amount where
--transaction type is deposit and transaction amount > 2000.)
Select t.customer_id, c.region_name, t.txn_amount
From Customers  cs
join Continent c on cs.region_id= c.region_id
join Transactions t on cs.customer_id =t.customer_id
Where txn_type= 'deposit' And  txn_amount > 2000;

--Task 4 ( Find Duplicate Records in the Customer Table)
Select  customer_id, count(*) As duplicate_count
from Customers
Group By customer_id
Having count(*) > 1;

--Task 5(display the customer id, region name, transaction type and transaction
--amount for the minimum transaction amount in deposit.
Select Cs.customer_id,C.region_name,t.txn_type, t. txn_amount
From  Customers Cs
Join Continent C on  Cs.region_id= c.region_id
join Transactions t on cs.customer_id = t.customer_id;

--Task6 (Create a stored procedure to display details of customers in the
--Transaction table where the transaction date is greater than Jun 2020.)
Create Procedure Customerdetails_afterJune2020
As
Begin 
select * from Transactions
Where txn_date > '2020-06-01';

End;
--Check
Exec  Customerdetails_afterJune2020

--Task 7(Create a stored procedure to insert a record in the Continent table.)
Create Procedure Insertrecord_Continents
@region_id int,
@region_name varchar(255)
As 
Begin
    Set Nocount on
 Insert Into Continent
 values (@region_id, @region_name);
 End;

Exec Insertrecord_Continents 6, 'Australia'

-- Task 8(Create a stored procedure to display the details of transactions that
--happened on a specific day.)
Create Procedure details_OnSpecificday
@txn_date Date
As 
Begin 
Set Nocount on
select * from Transactions
where txn_date = @txn_date;
End;

exec details_OnSpecificday '2020-03-01'

--Task 9(Create a user defined function to add 10% of the transaction amount in a table.)
Create Function Add_10PercentOnTransactionamount()
Returns Table
As 
Return
(
Select Customer_id,
txn_date,
txn_type,
txn_amount* 1.10 As Newtxn_amount
From Transactions
);
--Check
select * from Add_10PercentOnTransactionamount()

--Task 10(Create a user defined function to find the total transaction amount for a
--given transaction type.)
Create Function Totaltransaction_amount
(
@txn_type Varchar(100)
)
RETURNS Money
As 
Begin
  Declare @TotalAmount Money;
  Select @TotalAmount = Sum(txn_amount)
  From Transactions
  Where txn_type =@txn_type;

  if @TotalAmount Is null
  Begin 
  Set @TotalAmount = 0;
  End;

  Return @TotalAmount
End;

Select dbo.Totaltransaction_amount ('deposit') As TotalDepositAmount

--Task 11(1. Create a table value function which comprises the columns customer_id,
--region_id ,txn_date , txn_type , txn_amount which will retrieve data from
--the above table.)
Create Function Fetching_data()
Returns Table
As 
Return
(Select C.customer_id, C.region_id,T.txn_date, T.txn_type, t.txn_amount
From Customers C
Join Transactions T on C.customer_id = T.customer_id
);


--Check
Select * from  Fetching_data()

--Task 12 ( Create a TRY...CATCH block to print a region id and region name in a
--single column)
Begin 
Try
Select Concat(region_id,'   ', Region_name) As RegionId_Name
From Continent
End 
Try
Begin Catch
  Print 'An Error Occured While Retrieving Region Information.';
End Catch;

--Task 13(Create a TRY...CATCH block to insert a value in the Continent Table)
Begin try
Insert Into Continent(region_name)
Values
('New continents')
End Try
Begin Catch
  Print 'Unable to Insert Record'
    PRINT ERROR_MESSAGE();
End Catch

--Task 14(Create a trigger to prevent deleting a table in a database)
CREATE TRIGGER PreventTableDeletion
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    RAISERROR ('Deleting tables in this database is not allowed.', 16, 1);
    ROLLBACK;
END;

--Check
DROP TABLE Continent

--Task 15(Create a trigger to audit the data in a table.)
Create Table Auditlog(
AuditLogId Int Primary Key Identity(1,1),
TableName Varchar(255),
Action Varchar(100),
Oldvalue varchar(max),
Newvalue varchar(max),
ModifiedDate DateTime
);

Create Trigger Auditchanges
On Customers
After Insert, Update, Delete
As 
Begin
  Declare @Action Varchar(100)
  If  exists (select * from inserted)
  Begin
    If Exists (Select * from Deleted)
	    Set @Action = 'Update';
	Else 
	    Set @Action = 'Insert';
End
Else
Begin
  Set @Action = 'Delete';
  End

  Insert Into Auditlog (TableName, Action, OldValue, NewValue, ModifiedDate)
    SELECT
        'Customers' AS TableName,
        @Action AS Action,
        CASE 
            WHEN @Action = 'INSERT' THEN NULL
            ELSE (SELECT * FROM deleted FOR XML AUTO, ELEMENTS)
        END AS OldValue,
        CASE 
            WHEN @Action = 'DELETE' THEN NULL
            ELSE (SELECT * FROM inserted FOR XML AUTO, ELEMENTS)
        END AS NewValue,
        GETDATE() AS ModifiedDate;
END;

-- Check
INSERT INTO customers (Customer_ID, Region_ID, start_date, End_Date)
VALUES (501, 7, '2024-01-01', '2024-02-27');

select * from Auditlog

--Task 16(Create a trigger to prevent login of the same user id in multiple pages.)
Create Trigger PreventMultipleLogins
on all Server
for logon
as  begin
declare @LoginName Varchar(50)
set @LoginName = Original_login()
if (select count(*) from sys.dm_exec_sessions 
Where  is_user_process = 1 and original_login_name= @LoginName)>3
Begin
print'Fourth Connection attempt by' + @loginName +'Blocked'
Rollback
end
end

drop trigger PreventMultipleLogins on all server

--17(Display top n customers on the basis of transaction type.)
Select Top 5 C.*,T.*
From Customers C
Join Transactions T on C.customer_id = T.customer_id
Where Txn_type = 'Deposit'
Order By T.Txn_amount Desc;



--18(Create a pivot table to display the total purchase, withdrawal and
--deposit for all the customers.)
Select * from(Select txn_type, txn_amount From Transactions) As Sourcetable
Pivot(Sum(txn_amount) For txn_type in([Purchase],[Withdrawal],[Deposit])) As PivotTable;








select * from continent
select * from customers
select * from Transactions Where

