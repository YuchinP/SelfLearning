/* Find the max salary from a table*/
SELECT MAX(Salary) 
FROM Employees order by Salary desc;

/*Find the 2nd highest salary*/
SELECT Salary 
FROM Employees 
WHERE Salary < (SELECT MAX(Salary) FROM Employees);

/*Find the nth highest salary*/
SELECT TOP 1 Salary FROM
(SELECT DISTINCT TOP 3 Salary
FROM Employees
ORDER BY Salary Desc)
Result
ORDER BY Salary
/* You can replace '3' With N of any Salary we are interested in*/

/*Using CTE (Common Table Expression)*/
WITH CTERESULT AS
(
SELECT Salary, DENSE_RANK() over (ORDER BY Salary DESC) AS DENSERANK
FROM Employees
)

SELECT TOP 1 Salary
FROM CTERESULT
WHERE CTERESULE.DENSERANK = 2;
/* 2 can be replaced with any rank we are interested in*/
/* We can also replace DENSE_RANK with ROW_NUMBER which will order them, but duplicates will have several #s of different ranks*/



/*Complete organization hierarchy based on an ID*/

/* Usage of a CTE*/
DECLARE @ID int;
SET @ID =7;
/*We put who every's ID we want to check into the Variable*/

WITH EmployeeCTE AS
(
	--Anchor
	SELECT EmployeeID, EmployeeName, ManagerID
	FROM Employees
	WHERE EmployeeID = @ID

	UNION ALL

	--Recursive Member2
	SELECT Employees.EmployeeID, Employees.EmployeeName, Employees.ManagerID
	FROM Employees
	JOIN EmployeeCTE /*recursive CTE*/
	ON Employees.EmployeeID = EmployeeCTE.ManagerID
)

SELECT E1.EmployeeName, ISNULL(E2.EmployeeName, 'No Boss') AS ManagerName
FROM EmployeeCTE AS E1
LEFT JOIN EmployeeCTE AS E2
ON E1.ManagerID = E2.EmployeeID;

/*How does a Recursive CTE Work?*/
/*
Step 1: Execute the anchor part and get result R0 which is just David's info
Step 2: Execute the recursive member using R0 as input and generate result R1
Here we combine his manager's ID to the Recursive's Employee ID
Step 3: Execute the Recursive member using R1 as input and generate result R2
This gets done again connecting to get the Recursive's Employee ID
This is because it's a UNION ALL and will go through until the recursion ends
Step 4: Self joins the CTE with the CTE 
*/



/*Delete Duplicate rows except 1*/
WITH EmployeeCTE AS
(
	SELECT *, ROW_NUMBER() OVER(Partition BY ID ORDER BY ID) AS RowNumber
	FROM Employees
)
DELETE FROM EmployeeCTE WHERE RowNumber > 1

SELECT * FROM EmployeeCTE





/*Find Employees hired in last n months*/
SELECT *, DATEDIFF(MONTH, HireDate, GETDATE()) AS Diff
FROM Employees
WHERE DATEDIFF(MONTH, HireDate, GETDATE()) between 1 and 3
ORDER BY HireDate desc
/* You can adjust the N in the between areas
We can also change the parameter in the DATEDIFF parameter to days/years etc*/





/* Transform Rows into Columns
Usage of the pivot operator*/
SELECT Country, City1, City2, City3
(	
	SELECT	Country, City, 
			'City' + CAST(ROW_NUMBER() OVER (Partition BY Country ORDER BY Country) AS Varchar(10)) AS ColumnSequence
	FROM	Countries
)Temp --alias
PIVOT
(--Inorder to satisfy the PIVOT query we need an aggregate function like MAX despite it not meaning anything for this query
	MAX(City)
	FOR ColumnSequence in (City1, City2, City3)
)PIV --alias
--We added City to the RowNumber so it's more explicit however we had to cast it to varchar so it would be a string over bigint
--This is used later in the PIVOT usage 





/*SQL query to find rows that contain only numerical data*/
SELECT Value FROM TestTable WHERE ISNUMERIC(Value) = 1;




/*Find Department name with highest number of employees*/
SELECT TOP 1 Departmentname, COUNT(*) AS EmployeeCount
FROM Employees
JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID
GROUP BY DepartmentName 
ORDER BY EmployeeCount DESC;
--If we need to remove the EmployeeCount from the query just throw the aggregate in the ORDERBY


/*A real-life example of right join*/
SELECT DepartmentName, COUNT(Employees.departmentID) AS TotalEmployees
FROM Employees
RIGHT JOIN Departments
ON Departments.DepartmentID = Employees.DepartmentID
GROUP BY DepartmentName
ORDER BY TotalEmployees


/* Retrieve all names that start with a given letter without a like operator*/
SELECT * FROM Students WHERE Name like 'M%'
--General solution but we're doing this without the like operator--

--Possible functions to use
SELECT * FROM Students WHERE CharIndex('M', Name) = 1;
SELECT * FROM Students WHERE LEFT(Name,1) = 'M';
SELECT * FROM Students WHERE SUBSTRING(Name,1,1) = 'M';



