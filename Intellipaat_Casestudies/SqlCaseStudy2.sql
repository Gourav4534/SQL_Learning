Create Database SqlCaseStudy2

--Location Table
CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');

-- Department Table
  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

--Job Table
CREATE TABLE JOB
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20)
);

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')

--Employee Table
CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

-- Simple Queries
--1 (. List all the employee details)
Select * 
From EMPLOYEE;

--2(List all the department details)
Select * 
From DEPARTMENT;

--3(List all job details)
Select *
From JOB;

--4 (List all the locations)
Select * 
From LOCATION

--5(List out the First Name, Last Name, Salary, Commission for allEmployees.)
Select First_Name,
Last_Name,
Salary,
Comm
From EMPLOYEE;

--6(List out the Employee ID, Last Name, Department ID for all employees and
--alias
--Employee ID as "ID of the Employee", Last Name as "Name of the
--Employee", Department ID as "D)
select employee_id as [ID of the Employee],
last_name as [Name of the Employee],
Department_id as Dep_id
From EMPLOYEE;

--7(List out the annual salary of the employees with their names only)
select  Salary * 12 As Annual_Salary,
First_Name,
Last_Name
From Employee;


-- Where Condition
--1(List the details about "Smith")
Select *
From employee
Where LAST_NAME='Smith';
	
--2(List out the employees who are working in department 20)
Select *
from EMPLOYEE
Where DEPARTMENT_ID =20;

--3(List out the employees who are earning salaries between 3000 & 4500)
select *
From EMPLOYEE
Where SALARY Between 3000 and 4500;

--4 (List out the employees who are working in department 10 or 30)
Select *
From EMPLOYEE
Where DEPARTMENT_ID = 10 Or DEPARTMENT_ID= 20;

--5 (Find out the employees who are not working in department 10 or 30)
Select *
From Employee
Where DEPARTMENT_ID Not In (10,30);

--6 (List out the employees whose name start with S)
select *
From EMPLOYEE
where Last_Name like 'S%';

--7(List out the employees whose name starts with 'S' and end with 'H')
select *
From EMPLOYEE
where Last_Name like 'S%' OR last_name  Like '%H';

--8(List out the employees whose name length is 4 and start with 's')
Select *
From EMPLOYEE
Where Len(Last_name)= 4 And last_name like 's%';


--9(List out employees who are working in department 10 and draw salaries more than 3500)
select *
From EMPLOYEE
Where DEPARTMENT_ID= 10 And Salary > 3500;

--10(. List out the employees who are not receiving commission)
Select *
From EMPLOYEE
Where Comm Is Null;

-- ORDER BY CLAUSE
--1(. List out the Employee ID and Last Name in ascending order based on the
--Employee ID.)
select Employee_id,
last_name
 From EMPLOYEE
Order By EMPLOYEE_ID Asc;

--2(List out the Employee ID and Name in descending order based on salary)
select Employee_id,
concat(first_name,' ',Last_name),
salary
From employee
order by salary desc;

--3(List out the employee details according to their Last Name in ascending-order)
select * 
from employee
Order by LAST_NAME Asc;

--4(. List out the employee details according to their Last Name in ascending
--order and then Department ID in descending Order)
select *
From EMPLOYEE
order by LAST_NAME Asc, Department_id Desc;

-- Group By & Having Clause

--1(How many employees are in different departments in the organization)
Select D.Department_Id,
D.Name As Department_Name,
count(E.Employee_id) As Employee_count
From employee E
Join Department D on E.department_id= D.department_id
Group By
D.department_id,
D.Name;

--2(List out the department wise maximum salary, minimum salary and
--average salary of the employees)
Select 
D.Department_id,
D.Name,
max(E.salary) As Max_salary,
min(E.salary) As Min_salary,
avg(E.salary) As Avg_salary
From EMPLOYEE E
Join Department D On E.Department_id = D.Department_id
Group by
D.department_id,
D.Name;



--3( List out the job wise maximum salary, minimum salary and average
--salary of the employees)
Select 
J.job_id,
J.designation,
max(E.salary) As Max_salary,
min(E.salary) As Min_salary,
avg(E.salary) As Avg_salary
From EMPLOYEE E
Join JOB J On E.JOB_ID = E.JOB_ID
Group by
J.JOB_ID,
J.DESIGNATION;

--4(List out the number of employees who joined each month in ascending order)
select 
count(employee_id) As Employee_Count,
Datepart (Month, Hire_Date) As Joining_month,
Datepart (Year, Hire_Date) As Joining_year
From EMPLOYEE
Group BY
Hire_date
Order By Hire_Date Asc;

