DROP DATABASE IF EXISTS CollegeDB;
CREATE DATABASE CollegeDB;
USE CollegeDB;

CREATE TABLE Person (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE Car (
    license VARCHAR(15) PRIMARY KEY,
    model VARCHAR(30),
    year INT
);

CREATE TABLE Accident (
    report_no INT PRIMARY KEY,
    date_acc DATE,
    location VARCHAR(50)
);

CREATE TABLE Owns (
    driver_id INT,
    license VARCHAR(15),
    PRIMARY KEY (driver_id, license),
    FOREIGN KEY (driver_id) REFERENCES Person(driver_id),
    FOREIGN KEY (license) REFERENCES Car(license)
);

CREATE TABLE Participated (
    driver_id INT,
    model VARCHAR(30),
    report_no INT,
    damage_amount DECIMAL(10,2),
    PRIMARY KEY (driver_id, report_no),
    FOREIGN KEY (driver_id) REFERENCES Person(driver_id),
    FOREIGN KEY (report_no) REFERENCES Accident(report_no)
);

CREATE TABLE Employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE Works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary DECIMAL(10,2),
    PRIMARY KEY (employee_name, company_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name),
    FOREIGN KEY (company_name) REFERENCES Company(company_name)
);

CREATE TABLE Manages (
    employee_name VARCHAR(50) PRIMARY KEY,
    manager_name VARCHAR(50),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name)
);

INSERT INTO Employee VALUES
('Aarav', 'MG Road', 'Bangalore'),
('Priya', 'FC Road', 'Pune'),
('Rahul', 'Marine Lines', 'Mumbai'),
('Sneha', 'Park Street', 'Kolkata');

INSERT INTO Company VALUES
('Infosys', 'Pune'),
('TCS', 'Mumbai'),
('TechMahindra', 'Hyderabad');

INSERT INTO Works VALUES
('Aarav', 'Infosys', 75000),
('Priya', 'TCS', 82000),
('Rahul', 'TechMahindra', 65000);

-- 1) Create view with employee_name and company_name
CREATE VIEW emp_company_view AS
SELECT e.employee_name, w.company_name, w.salary
FROM Employee e
JOIN Works w ON e.employee_name = w.employee_name;

SELECT * FROM emp_company_view;

-- 2) Create index for Employee and Participated tables
CREATE INDEX idx_employee_city ON Employee(city);
CREATE INDEX idx_participated_damage ON Participated(damage_amount);

-- Display created indexes
SHOW INDEX FROM Employee;
SHOW INDEX FROM Participated;

-- 3) Create sequence for Person and insert 4 records
INSERT INTO Person (name, address) VALUES
('Ravi Kumar', 'Pune'),
('Sneha Patel', 'Mumbai'),
('Amit Desai', 'Delhi'),
('Kiran Shah', 'Ahmedabad');

SELECT * FROM Person;

-- 4) Create synonym for Participated and Company (using views as synonyms)
CREATE VIEW part_syn AS SELECT * FROM Participated;
CREATE VIEW comp_syn AS SELECT * FROM Company;

-- Display data using synonym equivalents
SELECT * FROM part_syn;
SELECT * FROM comp_syn;

-- Update data using synonym (view) equivalent
UPDATE Company SET city = 'Hyderabad' WHERE company_name = 'TCS';

-- Display updated data
SELECT * FROM comp_syn;
