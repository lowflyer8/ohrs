DROP DATABASE IF EXISTS CompanyDB;
CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Department (
    Deptno INT PRIMARY KEY,
    Dname VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL
);

INSERT INTO Department (Deptno, Dname, Location) VALUES
(10, 'Accounting', 'Mumbai'),
(20, 'Research', 'Pune'),
(30, 'Sales', 'Nashik'),
(40, 'Operations', 'Nagpur');

CREATE TABLE Employee (
    Empno INT PRIMARY KEY,
    Ename VARCHAR(100) NOT NULL,
    Job VARCHAR(50),
    Mgr INT,
    Joined_date DATE,
    Salary DECIMAL(12,2),
    Commission DECIMAL(12,2),
    Deptno INT,
    Address VARCHAR(100),
    FOREIGN KEY (Deptno) REFERENCES Department(Deptno)
);

-- Insert records into Employee table
INSERT INTO Employee (Empno, Ename, Job, Mgr, Joined_date, Salary, Commission, Deptno, Address) VALUES
(1001, 'Nilesh Joshi',     'Clerk',     1005, '1995-12-17', 2800,  600,   20, 'Nashik'),
(1002, 'Avinash Pawar',    'Salesman',  1003, '1996-02-20', 5000, 1200,   30, 'Nagpur'),
(1003, 'Amit Kumar',       'Manager',   1004, '1986-04-02', 2000,  NULL,  30, 'Pune'),
(1004, 'Nitin Kulkarni',   'President', NULL, '1986-04-19', 50000, NULL,  10, 'Mumbai'),
(1005, 'Niraj Sharma',     'Analyst',   1003, '1998-12-03', 12000, NULL,  20, 'Satara'),
(1006, 'Pushkar Deshpande','Salesman',  1003, '1996-09-01', 6500, 1500,   30, 'Pune'),
(1007, 'Sumit Patil',      'Manager',   1004, '1991-05-01', 25000, NULL,  20, 'Mumbai'),
(1008, 'Ravi Sawant',      'Analyst',   1007, '1995-11-17', 10000, NULL, NULL, 'Amaravati');

-- 1) Display employee information (with column aliases)
SELECT Empno AS Employee_ID,
       Ename AS Employee_Name,
       Job,
       Mgr,
       Joined_date AS Joining_Date,
       Salary,
       Commission,
       Deptno,
       Address
FROM Employee;

-- 2) Display unique jobs from the Employee table
SELECT DISTINCT Job FROM Employee;	

-- 3) Change location of department 40 to 'Bangalore'
UPDATE Department
SET Location = 'Bangalore'
WHERE Deptno = 40;
select * from Department;

-- 4) Change the name of employee 1003 to 'Nikhil Gosavi'
UPDATE Employee
SET Ename = 'Nikhil Gosavi'
WHERE Empno = 1003;
select * from Employee;

-- 5) Delete 'Pushkar Deshpande' from Employee table
DELETE FROM Employee
WHERE Ename = 'Pushkar Deshpande';

-- 6) Display all employees whose job title is either 'Manager' or 'Analyst'	
-- Using OR
SELECT * FROM Employee
WHERE Job = 'Manager' OR Job = 'Analyst';

-- Using IN
SELECT * FROM Employee
WHERE Job IN ('Manager', 'Analyst');

-- 7) Display employee name and department number of all employees in dept 10,20,30,40
SELECT Ename, Deptno
FROM Employee
WHERE Deptno IN (10,20,30,40);

-- 8) Find names and joining dates of employees whose names start with 'A'
SELECT Ename, Joined_date
FROM Employee
WHERE Ename LIKE 'A%';

-- 9) Find all employees whose second letter in name is 'i'
SELECT Ename
FROM Employee
WHERE LOWER(Ename) LIKE '_i%';

-- 10) Find department number and maximum salary where maximum salary > 5000
SELECT Deptno, MAX(Salary) AS Max_Salary
FROM Employee
GROUP BY Deptno
HAVING MAX(Salary) > 5000;

