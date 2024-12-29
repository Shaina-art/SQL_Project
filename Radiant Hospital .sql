-- Block Table
CREATE TABLE block (
    blockfloor INTEGER NOT NULL,
    blockcode  INTEGER NOT NULL,
    PRIMARY KEY (blockfloor, blockcode)
);

INSERT INTO block (blockfloor, blockcode) 
VALUES
(1,1), (1,2), (1,3),
(2,1), (2,2), (2,3),
(3,1), (3,2), (3,3),
(4,1), (4,2), (4,3),
(5,1), (5,2), (5,3);  -- Added more floors and codes

-- Nurse Table
CREATE TABLE Nurse (
    employeeid INTEGER PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    position   VARCHAR(20) NOT NULL,
    registered BOOLEAN NOT NULL,
    ssn        INTEGER UNIQUE NOT NULL
);

INSERT INTO Nurse (employeeid, name, position, registered, ssn) 
VALUES 
(101, 'Carla Espinosa', 'Head Nurse', TRUE, 111111110),
(102, 'Laverne Roberts', 'Nurse', TRUE, 222222220),
(103, 'Paul Flowers', 'Nurse', FALSE, 333333330),
(104, 'Lucy Bennett', 'Nurse', TRUE, 444444440),
(105, 'Sam Dullard', 'Nurse', FALSE, 555555550);  -- Added more nurses

-- Physician Table
CREATE TABLE Physician (
    employeeid INTEGER PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    position   VARCHAR(50) NOT NULL,
    ssn        INTEGER UNIQUE NOT NULL
);

INSERT INTO Physician (employeeid, name, position, ssn) 
VALUES 
(1, 'John Dorian', 'Staff Internist', 111111111),
(2, 'Elliot Reid', 'Attending Physician', 222222222),
(3, 'Christopher Turk', 'Surgical Attending Physician', 333333333),
(4, 'Percival Cox', 'Senior Attending Physician', 444444444),
(5, 'Bob Kelso', 'Head Chief of Medicine', 555555555),
(6, 'Todd Quinlan', 'Surgical Attending Physician', 666666666),
(7, 'John Wen', 'Surgical Attending Physician', 777777777),
(8, 'Keith Dudemeister', 'MD Resident', 888888888),
(9, 'Molly Clock', 'Attending Psychiatrist', 999999999),
(10, 'Kim Briggs', 'OB/GYN', 101010101);  -- Added more physicians

-- Department Table
CREATE TABLE department (
    department_id INTEGER PRIMARY KEY,
    name          VARCHAR(50) NOT NULL,
    head          INTEGER NOT NULL REFERENCES Physician(employeeid)
);

INSERT INTO department (department_id, name, head)
VALUES 
(1, 'General Medicine', 4),
(2, 'Surgery', 7),
(3, 'Psychiatry', 9),
(4, 'OB/GYN', 10);  -- Added more departments

-- Appointment Table
CREATE TABLE appointment (
    appointmentid   INTEGER PRIMARY KEY,
    patient         INTEGER NOT NULL,
    prepnurse       INTEGER REFERENCES Nurse(employeeid),
    physician       INTEGER NOT NULL REFERENCES Physician(employeeid),
    start_dt        DATE NOT NULL,
    end_dt          DATE NOT NULL,
    examinationroom VARCHAR(10) NOT NULL
);

INSERT INTO appointment (appointmentid, patient, prepnurse, physician, start_dt, end_dt, examinationroom) 
VALUES 
(13216584, 100000001, 101, 1, '2008-04-24', '2008-04-24', 'A'),
(26548913, 100000002, 101, 2, '2008-04-24', '2008-04-24', 'B'),
(36549879, 100000003, 102, 3, '2008-04-25', '2008-04-25', 'C'),
(46846589, 100000004, 103, 4, '2008-04-26', '2008-04-26', 'D'),
(59871321, 100000005, NULL, 5, '2008-04-27', '2008-04-27', 'E');  -- Added more appointments

