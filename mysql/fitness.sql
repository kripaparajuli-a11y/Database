CREATE DATABASE AspireFitness;
USE AspireFitness;

CREATE TABLE Member (
  MemberID VARCHAR(8) NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  Surname VARCHAR(50) NOT NULL,
  Address VARCHAR(200) NOT NULL,
  Telephone VARCHAR(15) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  DateOfBirth DATE NOT NULL,
  MedicalConditions VARCHAR(500),
  MembershipStartDate DATE NOT NULL,
  PRIMARY KEY (MemberID)
);

CREATE TABLE FitnessStaff (
  StaffID VARCHAR(8) NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  Surname VARCHAR(50) NOT NULL,
  Role VARCHAR(30) NOT NULL,
  ContactPhone VARCHAR(15) NOT NULL,
  PRIMARY KEY (StaffID)
);

CREATE TABLE Room (
  RoomID VARCHAR(5) NOT NULL,
  RoomName VARCHAR(50) NOT NULL,
  MaxCapacity INT NOT NULL,
  PRIMARY KEY (RoomID)
);

CREATE TABLE Class (
  ClassCode VARCHAR(8) NOT NULL,
  ClassName VARCHAR(50) NOT NULL,
  StaffID VARCHAR(8) NOT NULL,
  RoomID VARCHAR(5) NOT NULL,
  DayOfWeek VARCHAR(10) NOT NULL,
  StartTime VARCHAR(5) NOT NULL,
  MaxClassSize INT NOT NULL,
  PRIMARY KEY (ClassCode),
  FOREIGN KEY (StaffID) REFERENCES FitnessStaff(StaffID),
  FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);





