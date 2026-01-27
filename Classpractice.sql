# 1. Create a database named dbemp and switch to it
CREATE DATABASE IF NOT EXISTS dbemp;
USE dbemp;
# (Clean start) Drop table if it already exists
DROP TABLE IF EXISTS employee;
# 2. Create the employee table with appropriate data types and constraints
CREATE TABLE employee (
    EmployeeID VARCHAR(20) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    Gender CHAR(1),
    DateofBirth DATE,
    Designation VARCHAR(50),
    DepartmentName VARCHAR(30),
    ManagerId VARCHAR(20),
    JoinedDate DATE,
    Salary DECIMAL(10,0)
);
# 3. Insert at least two employee records into the employee table
INSERT INTO employee (
    EmployeeID, FirstName, LastName, Gender, DateofBirth,
    Designation, DepartmentName, ManagerId, JoinedDate, Salary
)
VALUES
('0012','Season','Maharjan','M','1996-04-02','Engineer',
 'Software Engineering','0005','2022-04-02',5000000),
('0011','Ramesh','Rai','M','2000-04-02','Manager',
 'Software Engineering','0003','2022-04-02',1000000);
# View records
SELECT * FROM employee;
# 4. Update the gender of an employee whose EmployeeID is 0009
UPDATE employee
SET Gender = 'M'
WHERE EmployeeID = '0009';
# View updated records
SELECT * FROM employee;
#5Display the first name current date,
#date of birth,and age of employees
#who are older than 25 years.
select Firstname,curdate() as currentdate,
DateofBirth, 
timestampdiff(year, dateofBirth, CURDATE() ) as Age
from employee where
timestampdiff(year, DateofBirth, CURDATE() )>25;
#6, write a query to find the oldest employee.
select * from employee
where 
DateofBirth=(select MIN(DateofBirth)
from employee);
#7 youngest employee
select * from employee
where 
DateofBirth=(select MAX(DateofBirth)
from employee);
#8 Display the maximum salary department - wise,
select DepartmentName, Max(salary) as MaxSalary 
from employee group by departmentName ;
#9 list the employees who act as managers. 
select * from employee;
select FirstName from employee where
EmployeeID in (select ManagerID from employee);
#10. Display the details of
#the most recently joined employee,
select * from employee where 
JoinedDate = (select MAX(JoinedDate) from employee);