use SwanseaStudentRentals;

CREATE VIEW IF NOT EXISTS rental_demand 
AS
SELECT *
FROM Students
WHERE activelySeeking = True
ORDER BY dateStartedLooking;

CREATE VIEW IF NOT EXISTS todaysProperty
AS
SELECT *
FROM rentalProperties r 
WHERE r.isAvailable = True 
ORDER BY r.dateAvailable 
LIMIT 1;

CREATE VIEW IF NOT EXISTS matchAndREnt
AS
SELECT *
FROM Students s
WHERE (activelySeeking = True AND s.numRoomsNeeded <= (SELECT numRooms FROM rentalProperties r WHERE r.isAvailable = True ORDER BY r.dateAvailable LIMIT 1) AND s.moveDate >= (SELECT dateAvailable FROM rentalProperties r WHERE r.isAvailable = True ORDER BY r.dateAvailable LIMIT 1) AND s.maxRent <= (SELECT rent FROM rentalProperties r WHERE r.isAvailable = True ORDER BY r.dateAvailable LIMIT 1))
ORDER BY s.dateStartedLooking
LIMIT 5;

UPDATE rentalProperties p
SET isAvailable = False
WHERE p.address IN (SELECT propertyAddress FROM rentalAppointments a WHERE a.propertyAccepted = True);

CREATE VIEW IF NOT EXISTS rentalTracker
AS
SELECT propertyAddress, dateOffered
FROM rentalAppointments a
WHERE a.studentId = 1; 

CREATE VIEW IF NOT EXISTS acceptedPropertyContactList
AS
SELECT *
FROM rentalAppointments a 
WHERE (a.propertyAddress IN (SELECT address FROM rentalProperties p WHERE p.isAvailable = False) AND a.timeAndDate >= CURRENT_TIMESTAMP AND a.propertyAccepted = False);

CREATE VIEW IF NOT EXISTS systemEfficacy
AS
SELECT COUNT(a.propertyAccepted) AS rejections, LEFT(s.firstName, 1) AS studentFirstName, s.lastName AS studentLastName
FROM rentalAppointments a
JOIN students s
ON a.studentId = s.studentId
WHERE (a.propertyAccepted = False AND a.studentId = 1);

CREATE VIEW IF NOT EXISTS renterReport
AS
SELECT COUNT(a.propertyAccepted) AS rejections, p.postcode, p.landlordLastName
FROM rentalAppointments a
JOIN rentalProperties p
ON a.propertyAddress = p.address
WHERE (a.propertyAccepted = False AND a.propertyAddress = '123 Main St');