--5(List out the number of employees for each month and year in
--ascending order based on the year and month)
Select 
count(EMPLOYEE_id) As number_ofemployee,
Month(Hire_date),
Year(Hire_date)
From EMPLOYEE
Group By
HIRE_DATE
Order By HIRE_DATE Asc;

--6 (List out the Department ID having at least four employees)
select Count(EMPLOYEE_id) As Employee_count,
DEPARTMENT_id
From EMPLOYEE
Group By DEPARTMENT_ID
Having count(DEPARTMENT_ID) >= 4;

--7(How many employees joined in the month of January)
Select 
Count(EMPLOYEE_ID) AS JANUARY_JOIN_COUNT
FROM 
Employee
WHERE 
MONTH(HIRE_DATE) = 1;

--8(How many employees joined in the month of January or September)
SELECT 
COUNT(EMPLOYEE_ID) AS JANUARY_JOIN_COUNT
FROM 
EMPLOYEE
WHERE 
MONTH(HIRE_DATE) In (1,9);

--9(How many employees joined in 1985)
Select count(Employee_id) As Joined_In1985
From
EMPLOYEE
Where 
Year( Hire_Date) = 1985
  
--10(How many employees joined each month in 1985)
SELECT 
MONTH(Hire_date) AS Join_Month,
YEAR(Hire_date) As Join_year,
COUNT(Employee_id) AS Employees_Joined
FROM Employee
WHERE  YEAR(Hire_date) = 1985
GROUP BY 
MONTH(Hire_date),
YEAR(Hire_date);

--11(How many employees joined in March 1985)
Select
Count(employee_id) As Joined_Inmarch1985
From
Employee
Where year(hire_date) =1985 And Month(Hire_date) =3;

--12( Which is the Department ID having greater than or equal to 3 employees
--joining in April 1985?)
Select DEPARTMENT_id,
Count(Employee_id) As Joined_inApril1985
From EMPLOYEE
Where
year(Hire_date) =1985 And Month(Hire_date)= 4
Group by 
DEPARTMENT_ID
Having
Count(employee_id) >= 3;

--Joins:
--1(List out employees with their department names)
select e.*,d.Name  as Department_name
From Employee e
Join department d on e.department_id = d.Department_Id; 

--2( Display employees with their designation)
select e.*,j.DESIGNATION
From Employee e
Join Job j on e.JOB_ID = j.job_id; 

--3(Display the employees with their department names and regional groups)
Select e.*,d.Name  as Department_name, L.City
From EMPLOYEE E
Join Department D on e. DEPARTMENT_ID=d.Department_Id
Join Location L on  d.Location_Id = l.Location_ID;

--4 ( How many employees are working in different departments? Display with
--department names.)
Select Count(e.EMPLOYEE_id) As Number_ofemployee,
d.Department_id,
d.Name
From Employee e
Inner Join department d on e.department_id = d.department_id
Group by
d.Department_Id,
d.Name;


--5(How many employees are working in the sales department)
select count(e.EMPLOYEE_ID) As number_of_employee,
d.Department_id,
d.Name
from EMPLOYEE e
Inner Join DEPARTMENT d on e.DEPARTMENT_ID= d.Department_Id
Where D.name = 'Sales'
group by
d.Department_Id,
d.Name

--6 (Which is the department having greater than or equal to 5
--employees? Display the department names in ascending
--order.)
select count(e.EMPLOYEE_ID) As number_of_employee,
d.Department_id,
d.Name
from EMPLOYEE e
Inner Join DEPARTMENT d on e.DEPARTMENT_ID= d.Department_Id
group by 
d.Department_id,
d.Name
Having count(e.EMPLOYEE_ID) >= 5
Order By D.name Asc;


--7(How many jobs are there in the organization? Display with designations)
Select COUNT(*) AS num_of_jobs, Designation
From Job
Group By Designation

--8(How many employees are working in "New York"?)
select count(e.EMPLOYEE_ID) As number_of_employee,
d.Department_id,
d.Name,
l.location_id,
l.City
from EMPLOYEE e
Inner Join DEPARTMENT d on e.DEPARTMENT_ID= d.Department_Id
Inner Join Location l on d.Location_Id= l.Location_ID
group by 
d.Department_id,
d.Name,
l.location_id,
l.City
Having  l.city = 'New York ';

--9(Display the employee details with salary grades. Use conditional statementto
--create a grade column)
Select
employee_id,
salary,
CASE
    WHEN salary >= 2500 THEN 'A'
    WHEN salary >= 2000  THEN 'B'
    WHEN salary >= 1000  THEN 'C'
    WHEN salary >= 800 THEN 'D'
    ELSE 'E'
    END As salary_grade
