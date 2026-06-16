CREATE TABLE EmployeeDetails (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(100),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(100)
);

CREATE TABLE EmployeeSalary (
    EmpId INT,
    Project VARCHAR(50),
    Salary DECIMAL(10,2),
    Variable DECIMAL(10,2),
    FOREIGN KEY (EmpId) REFERENCES EmployeeDetails(EmpId)
);

INSERT INTO EmployeeDetails
(EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES
(101, 'Alice Johnson', 321, '2022-05-15', 'New York'),
(102, 'Bob Smith', 876, '2020-03-12', 'Los Angeles'),
(103, 'Charlie Brown', 986, '2021-08-23', 'Chicago'),
(104, 'David Williams', 876, '2019-11-05', 'Houston'),
(105, 'Eve Davis', 321, '2023-01-07', 'Phoenix'),
(106, 'Frank Miller', 986, '2018-12-19', 'Philadelphia'),
(107, 'Grace Wilson', 876, '2022-03-28', 'San Antonio'),
(108, 'Hank Moore', 321, '2021-09-14', 'San Diego'),
(109, 'Ivy Taylor', 986, '2020-02-11', 'Dallas'),
(110, 'Jack Anderson', 876, '2022-11-30', 'San Jose'),
(111, 'Karen Thomas', 321, '2021-07-16', 'Austin'),
(112, 'Liam Jackson', 986, '2023-04-21', 'Fort Worth'),
(113, 'Mia White', 876, '2019-06-03', 'Columbus'),
(114, 'Noah Harris', 321, '2020-12-10', 'Charlotte'),
(115, 'Olivia Martin', 986, '2021-10-25', 'San Francisco'),
(116, 'Paul Garcia', 876, '2023-07-18', 'Indianapolis'),
(117, 'Quinn Martinez', 321, '2022-09-07', 'Seattle'),
(118, 'Rachel Rodriguez', 986, '2020-01-15', 'Denver'),
(119, 'Steve Clark', 876, '2021-03-19', 'Washington'),
(120, 'Tina Lewis', 321, '2019-08-31', 'Boston');

INSERT INTO EmployeeSalary
(EmpId, Project, Salary, Variable)
VALUES
(101, 'P1', 7500, 500),
(102, 'P2', 9200, 700),
(103, 'P1', 6700, 600),
(104, 'P3', 8300, 900),
(105, 'P2', 7800, 800),
(106, 'P3', 9100, 1000),
(107, 'P1', 6200, 400),
(108, 'P2', 8800, 750),
(109, 'P3', 9500, 1100),
(110, 'P1', 7200, 650),
(111, 'P2', 8700, 850),
(112, 'P3', 9300, 1200),
(113, 'P1', 7900, 550),
(114, 'P2', 6800, 450),
(115, 'P3', 8400, 900),
(116, 'P1', 7600, 500),
(117, 'P2', 8900, 1000),
(118, 'P3', 9200, 1100),
(119, 'P1', 8100, 600),
(120, 'P2', 8300, 750);

select * from EmployeeDetails;
select * from EmployeeSalary;

--PART-1 
--Q1)SQL Query to fetch records that are present in one table but not in another table.
select E.* from EmployeeDetails E LEFT JOIN EmployeeSalary S on E.EmpId = S.EmpId where S.EmpId IS NULL; 

--Q2)SQL query to fetch all the employees who are not working on any project. 
select E.* from EmployeeDetails E LEFT JOIN EmployeeSalary S on E.EmpId = S.EmpId where S.Project IS NULL; 

--Q3)SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020. 
select * from EmployeeDetails where year(DateOfJoining)=2020;

--Q4)Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary. 
select E.EmpId,E.FullName from EmployeeDetails E inner join EmployeeSalary S on E.EmpId = S.EmpId;

--Q5)Write an SQL query to fetch a project-wise count of employees. 
SELECT Project,COUNT(*) AS Employee_Count FROM EmployeeSalary GROUP BY Project;

