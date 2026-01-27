-- 1. Create database and switch to it
CREATE DATABASE IF NOT EXISTS dbemp;
USE dbemp;

-- Clean start
DROP TABLE IF EXISTS employee;

-- 2. Create employee table
CREATE TABLE employee (
    EmployeeID VARCHAR(20) PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20),
    Gender CHAR(1),
    DateOfBirth DATE,
    Designation VARCHAR(50),
    DepartmentName VARCHAR(30),
    ManagerID VARCHAR(20),
    JoinedDate DATE,
    Salary DECIMAL(10,0)
);

-- 3. Insert employee records
INSERT INTO employee (
    EmployeeID, FirstName, LastName, Gender, DateOfBirth,
    Designation, DepartmentName, ManagerID, JoinedDate, Salary
)
VALUES
('0011','Ramesh','Rai','M','2000-04-02','Manager',
 'Software Engineering',NULL,'2022-04-02',1000000),
('0012','Season','Maharjan','M','1996-04-02','Engineer',
 'Software Engineering','0011','2022-04-02',500000);

-- View records
SELECT * FROM employee;

-- 4. Update the gender of an employee (valid EmployeeID)
UPDATE employee
SET Gender = 'M'
WHERE EmployeeID = '0012';

-- View updated records
SELECT * FROM employee;

-- 5. Display first name, current date, date of birth, and age
-- of employees older than 25 years
SELECT 
    FirstName,
    CURDATE() AS CurrentDate,
    DateOfBirth,
    TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) AS Age
FROM employee
WHERE TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) > 25;

-- 6. Oldest employee
SELECT *
FROM employee
WHERE DateOfBirth = (
    SELECT MIN(DateOfBirth) FROM employee
);

-- 7. Youngest employee
SELECT *
FROM employee
WHERE DateOfBirth = (
    SELECT MAX(DateOfBirth) FROM employee
);

-- 8. Maximum salary department-wise
SELECT DepartmentName, MAX(Salary) AS MaxSalary
FROM employee
GROUP BY DepartmentName;

-- 9. List employees who act as managers
SELECT DISTINCT e.*
FROM employee e
WHERE e.EmployeeID IN (
    SELECT ManagerID
    FROM employee
    WHERE ManagerID IS NOT NULL
);

-- 10. Most recently joined employee
SELECT *
FROM employee
WHERE JoinedDate = (
    SELECT MAX(JoinedDate) FROM employee
);