-- Room Table
CREATE TABLE room (
    roomnumber  INTEGER PRIMARY KEY,
    roomtype    VARCHAR(20) NOT NULL,
    blockfloor  INTEGER NOT NULL,
    blockcode   INTEGER NOT NULL,
    unavailable BOOLEAN NOT NULL
);
 
INSERT INTO room (roomnumber, roomtype, blockfloor, blockcode, unavailable) 
VALUES 
(101, 'Single', 1, 1, FALSE),
(102, 'Double', 1, 2, FALSE),
(103, 'Single', 1, 3, TRUE),
(201, 'Single', 2, 1, TRUE),
(202, 'Double', 2, 2, FALSE),
(203, 'Suite', 2, 3, FALSE),
(301, 'Single', 3, 1, TRUE),
(302, 'Suite', 3, 2, FALSE),
(303, 'Single', 3, 3, FALSE),
(401, 'Double', 4, 1, TRUE),
(402, 'Single', 4, 2, FALSE),
(403, 'Suite', 4, 3, TRUE);  -- Added more rooms

-- Patient Table
CREATE TABLE Patient (
    ssn         INTEGER PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    address     VARCHAR(100) NOT NULL,
    phone       VARCHAR(15) NOT NULL,
    insuranceid INTEGER NOT NULL,
    pcp         INTEGER NOT NULL REFERENCES Physician(employeeid)
);

INSERT INTO Patient (ssn, name, address, phone, insuranceid, pcp)
VALUES 
(100000001, 'John Smith', '42 Foobar Lane', '555-0256', 68476213, 1),
(100000002, 'Grace Ritchie', '37 Snafu Drive', '555-0512', 36546321, 2),
(100000003, 'Random J. Patient', '101 Omgbbq Street', '555-1204', 65465421, 3),
(100000004, 'Dennis Doe', '1100 Foobaz Avenue', '555-2048', 68421879, 4),
(100000005, 'Alice Johnson', '123 Example Blvd', '555-3021', 98765432, 5);  -- Added more patients

-- Medication Table
CREATE TABLE Medication (
    code        INTEGER PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    brand       VARCHAR(50),
    description TEXT NOT NULL
);

INSERT INTO Medication (code, name, brand, description)
VALUES 
(1, 'Procrastin-X', NULL, 'For anxiety relief'),
(2, 'Thesisin', 'Foo Labs', 'Helps focus'),
(3, 'Awakin', 'Bar Laboratories', 'Boosts alertness'),
(4, 'Crescavitin', 'Baz Industries', 'Enhances recovery'),
(5, 'Melioraurin', 'Snafu Pharmaceuticals', 'Increases energy');  -- Expanded descriptions

--Table Procedure

CREATE TABLE procedure(
   code INTEGER  NOT NULL  
  ,name VARCHAR(30) NOT NULL
  ,cost INTEGER  NOT NULL
);

INSERT INTO procedure(code,name,cost) VALUES (1,'Reverse Rhinopodoplasty',1500),
 (2,'Obtuse Pyloric Recombobulation',3750),
 (3,'Folded Demiophtalmectomy',4500),
 (4,'Complete Walletectomy',10000),
 (5,'Obfuscated Dermogastrotomy',4899),
 (6,'Reversible Pancreomyoplasty',5600),
 (7,'Follicular Demiectomy',25);



--Trained_in

CREATE TABLE trained_in(
   physician            INTEGER  NOT NULL  
  ,treatment            INTEGER  NOT NULL
  ,certificationdate    varchar(10)  NOT NULL
  ,certificationexpires varchar(10)  NOT NULL
);


