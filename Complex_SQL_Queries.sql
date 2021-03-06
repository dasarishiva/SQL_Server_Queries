
--Second Highest Value
	--option 1
	select top 1 SalesOrderDetailID from (
		SELECT top 2 SalesOrderDetailID 
		FROM Sales.SalesOrderDetail
		order by SalesOrderDetailID desc
		) AS temp
	order by SalesOrderDetailID
	
	--option 2
	select min(SalesOrderDetailID) from (
		SELECT top 2 SalesOrderDetailID 
		FROM Sales.SalesOrderDetail
		order by SalesOrderDetailID desc
		) AS temp


--Finding all the duplicate records in a table.

	--option 1
	SELECT sod.SalesOrderID, COUNT(1) As duplicate_count
		FROM Sales.SalesOrderDetail sod
	GROUP BY SalesOrderID
	HAVING COUNT(SalesOrderID) > 1

--Deleting all the duplicate recrods in a table.
	;with CTE as
	(
		select Id,city,[state],
			row_number() over (partition by City,[state] order by City) as CityNumber 
			from [CityMaster]
	)
	delete from CTE where CityNumber >1

--Query to fetch first record from a table
	Select top 1 * from Sales.SalesOrderDetail

--Using partition & over caluse
	select name, salary, gender
		, count(gender) over (partition by gender) as gender
		, avg(salary) over (partition by gender) as avgsal
		, min(salary) over (partition by gender) as minsal
		, max(salary) over (partition by gender) as maxsal
	from employees

--Using rownumber() ... require over & order by caluses
	select * From	
		(select LoginID, OrganizationLevel, gender
			, ROW_NUMBER() over (partition by gender order by gender) as rownum
		from HumanResources.Employee
		) as t
	where rownum < 4

-- print even & rows from empoyee table
	select * From	
		(select LoginID, OrganizationLevel, gender
			, ROW_NUMBER() over (partition by gender order by gender) as rownum
		from HumanResources.Employee
		) as t
	--where (rownum%2) = 0 --even
	where (rownum%2) = 1 --odd

-- create a table structure from another table
   SELECT * 
   into #emp
   FROM HumanResources.Employee 
   WHERE 1=2

-- select last 50% of the records from employee table
	select * from (
		select *, 
			ROW_NUMBER() over(order by BusinessEntityID) as rownum
		from HumanResources.Employee
		) as temp
	where rownum > (select count(*)/2 from HumanResources.Employee)

-- select only common records from two tables 
-- intersect does check all the columns where as inner join does only on defined columns.
	select * from HumanResources.Employee
	intersect
	select * from HumanResources.Employee

-- year filter
	select * from HumanResources.Employee 
		WHERE DATEPART(YEAR, HireDate) = 2007

--printing patterns
	declare @i int =1

	WHILE @i <4
		BEGIN
			print replicate('*',@i)
			SET @i +=1
		END

	SELECT * FROM HumanResources.JobCandidate

--end

 
