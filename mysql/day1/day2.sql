# TO CREATE DATABASE
CREATE DATABASE TEST;
# TO USE DATABASE
USE TEST;
# TO CREATE TABLE
CREATE TABLE Customers (
CustomerID int,
FirstName varchar(255),
LastName varchar(225),
Gender char(1),
DOB date,
Address varchar(225),
City varchar(255),
Email varchar(255)
);
# TO INSERT VALUES IN TABLE
INSERT INTO Customers ( CustomerID, FirstName, LastName, Gender, DOB,
Address, City, Email)
VALUES ( 001, 'Kripa', 'Parajuli', 'F', '2006-09-18',
'Dadhikot', 'BKT', 'kripa@gmail.com'),
( 002, 'Bibek', 'Bharati', 'M',  '2006-12-22',
'Bnpa', '..', 'bibek@gmail.com'),
( 003, 'Soniya', 'Gurung', 'F',  '2007-02-11',
'Balkot', 'BKT', 'soniya@gmail.com'),
( 004, 'Sneha', 'Thakur', 'F',  '2004-06-15',
'Janakpur', 'Janakpur', 'sneha@gmail.com');

SELECT * FROM Customers;

# UPDATE
UPDATE Customers
SET City= 'Banepa'
WHERE CustomerID= 002;

SELECT * FROM Customers WHERE CustomerID= 002;

#DELETE
DELETE from Customers
WHERE CustomerID = 001;

SELECT * FROM Customers;

# ALTER
ALTER TABLE Customers
ADD PhoneNo varchar(15);

SELECT * FROM Customers;

#ALL
SELECT * FROM Customers
WHERE CustomerID > ALL
(SELECT CustomerID FROM Customers WHERE Gender = 'F');

#AND
SELECT * FROM Customers
WHERE Gender = 'F' AND City = 'BKT';

#ANY
SELECT * FROM Customers
WHERE CustomerID = ANY
(SELECT CustomerID FROM Customers WHERE City = 'Banepa');

#BETWEEN
SELECT * FROM Customers
WHERE CustomerID BETWEEN 2 AND 4;

#EXISTS
SELECT * FROM Customers
WHERE EXISTS
(SELECT * FROM Customers WHERE City = 'BKT');

#IN
SELECT * FROM Customers
WHERE City IN ('BKT', 'Banepa');

#LIKE
SELECT * FROM Customers
WHERE FirstName LIKE 'S%';

#NOT
SELECT * FROM Customers
WHERE NOT City = 'BKT';

#OR
SELECT * FROM Customers
WHERE City = 'BKT' OR City = 'Janakpur';

#SOME
SELECT * FROM Customers
WHERE CustomerID > SOME
(SELECT CustomerID FROM Customers WHERE Gender = 'F');

#JOINTS
CREATE TABLE Orders (
OrderID int,
CustomerID int,
Product varchar(100)
);
INSERT INTO Orders (OrderID, CustomerID, Product)
VALUES
(101, 2, 'Laptop'),
(102, 3, 'Phone'),
(103, 5, 'Tablet');

#INNER JOINTS
SELECT Customers.FirstName, Orders.Product
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

#LEFT JOINTS
SELECT Customers.FirstName, Orders.Product
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

#RIGHT JOINTS
SELECT Customers.FirstName, Orders.Product
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

#FULL OUTER JOINT
SELECT Customers.FirstName, Orders.Product
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID

UNION

SELECT Customers.FirstName, Orders.Product
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;




















