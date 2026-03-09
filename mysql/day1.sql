#1.	Create a database named day1 and switch to it.
create database day1;
use day1;
#2.	Create an employee table with appropriate data 
#types and constraints for employee details.
Create table employee (
	EmployeeID varchar(10),
    FirstName varchar(20),
    LastName varchar(20),
    Gender char(1),
    DateofBirth date,
    Designation varchar(20),
    DepartmentName varchar(30),
    ManagerId varchar(10),
    JoinedDate date,
    Salary decimal(10,0)
);
#3.	Insert at least two employee records into the employee table.
Insert into employee(
EmployeeID ,FirstName ,LastName ,Gender ,DateofBirth ,
Designation ,DepartmentName ,ManagerId ,JoinedDate ,Salary 
) values(
'001','Kripa','Parajuli','F','2006-09-18','Engineer',
'Software engineering','002','2026-11-02',5000000000
),(
'003','Soniya','Gurung','F','2007-04-02','Accountent',
'Teacher','005','2025-11-02','9000000'),(
'004','Bibek','Bharati','M','2006-12-22','..',
'..','005','2025-11-02',10000000);

select * from employee;

#4. Update the gender of an employee whose
# EmployeeID is 003
update employee
set Gender = 'M'
where EmployeeID = '003';

#5. Display the first name, current date,
#date of birth, and age of
#employees who are older thsn 30 years.
select FirstName,
curdate() as CurrentDate, DateofBirth,
timestampdiff (YEAR, DateofBirth, curdate()) as age
from employee
where
timestampdiff (YEAR, DateofBirth, curdate())>30;

#6. Write a query to find the oldest employee
select*from employee
where DateofBirth = 
(select Min(DateofBirth) from employee);

#7. Write a query to find the youngest employee
select*from employee
where DateofBirth = 
(select max(DateofBirth) from employee);

#8. Display the maximum salary department-wise.
select DepartmentName, max(Salary) as Maxsalary
from employee Group By DepartmentName;

#9. Display the Min Salary department-wise.
select DepartmentName, Min(salary) as Minsalary
from employee
group by DepartmentName
;

#10. List the employee who act as managers.
select*from employee where
EmployeeId in (select ManagerID from employee); 

 
