DROP DATABASE SwanseaStudentRentals;

CREATE DATABASE IF NOT EXISTS SwanseaStudentRentals;

use SwanseaStudentRentals;

CREATE TABLE IF NOT EXISTS Students(    
    firstName VARCHAR(50) NOT NULL, 
    lastName VARCHAR(250) NOT NULL,
    city VARCHAR(50),
    age INTEGER,
    phoneNumber BIGINT NOT NULL,
    studentId INTEGER NOT NULL AUTO_INCREMENT,
    dateStartedLooking DATE NOT NULL,
    activelySeeking BOOLEAN DEFAULT True,
    moveDate DATE NOT NULL,
    numRoomsNeeded INTEGER NOT NULL,
    requiresAccessibility BOOLEAN,
    maxRent DOUBLE NOT NULL,
    requiresParking BOOLEAN,
    PRIMARY KEY (studentId));

CREATE TABLE IF NOT EXISTS rentalProperties(
    address VARCHAR(250) PRIMARY KEY,
    postcode VARCHAR(6) NOT NULL,
    rent DOUBLE NOT NULL,
    landlordFirstName VARCHAR(50) NOT NULL,
    landlordLastName VARCHAR(50) NOT NULL,
    landlordPhoneNumber BIGINT NOT NULL,
    dateAvailable DATE NOT NULL,
    isAvailable BOOLEAN DEFAULT True,
    isAccessible BOOLEAN,
    numRooms INTEGER,
    parkingAvailable BOOLEAN);

CREATE TABLE IF NOT EXISTS rentalAppointments(
    studentId INTEGER,
    propertyAddress VARCHAR(250),
    timeAndDate DATETIME NOT NULL,
    appointmentID INTEGER NOT NULL AUTO_INCREMENT,
    propertyAccepted BOOLEAN DEFAULT False,
    dateOffered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (appointmentId),
    FOREIGN KEY (studentId)
        REFERENCES Students(studentId),
    FOREIGN KEY (propertyAddress)
        REFERENCES rentalProperties(address));

INSERT INTO
    Students(firstName, lastName, city, age, phoneNumber, dateStartedLooking, moveDate, numRoomsNeeded, maxRent)
VALUES
    ('John', 'Smith', 'Swansea', 20, 03759287739, '2022-09-03', '2022-12-05', 1, 500.00),
    ('Jane', 'Doe', 'Port Talbot', 18, 46273849274, '2022-10-10', '2023-01-07', 2, 450.00),
    ('Allie', 'Griffin', 'Bristol', 30, 38474927384, '2022-09-15', '2022-12-22', 1, 500.00),
    ('Bob', 'Jones', 'Cardiff', 25, 28362749202, '2022-10-27', '2023-01-13', 2, 450.00),
    ('Sarah', 'Williams', 'Swansea', 22, 02837461783, '2022-09-07', '2022-11-25', 1, 500.00),
    ('Mike', 'Richardson', 'Newport', 31, 26937492048, '2022-10-09', '2023-01-27', 2, 450.00),
    ('Mary', 'Berry', 'Mumbles', 19, 97563829384, '2022-09-17', '2022-12-09', 1, 500.00),
    ('Percy', 'Peters', 'Bath', 21, 28474204837, '2022-10-19', '2023-01-15', 2, 450.00),
    ('Jim', 'Tree', 'Hay-on-Wye', 20, 381028479208, '2022-10-22', '2022-12-18', 1, 500.00),
    ('Terry', 'Davidson', 'Brecon', 23, 92746583927, '2022-09-25', '2023-10-02', 2, 450.00);

INSERT INTO
    rentalProperties(address, postcode, rent, landlordFirstName, landlordLastName, landlordPhoneNumber, dateAvailable, numRooms)
VALUES
    ('123 Main St', 'SA18EP', 500.00, 'David', 'Wright', 274658394758, '2022-10-09', 1),
    ('75 1st Ave', 'SA11AF', 300.00, 'Mark', 'Wilson', 93847587485, '2022-11-03', 2),
    ('99 Baker St', 'SA11DG', 400.00, 'Sharon', 'Lynn', 84737585049, '2022-12-07', 1),
    ('243 Alexandra Rd', 'SA11DX', 250.00, 'Wendy', 'Thompson', 93038757584, '2022-10-10', 2),
    ('796 Drury Ln', 'SA11DW', 330.00, 'Billy', 'Thornton', 01827463738, '2022-10-15', 1);

INSERT INTO
    rentalAppointments(studentId, propertyAddress, timeAndDate, propertyAccepted)
VALUES
    (2, '99 Baker St', '2022-10-13 11:30:00', True),
    (5, '796 Drury Ln', '2022-11-15 12:15:00', False),
    (7, '123 Main St', '2022-12-03 16:20:00', False),
    (1, '123 Main St', '2022-10-22 10:45:00', False),
    (4, '243 Alexandra Rd', '2022-11-11 17:30:00', False);

