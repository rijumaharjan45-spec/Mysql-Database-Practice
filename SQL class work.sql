DROP DATABASE TechSolutionDB;

-- ======================================
-- PART A: DATABASE AND TABLE CREATION
-- ======================================

-- Create database
CREATE DATABASE TechSolutionDB;

-- Use database
USE TechSolutionDB;

-- -----------------------------
-- Create DEPARTMENT table
-- -----------------------------
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);

-- -----------------------------
-- Create EMPLOYEE table
-- -----------------------------
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    HireDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- -----------------------------
-- Create PROJECT table
-- -----------------------------
CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(12,2)
);

-- -----------------------------
-- Create WORKS_ON table
-- -----------------------------
CREATE TABLE Works_On (
    EmpID INT,
    ProjectID INT,
    HoursWorked INT,

    -- Composite Primary Key
    PRIMARY KEY (EmpID, ProjectID),

    -- Foreign Keys
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

-- ======================================
-- SHOW TABLES AND STRUCTURE
-- ======================================

SHOW TABLES;

DESCRIBE Department;
DESCRIBE Employee;
DESCRIBE Project;
DESCRIBE Works_On;

-- ======================================
-- PART B: INSERT DATA
-- ======================================

-- Insert Departments
INSERT INTO Department VALUES
(1,'Human Resources','Kathmandu'),
(2,'IT','Lalitpur'),
(3,'Finance','Bhaktapur'),
(4,'Marketing','Pokhara'),
(5,'Operations','Biratnagar');

-- Insert Employees
INSERT INTO Employee VALUES
(101,'Ram','Sharma','Male',60000,'2021-01-10',2),
(102,'Sita','Thapa','Female',45000,'2022-03-15',1),
(103,'Hari','Khadka','Male',52000,'2020-07-20',3),
(104,'Gita','Gurung','Female',48000,'2023-02-11',4),
(105,'Bikash','Rai','Male',70000,'2019-09-05',2);

-- Insert Projects
INSERT INTO Project VALUES
(1,'Website Development','2024-01-01','2024-06-01',500000),
(2,'Mobile App','2024-02-01','2024-08-01',800000),
(3,'Accounting System','2024-03-01','2024-09-01',600000),
(4,'Marketing Campaign','2024-04-01','2024-07-01',300000),
(5,'Cloud Migration','2024-05-01','2024-12-01',900000);

-- Insert Works_On
INSERT INTO Works_On VALUES
(101,1,120),
(102,2,80),
(103,3,100),
(104,4,60),
(105,5,150);

-- ======================================
-- UPDATE QUERY
-- ======================================

-- Increase salary of EmpID 102 by 10%
UPDATE Employee
SET Salary = Salary * 1.10
WHERE EmpID = 102;

-- ======================================
-- DELETE QUERY
-- ======================================

-- Remove reference first
DELETE FROM Works_On
WHERE ProjectID = 5;

-- Then delete project
DELETE FROM Project
WHERE ProjectID = 5;

-- ======================================
-- PART C: BASIC QUERIES
-- ======================================

-- 1. Employees earning more than 50,000
SELECT *
FROM Employee
WHERE Salary > 50000;

-- 2. Show employees sorted by salary (highest first)
SELECT FirstName, LastName, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Display employees who belong to the IT department
SELECT E.EmpID, E.FirstName, E.LastName, E.Gender, E.Salary, E.HireDate
FROM Employee E
JOIN Department D ON E.DeptID = D.DeptID
WHERE D.DeptName = 'IT';

-- 4. Show the total number of employees in each department
SELECT D.DeptName, COUNT(E.EmpID) AS TotalEmployees
FROM Department D
LEFT JOIN Employee E ON D.DeptID = E.DeptID
GROUP BY D.DeptID, D.DeptName;

-- 5. Display employees who were hired after January 1, 2022
SELECT EmpID, FirstName, LastName, HireDate
FROM Employee
WHERE HireDate > '2022-01-01';

-- ======================================
-- PART D: JOIN QUERIES
-- ======================================

-- 1. Display employee names along with their department names
SELECT E.FirstName, E.LastName, D.DeptName
FROM Employee E
JOIN Department D
ON E.DeptID = D.DeptID;

-- 2. Show employees and the projects they are working on
SELECT E.FirstName, E.LastName, P.ProjectName
FROM Employee E
JOIN Works_On W ON E.EmpID = W.EmpID
JOIN Project P ON W.ProjectID = P.ProjectID;

-- 3. Display project names with the total hours worked by employees
SELECT P.ProjectName, SUM(W.HoursWorked) AS TotalHours
FROM Project P
JOIN Works_On W ON P.ProjectID = W.ProjectID
GROUP BY P.ProjectID, P.ProjectName;

-- ======================================
-- PART E: AGGREGATE AND ADVANCED QUERIES
-- ======================================

-- 1. Find the average salary of employees in each department
SELECT D.DeptName, AVG(E.Salary) AS AverageSalary
FROM Department D
JOIN Employee E ON D.DeptID = E.DeptID
GROUP BY D.DeptID, D.DeptName;

-- 2. Display the department with the highest number of employees
SELECT D.DeptName, COUNT(E.EmpID) AS TotalEmployees
FROM Department D
JOIN Employee E ON D.DeptID = E.DeptID
GROUP BY D.DeptID, D.DeptName
ORDER BY TotalEmployees DESC
LIMIT 1;

-- 3. Find employees whose salary is greater than the average salary of all employees
SELECT EmpID, FirstName, LastName, Salary
FROM Employee
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
);