From
employee;

--10(List out the number of employees grade wise. Use conditional statementto
--create a grade column)
SELECT *,
CASE
   WHEN DEPARTMENT_ID = 10 THEN ' A'
   WHEN DEPARTMENT_ID = 20 THEN ' B'
   WHEN DEPARTMENT_ID = 30 THEN ' C'
   WHEN DEPARTMENT_ID = 40 THEN ' D'
   ELSE ' E'
   END AS EMPLOYEE_GRADE
FROM EMPLOYEE;

--11(Display the employee salary grades and the number of employees
--between 2000 to 5000 range of salary)
select 
employee_id,
salary,
case
  WHEN salary >= 2500 THEN 'A'
    WHEN salary >= 2000  THEN 'B'
    WHEN salary >= 1000  THEN 'C'
    WHEN salary >= 800 THEN 'D'
    ELSE 'E'
End As Salary_grade
from employee
where  salary Between 2000 And 5000;



--12(Display all employees in sales or operation departments)
Select
e.employee_id,
e.first_name,
e.last_name,
d.Name
From employee E
Inner Join department d on e.department_id= d.department_id
Where d.name In ('Sales','operations')

--Set Operator
--1 (. List out the distinct jobs in sales and accounting departments)
Select distinct j.designation,
d.Name
from employee e
join department d on e.DEPARTMENT_ID= d.Department_Id
join job j on e.JOB_ID=j.JOB_ID
where D.Name In ('Sales','Accounting');

--2(List out all the jobs in sales and accounting departments)
Select d.Name,
j.designation
from employee e
join department d on e.DEPARTMENT_ID= d.Department_Id
join job j on e.JOB_ID=j.JOB_ID
where D.Name In ('Sales','Accounting');


--3(List out the common jobs in research and accounting
--departments in ascending)
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Research'
INTERSECT
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Accounting'
ORDER BY Designation ASC;

-- subqueries
--1(Display the employees list who got the maximum salary)
Select *
From employee
where salary = (select  max(salary) from EMPLOYEE);

--2(Display the employees who are working in the sales Department)
select *
from employee
where DEPARTMENT_ID = (Select DEPARTMENT_ID from department where name='sales');

--3(Display the employees who are working as 'Clerk)
select *
from employee
where JOB_ID = (Select JOB_ID from JOB where DESIGNATION='clerk');

--4(Display the list of employees who are living in "New York")
select *
from employee
Where DEPARTMENT_ID In (
 Select Department_Id
 from DEPARTMENT
 Where Location_Id in(
   select Location_Id
   from LOCATION
   where city = 'New York'
   )
);

--5(Find out the number of employees working in the sales)
select count(*) As Number_of_Employee
from EMPLOYEE
Where DEPARTMENT_ID In (select DEPARTMENT_ID from DEPARTMENT where name='Sales');


--6(Update the salaries of employees who are working as clerks on the basis of
--10%.)
update  EMPLOYEE
Set Salary = salary * 1.1
Where job_id In (Select Job_id From Job Where Designation ='Clerk');

--7( Delete the employees who are working in the accounting department)
Delete EMPLOYEE
Where DEPARTMENT_ID In ( Select Department_id from DEPARTMENT where Name='Accounting');

--8(Display the second highest salary drawing employee details)
WITH RankedEmployees AS (
 SELECT *, ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS RowNum
    FROM EMPLOYEE
)
SELECT *
FROM RankedEmployees
WHERE RowNum = 2;


--9(Display the nth highest salary drawing employee details)
Declare @n int = 3; -- nth 

WITH RankedEmployees AS (
 SELECT *, ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS RowNum
    FROM EMPLOYEE
)
SELECT *
FROM RankedEmployees
WHERE RowNum = @n;

--10(List out the employees who earn more than every employee in department 30)
Select *
from EMPLOYEE 
Where Salary > All (Select Salary From EMPLOYEE Where DEPARTMENT_ID= 30);

--11 (. List out the employees who earn more than the lowest salary in
--department.Find out whose department has no employees)
Select * 
From  Employee e
Where Salary >(Select  Min(Salary) From EMPLOYEE Where DEPARTMENT_ID= E.department_id);


--12(Find out which department has no employees)
Select d.Name As Department_name
From DEPARTMENT d
Left Join Employee E on D.Department_Id= E.DEPARTMENT_ID
Where E.EMPLOYEE_ID is null;

--13( Find out the employees who earn greater than the average salary for
--their department)
Select *
From EMPLOYEE e
Where Salary > (Select Avg(Salary) From EMPLOYEE Where DEPARTMENT_ID=E.department_id);









