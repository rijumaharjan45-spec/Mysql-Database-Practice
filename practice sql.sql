show databases;
use dbemp;
create table DEPT(
DEPTNO INT PRIMARY KEY,
DNAME varchar(10),
LOC varchar(10)
);
#q1
Rename table DEPT to DEPARTMENT;
#q2
alter table DEPARTMENT
add column PINCODE int not null default 0;
#4 
alter table DEPARTMENT
change DNAME DEPT_NAME varchar(20);
#5 
alter table DEPARTMENT 
modify LOC char(20);
#q6
drop table DEPARTMENT;