INSERT INTO trained_in(physician,treatment,certificationdate,certificationexpires)
 VALUES (3,1,'1/1/2008','31/12/2008'),
 (3,2,'1/1/2008','31/12/2008'),
 (3,5,'1/1/2008','31/12/2008'),
 (3,6,'1/1/2008','31/12/2008'),
 (3,7,'1/1/2008','31/12/2008'),
 (6,2,'1/1/2008','31/12/2008'),
 (6,5,'1/1/2007','31/12/2007'),
 (6,6,'1/1/2008','31/12/2008'),
 (7,1,'1/1/2008','31/12/2008'),
 (7,2,'1/1/2008','31/12/2008'),
 (7,3,'1/1/2008','31/12/2008'),
 (7,4,'1/1/2008','31/12/2008'),
 (7,5,'1/1/2008','31/12/2008'),
 (7,6,'1/1/2008','31/12/2008'),
 (7,7,'1/1/2008','31/12/2008');


-- affiliated_with

CREATE TABLE affiliated_with(
   physician          INTEGER  NOT NULL  
  ,department         INTEGER  NOT NULL
  ,primaryaffiliation VARCHAR(1) NOT NULL
);
INSERT INTO affiliated_with(physician,department,primaryaffiliation) 
VALUES (1,1,'t'),
(2,1,'t'),
(3,1,'f'),
(3,2,'t'),
(4,1,'t'),
(5,1,'t'),
(6,2,'t'),
(7,1,'f'),
(7,2,'t'),
(8,1,'t'),
(9,3,'t');

--Prescribes Table
CREATE TABLE prescribes(
   physician   INTEGER  NOT NULL  
  ,patient     INTEGER  NOT NULL
  ,medication  INTEGER  NOT NULL
  ,date        VARCHAR(15) NOT NULL
  ,appointment INTEGER 
  ,dose        INTEGER  NOT NULL
);


INSERT INTO prescribes(physician,patient,medication,date,appointment,dose) 
VALUES (1,100000001,1,'24/4/2008',13216584,5),
 (9,100000004,2,'27/4/2008',86213939,10),
 (9,100000004,2,'30/4/2008',NULL,5);

--TABLE STAY

CREATE TABLE STAY(
   stayid       INTEGER  NOT NULL  
  ,patient    Integer NOT NULL
	,room Integer NOT NULL 
  ,start_dt     VARCHAR(10)  NOT NULL
  ,end_dt       VARCHAR(10)  NOT NULL
);


INSERT INTO STAY(stayid,patient,room,start_dt,end_dt) 
VALUES (3215,100000001 ,111,'1/5/2008','4/5/2008'),
(3216,100000003 ,123,'3/5/2008','14/5/2008'),
(3217,100000004,112,'2/5/2008','3/5/2008');


--Table Oncall

CREATE TABLE on_call(
   nurse       INTEGER  NOT NULL  
  ,blockkfloor INTEGER  NOT NULL
  ,blockcode   INTEGER  NOT NULL
  ,oncall      DATE  NOT NULL
  ,ONCALLEND   Date Default CURRENT_DATE
);

INSERT INTO on_call(nurse,blockkfloor,blockcode,oncall,ONCALLEND) 
VALUES (101,1,1,'4/11/2008','4/11/2008'),
 (101,1,2,'4/11/2008','4/11/2008'),
 (102,1,3,'4/11/2008','4/11/2008'),
 (103,1,1,'4/11/2008','4/11/2008'),
 (103,1,2,'4/11/2008','4/11/2008'),
 (103,1,3,'4/11/2008','4/11/2008');



--Table Undergoes

CREATE TABLE Undergoes(
   patient        INTEGER  NOT NULL  
  ,procedure      INTEGER  NOT NULL
  ,stay           INTEGER  NOT NULL
  ,date           VARCHAR(9) NOT NULL
  ,physician      INTEGER  NOT NULL
  ,assistingnurse       INTEGER 
);


INSERT INTO Undergoes(patient,procedure,stay,date,physician,assistingnurse) 
VALUES (100000001,6,3215,'2/5/2008',3,101),
(100000001,2,3215,'3/5/2008',7,101),
(100000004,1,3217,'7/5/2008',3,102),
(100000004,5,3217,'9/5/2008',6,NULL),
(100000001,7,3217,'10/5/2008',7,101),
(100000004,4,3217,'13/5/2008',3,103);