--Q6)Fetch employee names and salaries even if the salary value is not present for the employee. 
SELECT E.FullName,
       S.Salary
FROM EmployeeDetails E
LEFT JOIN EmployeeSalary S
ON E.EmpId = S.EmpId;

--Q7)Write an SQL query to fetch all the Employees who are also managers.
SELECT *
FROM EmployeeDetails
WHERE EmpId IN
(
   SELECT DISTINCT ManagerId
   FROM EmployeeDetails
);

--Q8)Write an SQL query to fetch duplicate records from EmployeeDetails. 
SELECT EmpId,
       FullName,
       ManagerId,
       DateOfJoining,
       City,
       COUNT(*) AS Duplicate_Count
FROM EmployeeDetails
GROUP BY EmpId, FullName, ManagerId, DateOfJoining, City
HAVING COUNT(*) > 1;

--Q9)Write an SQL query to fetch only odd rows from the table. 
SELECT * FROM
(
   SELECT *, ROW_NUMBER() OVER(ORDER BY EmpId) AS RowNum
   FROM EmployeeDetails
) X
WHERE RowNum % 2 = 1;

--Q10)Write a query to find the 3rd highest salary from a table without top or limit keyword.
SELECT DISTINCT Salary
FROM EmployeeSalary S1
WHERE 2 =
(
   SELECT COUNT(DISTINCT Salary)
   FROM EmployeeSalary S2
   WHERE S2.Salary > S1.Salary
);

-----------------------------------------------------------------------------------------------------------------------------------------
--PART- 2 
--Ques.1. Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – "986‟. 
select EmpId,FullName from EmployeeDetails where ManagerId = '986';

--Ques.2. Write an SQL query to fetch the different projects available from the EmployeeSalary table. 
select DISTINCT project from EmployeeSalary;

--Ques.3. Write an SQL query to fetch the count of employees working in project „P1‟.
select count(*) as Emp_Count from EmployeeSalary where Project='P1'; 

--Ques.4. Write an SQL query to find the maximum, minimum, and average salary of the employees.
SELECT
MAX(Salary) AS Maximum_Salary,
MIN(Salary) AS Minimum_Salary,
AVG(Salary) AS Average_Salary
FROM EmployeeSalary;

--Ques.5. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.
select EmpId,Salary from EmployeeSalary where Salary between 9000 and 15000;

--Ques.6. Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.
select * from EmployeeDetails where City = 'Toronto' and  ManagerId = '321';

--Ques.7. Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321. 
select * from EmployeeDetails where City = 'California' or  ManagerId = '321';

--Ques.8. Write an SQL query to fetch all those employees who work on Projects other than P1. 
Select * from EmployeeSalary where Project != 'P1';

--Ques.9. Write an SQL query to display the total salary of each employee adding the Salary with Variable value.
select EmpId,Salary,Variable,Salary+Variable as Total_Salary from EmployeeSalary;

--Ques.10. Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters.
SELECT * FROM EmployeeDetails WHERE FullName LIKE '__hn%';

-------------------------------------------------------------------------------------------------------------------------------------------
--PART - 3 
--Ques.1 Write an SQL query to fetch all the EmpIds which are present in either of the tables – „EmployeeDetails‟ and „EmployeeSalary‟. 
SELECT EmpId FROM EmployeeDetails  UNION  SELECT EmpId FROM EmployeeSalary;

--Ques.2 Write an SQL query to fetch common records between two tables. 
SELECT E.EmpId,
       E.FullName,
       S.Project,
       S.Salary
FROM EmployeeDetails E
INNER JOIN EmployeeSalary S
ON E.EmpId = S.EmpId;

--Ques.3. Write an SQL query to fetch records that are present in one table but not in another table. 
SELECT E.* FROM EmployeeDetails E
LEFT JOIN EmployeeSalary S
ON E.EmpId = S.EmpId
WHERE S.EmpId IS NULL;

