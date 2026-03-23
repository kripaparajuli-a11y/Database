show databases;
use  Dept;

create table dept (
DEPTNO int primary key,
DNAME varchar(20),
LOC varchar(4)
);

select * from Department;
rename table dept to Department;
alter table Department add column PINCODE int not null default 0;
alter table Department change DNAME DEPT_NAME varchar(20);
alter table Department modify LOC char(20);
Drop table Department;

show databases