CREATE TABLE FacilityBooking (
  BookingID VARCHAR(8) NOT NULL,
  MemberID VARCHAR(8) NOT NULL,
  RoomID VARCHAR(5) NOT NULL,
  BookingDate DATE NOT NULL,
  StartTime VARCHAR(5) NOT NULL,
  EndTime VARCHAR(5) NOT NULL,
  ActivityDescription VARCHAR(100),
  PRIMARY KEY (BookingID),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
  FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

CREATE TABLE ClassBooking (
  CBookingID VARCHAR(8) NOT NULL,
  MemberID VARCHAR(8) NOT NULL,
  ClassCode VARCHAR(8) NOT NULL,
  BookingDate DATE NOT NULL,
  ExtraCharge CHAR(1) NOT NULL,
  PRIMARY KEY (CBookingID),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
  FOREIGN KEY (ClassCode) REFERENCES Class(ClassCode)
);

INSERT INTO Member VALUES
('110','Kripa','Parajuli','Dadhikot, Bhaktapur','9001234567','kripa.parajuli@email.com','2006-09-18',NULL,'2024-01-10'),
('120','Bibek','Bharati','Dolalghat, Kavrepalanchowk','97711234002','bibek.bharati@email.com','2006-12-22',NULL,'2024-02-01'),
('130','Soniya','Gurung','Balkot, Bhaktapur','97711234003','soniya.gurung@email.com','2007-11-02','Asthma','2023-09-15'),
('140','Aananya','Shrestha','Patan, Lalitpur','97711234004','aananya.shrestha@email.com','2000-03-30','Knee injury','2024-03-01');

INSERT INTO FitnessStaff VALUES
('S01','Ramesh','Shrestha','Class Instructor','9841234501'),
('S02','Suman','Tamang','Personal Trainer','9841234502'),
('S03','Anita','Maharjan','Class Instructor','9841234503'),
('S04','Bikash','Karki','Manager','9841234504');

INSERT INTO Room VALUES
('R001','Main Hall',80),
('R002','Yoga Hall',25),
('R003','Small Dance Room',10);

INSERT INTO Class VALUES
('CLS001','Yoga Flow','S01','R002','Monday','09:00',20),
('CLS002','Zumba','S03','R001','Wednesday','18:30',40),
('CLS003','Pilates','S01','R003','Friday','10:00',10),
('CLS004','Tai Chi','S03','R002','Tuesday','08:00',15);

INSERT INTO FacilityBooking VALUES
('FB001','110','R001','2026-03-10','10:00','12:00','Volleyball'),
('FB002','120','R002','2026-03-11','14:00','16:00','Yoga practice'),
('FB003','130','R001','2026-03-12','09:00','11:00','Basketball'),
('FB004','140','R003','2026-03-13','13:00','15:00','Dance practice');

INSERT INTO ClassBooking VALUES
('CB001','110','CLS001','2026-03-05','N'),
('CB002','110','CLS002','2026-03-05','N'),
('CB003','120','CLS003','2026-03-06','N'),
('CB004','130','CLS001','2026-03-06','N'),
('CB005','130','CLS004','2026-03-07','N'),
('CB006','130','CLS002','2026-03-07','Y'),
('CB007','130','CLS001','2026-03-08','N'),
('CB008','130','CLS002','2026-03-08','N'),
('CB009','130','CLS003','2026-03-09','Y');


SELECT MemberID, FirstName, Surname, Telephone, Email
FROM Member
ORDER BY Surname;


SELECT FacilityBooking.BookingID, 
       CONCAT(Member.FirstName,' ',Member.Surname) AS MemberName,
       Room.RoomName, 
       FacilityBooking.BookingDate, 
       FacilityBooking.StartTime, 
       FacilityBooking.EndTime, 
       FacilityBooking.ActivityDescription
FROM FacilityBooking
JOIN Member ON FacilityBooking.MemberID = Member.MemberID
JOIN Room ON FacilityBooking.RoomID = Room.RoomID
WHERE MONTH(FacilityBooking.BookingDate) = MONTH(CURDATE())
AND YEAR(FacilityBooking.BookingDate) = YEAR(CURDATE())
ORDER BY FacilityBooking.BookingDate, FacilityBooking.StartTime;


SELECT Class.ClassCode, 
       Class.ClassName, 
       Class.DayOfWeek, 
       Class.StartTime,
       Room.RoomName, 
       Class.MaxClassSize,
       CONCAT(FitnessStaff.FirstName,' ',FitnessStaff.Surname) AS InstructorName
FROM Class
JOIN FitnessStaff ON Class.StaffID = FitnessStaff.StaffID
JOIN Room ON Class.RoomID = Room.RoomID
WHERE Class.StaffID = 'S01'
ORDER BY Class.DayOfWeek, Class.StartTime;


SELECT Class.ClassCode, 
       Class.ClassName, 
       Class.DayOfWeek, 
       Class.StartTime,
       CONCAT(FitnessStaff.FirstName,' ',FitnessStaff.Surname) AS InstructorName
FROM Class
JOIN FitnessStaff ON Class.StaffID = FitnessStaff.StaffID
JOIN Room ON Class.RoomID = Room.RoomID
WHERE Room.RoomID = 'R002'
ORDER BY Class.DayOfWeek, Class.StartTime;


SELECT 'Facility Booking' AS BookingType,
       FacilityBooking.BookingDate, 
       FacilityBooking.StartTime, 
       Room.RoomName, 
       FacilityBooking.ActivityDescription AS Detail
FROM FacilityBooking
JOIN Room ON FacilityBooking.RoomID = Room.RoomID
WHERE FacilityBooking.MemberID = '110'
UNION ALL
SELECT 'Class Booking' AS BookingType,
       ClassBooking.BookingDate, 
       Class.StartTime, 
       Room.RoomName, 
       Class.ClassName AS Detail
FROM ClassBooking
JOIN Class ON ClassBooking.ClassCode = Class.ClassCode
JOIN Room ON Class.RoomID = Room.RoomID
WHERE ClassBooking.MemberID = '110'
ORDER BY BookingDate, StartTime;


SELECT Member.MemberID, 
       CONCAT(Member.FirstName,' ',Member.Surname) AS MemberName,
       COUNT(*) AS TotalClassBookings
FROM ClassBooking
JOIN Member ON ClassBooking.MemberID = Member.MemberID
GROUP BY Member.MemberID, Member.FirstName, Member.Surname
ORDER BY TotalClassBookings DESC;


SELECT Member.MemberID,
       CONCAT(Member.FirstName,' ',Member.Surname) AS MemberName,
       IFNULL(FacilityCount.Total, 0) AS FacilityBookings,
       IFNULL(ClassCount.Total, 0) AS ClassBookings,
       IFNULL(FacilityCount.Total, 0) + IFNULL(ClassCount.Total, 0) AS TotalActivity
FROM Member
LEFT JOIN (
    SELECT MemberID, COUNT(*) AS Total
    FROM FacilityBooking
    WHERE MONTH(BookingDate) = MONTH(CURDATE())
    AND YEAR(BookingDate) = YEAR(CURDATE())
    GROUP BY MemberID
) FacilityCount ON Member.MemberID = FacilityCount.MemberID
LEFT JOIN (
    SELECT MemberID, COUNT(*) AS Total
    FROM ClassBooking
    WHERE MONTH(BookingDate) = MONTH(CURDATE())
    AND YEAR(BookingDate) = YEAR(CURDATE())
    GROUP BY MemberID
) ClassCount ON Member.MemberID = ClassCount.MemberID
WHERE IFNULL(FacilityCount.Total, 0) + IFNULL(ClassCount.Total, 0) > 0
ORDER BY TotalActivity DESC;


SELECT Member.MemberID, 
       CONCAT(Member.FirstName,' ',Member.Surname) AS MemberName,
       COUNT(*) AS TotalClassBookings,
       (COUNT(*) - 5) * 500 AS ExtraChargeRs
FROM ClassBooking
JOIN Member ON ClassBooking.MemberID = Member.MemberID
GROUP BY Member.MemberID, Member.FirstName, Member.Surname
HAVING COUNT(*) > 5
ORDER BY TotalClassBookings DESC;


SELECT Room.RoomID, 
       Room.RoomName, 
       Room.MaxCapacity,
       COUNT(FacilityBooking.BookingID) AS TotalBookings
FROM Room
LEFT JOIN FacilityBooking ON Room.RoomID = FacilityBooking.RoomID
GROUP BY Room.RoomID, Room.RoomName, Room.MaxCapacity
ORDER BY TotalBookings DESC;


SELECT DISTINCT Member.MemberID,
       Member.Surname,
       CONCAT(Member.FirstName,' ',Member.Surname) AS MemberName,
       Member.Email
FROM ClassBooking
JOIN Member ON ClassBooking.MemberID = Member.MemberID
WHERE ClassBooking.ExtraCharge = 'Y'
ORDER BY Member.Surname;














