-- Task 1 (Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick
--Chicken Bites)
Create Function Convert_QuickChickenBites(@Quickbites Varchar(100))
Returns varchar(100)
As
Begin 
Declare @QuickChickenBites varchar(100) 
Set @QuickChickenBites = Replace( @QuickBites, 'Quick Bites','Quick Chicken Bites');
Return @QuickchickenBites
End;

SELECT dbo.Convert_QuickChickenBites('Quick Chicken Bites.') AS ModifiedName;


-- Task 2(Use the function to display the restaurant name and cuisine type which has the
--maximum number of rating.)
Select RestaurantName,CuisinesType, Max(No_of_Rating) As Max_Rating
From Jomato
Group By 
RestaurantName,
CuisinesType,
No_of_Rating
Order by No_of_rating Desc;


--Task 3( Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
--start rating, ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3
--and below 3.5 and ‘Bad’ if it is below 3 ster rating.)

Select *,
Case When Rating > 4 Then 'Excellent'
When Rating >3.5 Then 'Good'
When Rating > 3 Then 'Average'
Else 'Bad'
End  As RatingStatus
From Jomato;



--Task 4 Find the Ceil, floor and absolute values of the rating column and display the current date
--and separately display the year, month_name and day.)

Select Rating,
CEILING(Rating) As Ceil_rating,
Floor(Rating) As Floor_Rating,
Abs(Rating) As Abs_Rating,
Getdate() AS CurrentDate,
Year(Getdate()) As CurrentYear,
DateName(Month, GetDate()) As CurrentMonthName,
Day(Getdate()) As CurrentDay
From Jomato;


--Task 5(Display the restaurant type and total average cost using rollup)
Select RestaurantType,
Sum(AverageCost) As TotalAverageCost
From Jomato
Group By
Rollup (RestaurantType)












