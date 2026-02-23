create database practice;
use practice;

create table student (
ID int,
Name varchar(20),
DOB date
);
insert into student (
ID, Name, DOB)
values ('1', 'Kripa', '2006-09-18');

 create table student_course (
StdID int,
Course_code varchar(20),
Subject varchar(20)
);
insert into student_course (
StdID, Course_code, Subject)
values (1, 'SE', 'DB'), (1, 'SE', 'Networking'),(1, 'SE', 'POP');

select * from student_course 



