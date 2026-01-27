create table employee(
       EmployeeID varchar NOT NULL PRIMARY KEY,
	   FirstName varchar(20),
       LastName varchar (20),
       Gender char(1),
	   DateofBrith DATE,
       Designtion varchar (50),
       DepartmentName varchar(20),
       ManagerID varchar(20),
       JoinedDate DATE,
	   Salary decimal(10,0)
);

insert at least two employee records into the employment 