--Ques.4. Write an SQL query to fetch the EmpIds that are present in both the tables –  „EmployeeDetails‟ and „EmployeeSalary. 
SELECT E.EmpId
FROM EmployeeDetails E
INNER JOIN EmployeeSalary S
ON E.EmpId = S.EmpId;

--Ques.5. Write an SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary. 
SELECT E.EmpId
FROM EmployeeDetails E
LEFT JOIN EmployeeSalary S
ON E.EmpId = S.EmpId
WHERE S.EmpId IS NULL;

--Ques.6. Write an SQL query to fetch the employee‟s full names and replace the space 
SELECT FullName,
       REPLACE(FullName,' ','_') AS Modified_Name
FROM EmployeeDetails;

--Ques.7. Write an SQL query to fetch the position of a given character(s) in a field.
SELECT FullName,
       CHARINDEX('a', FullName) AS Position_Of_A
FROM EmployeeDetails;

--Ques.8. Write an SQL query to display both the EmpId and ManagerId together. 
SELECT CONCAT(EmpId,' - ',ManagerId)
AS Employee_Manager
FROM EmployeeDetails;

--Ques.9. Write a query to fetch only the first name(string before space) from the FullName column of the EmployeeDetails table. 
SELECT FullName,
       LEFT(FullName,
       CHARINDEX(' ',FullName)-1)
       AS First_Name
FROM EmployeeDetails;

--Ques.10. Write an SQL query to uppercase the name of the employee and lowercase the city values. 
SELECT
UPPER(FullName) AS Employee_Name,
LOWER(City) AS City
FROM EmployeeDetails;

-----------------------------------------------------------------------------------------------------------------------------------------
--PART - 4 
--Ques.1. Write an SQL query to find the count of the total occurrences of a particular character – „n‟ in the FullName field. 
SELECT FullName, LEN(FullName) - LEN(REPLACE(LOWER(FullName),'n','')) AS Count_Of_N FROM EmployeeDetails;

--Ques.2. Write an SQL query to update the employee names by removing leading and trailing spaces. 
UPDATE EmployeeDetails SET FullName = LTRIM(RTRIM(FullName));

--Ques.3. Fetch all the employees who are not working on any project.
SELECT E.*
FROM EmployeeDetails E
LEFT JOIN EmployeeSalary S
ON E.EmpId = S.EmpId
WHERE S.Project IS NULL;

--Ques.4. Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and less than or equal to 10000. 
select E.Fullname,S.Salary from EmployeeDetails E inner join EmployeeSalary S 
on E.EmpId = S.EmpId where S.Salary BETWEEN 5000 AND 10000; 

--Ques.5. Write an SQL query to find the current date-time. 
select GETDATE() as Current_date_time;

--Ques.6. Write an SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2020. 
SELECT * FROM EmployeeDetails WHERE YEAR(DateOfJoining) = 2020;

--Ques.7. Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table. 
SELECT E.*
FROM EmployeeDetails E
INNER JOIN EmployeeSalary S
ON E.EmpId = S.EmpId;

--Ques.8. Write an SQL query to fetch the project-wise count of employees sorted by project‟s count in descending order. 
SELECT Project,
       COUNT(*) AS Employee_Count
FROM EmployeeSalary
GROUP BY Project
ORDER BY Employee_Count DESC;

--Ques.9. Write a query to fetch employee names and salary records. Display the employee details even if the salary record is not present for the employee. 
SELECT E.FullName,
       S.Salary
FROM EmployeeDetails E
LEFT JOIN EmployeeSalary S
ON E.EmpId = S.EmpId;

--Ques.10. Write an SQL query to join 3 tables.
CREATE TABLE Department(
    DeptId INT,
    EmpId INT,
    DeptName VARCHAR(50)
);

SELECT E.EmpId,
       E.FullName,
       S.Project,
       D.DeptName
FROM EmployeeDetails E
INNER JOIN EmployeeSalary S
ON E.EmpId = S.EmpId
INNER JOIN Department D
ON E.EmpId = D.EmpId;
