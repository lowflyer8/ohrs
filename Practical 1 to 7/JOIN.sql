DROP DATABASE IF EXISTS EmployeeDB;
CREATE DATABASE EmployeeDB;
USE EmployeeDB;

CREATE TABLE Employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE Company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary DECIMAL(10,2) CHECK (salary > 0),
    PRIMARY KEY (employee_name, company_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name) ON DELETE CASCADE,
    FOREIGN KEY (company_name) REFERENCES Company(company_name) ON DELETE CASCADE
);

CREATE TABLE Manages (
    employee_name VARCHAR(50) PRIMARY KEY,
    manager_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name)
);

INSERT INTO Employee VALUES
('John', '12 Main St', 'Gotham'),
('Alice', '9 Park Ave', 'Metropolis'),
('Bob', '55 King Rd', 'Gotham'),
('Emma', '7 Queen St', 'Star City'),
('David', '2 Green Ln', 'Metropolis'),
('Sophia', '44 Palm Rd', 'Star City');

INSERT INTO Company VALUES
('First Bank Corporation', 'Metropolis'),
('Small Bank Corporation', 'Star City'),
('Global Tech Ltd', 'Gotham');

INSERT INTO Works VALUES
('John', 'First Bank Corporation', 12000),
('Alice', 'First Bank Corporation', 9500),
('Bob', 'Small Bank Corporation', 8000),
('Emma', 'Small Bank Corporation', 7000),
('David', 'Global Tech Ltd', 15000),
('Sophia', 'Global Tech Ltd', 11000);

INSERT INTO Manages VALUES
('John', 'David'),
('Alice', 'John'),
('Bob', 'Sophia'),
('Emma', 'Bob'),
('David', 'John'),
('Sophia', 'David');

-- Q1. Find the names of employees who work for First Bank Corporation.

SELECT employee_name
FROM Works
WHERE company_name = 'First Bank Corporation';


-- Q2. Find the names and cities of residence of all employees who work for First Bank Corporation.

SELECT E.employee_name, E.city
FROM Employee E
JOIN Works W ON E.employee_name = W.employee_name
WHERE W.company_name = 'First Bank Corporation';


-- Q3. Find the names, street and city of employees who work for First Bank Corporation and earn more than 10000.

SELECT E.employee_name, E.street, E.city
FROM Employee E
JOIN Works W ON E.employee_name = W.employee_name
WHERE W.company_name = 'First Bank Corporation'
  AND W.salary > 10000;


-- Q4. Find all employees who earn more than each employee of Small Bank Corporation.

SELECT employee_name
FROM Works
WHERE salary > ALL (
    SELECT salary
    FROM Works
    WHERE company_name = 'Small Bank Corporation'
);


-- Q5. Find all employees who earn more than the average salary of all employees of their companies.

SELECT W1.employee_name, W1.company_name, W1.salary
FROM Works W1
WHERE salary > (
    SELECT AVG(W2.salary)
    FROM Works W2
    WHERE W2.company_name = W1.company_name
);

-- Q6. Find the company that has the smallest total payroll.

SELECT company_name
FROM Works
GROUP BY company_name
ORDER BY SUM(salary)
LIMIT 1;


-- Q7. Find companies whose employees earn a higher salary on average than the average salary at First Bank Corporation.

SELECT company_name
FROM Works
GROUP BY company_name
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM Works
    WHERE company_name = 'First Bank Corporation'
);


-- Q8. Give all employees of First Bank Corporation a 10% raise.

UPDATE Works
SET salary = salary * 1.10
WHERE company_name = 'First Bank Corporation';

select * from Works;

-- Q9. Insert names and salaries of employees who earn more than the average salary into table HighEarners.

CREATE TABLE HighEarners (
    employee_name VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO HighEarners (employee_name, salary)
SELECT employee_name, salary
FROM Works
WHERE salary > (SELECT AVG(salary) FROM Works);

select * from HighEarners;
-- Q10. Delete employees from Employee table who work for a company located in Gotham.

DELETE FROM Employee
WHERE employee_name IN (
    SELECT W.employee_name
    FROM Works W
    JOIN Company C ON W.company_name = C.company_name
    WHERE C.city = 'Gotham'
);

select * from Employee;


-- View: Display employee, company and manager details
CREATE VIEW EmployeeDetails AS
SELECT E.employee_name, E.city AS employee_city,
       W.company_name, W.salary,
       M.manager_name
FROM Employee E
JOIN Works W ON E.employee_name = W.employee_name
JOIN Manages M ON E.employee_name = M.employee_name;

SELECT * FROM EmployeeDetails;
