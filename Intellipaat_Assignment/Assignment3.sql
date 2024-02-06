--Task 1(Create a stored procedure to display the restaurant name, type and cuisine where the
--table booking is not zero)
Create Procedure TableBooking_isnotzero
@Tablebooking Varchar(100)
As
Select RestaurantName,
Restauranttype,
CuisinesType,
TableBooking
From Jomato
Where TableBooking= @Tablebooking;

Exec TableBooking_isnotzero @Tablebooking='Yes';

select * from jomato

--Task2(Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result
--and rollback it.

Begin Transaction
Update Jomato
Set CuisinesType='Cafeteria'
Where CuisinesType ='Cafe'

Select * from jomato where CuisinesType= 'Cafeteria';
--Rollback
Rollback Transaction
-- After Rollback
Select * from jomato where CuisinesType= 'Cafe';


--Task 3(Generate a row number column and find the top 5 areas with the highest rating of
--restaurants)
Select Top 5 Area,
RestaurantName,
RestaurantType,
Rating,
ROW_NUMBER() Over (Order By Max(Rating) Desc) As HighestRating
From Jomato
Group By Area,
RestaurantName,
RestaurantType,
Rating;

--Task 4(Use the while loop to display the 1 to 50)
Declare @i Int = 1;
While @i <= 50
Begin
  Print @i;
  Set @i = @i + 1;
End;

--Task 5(Write a query to Create a Top rating view to store the generated top 5 highest rating of
--restaurants.)
Create View TopRating_view 
As
Select Top 5 *
From (Select *, Row_number() Over (Order By Rating Desc) As Rating_Rank
From 
Jomato ) As Ranked_Restaurants

Select * From TopRating_view

--Task 6(Write a trigger that sends an email notification to the restaurant owner whenever a new
--record is inserted)
Create Trigger SendInsert_Email
On Jomato
After Insert
As
Begin 
Declare @RestaurantName Varchar(255);
Declare @Email Varchar(255);

Select @RestaurantName = RestaurantName,  @Email= 'Owner@gmail.com'
From inserted;

Exec msdb.dbo.sp_send_dbmail @recipients = @Email, @subject = 'New Record Inserted', @body = 'A new record has been inserted for your restaurant';
End;
 
 
