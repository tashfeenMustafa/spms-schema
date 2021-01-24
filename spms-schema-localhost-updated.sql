CREATE database spmsdatabaseupdated;
USE spmsdatabaseupdated;

CREATE TABLE ACCOUNT (
	accountID INT UNSIGNED NOT NULL,
    firstName VARCHAR(30),
    lastName VARCHAR(30),
    address VARCHAR(100),
    phoneNumber VARCHAR(11),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(20),
    accountType VARCHAR(20) CHECK (accountType IN ('Faculty', 'Student', 'Admin', 'Accreditor', 'Management')),
    
    CONSTRAINT PRIMARY KEY (accountID)
);

CREATE TABLE ADMIN (
	adAccountID INT UNSIGNED NOT NULL,
    role VARCHAR(100),

	CONSTRAINT PRIMARY KEY (adAccountID),
    
    CONSTRAINT ADMIN_FK FOREIGN KEY (adAccountID) 
		REFERENCES ACCOUNT (accountID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE ADMIN_TASKS (
	adAccountID INT UNSIGNED NOT NULL,
    task VARCHAR(200) NOT NULL,
    
    CONSTRAINT PRIMARY KEY (adAccountID, task),
    
    CONSTRAINT ADMINTASK_FK FOREIGN KEY (adAccountID) 
		REFERENCES ADMIN (adAccountID)
);

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1, 'John', 'Doe', '01221122346', 'johndoe@uni.com', '1234',  'Admin');
INSERT INTO ADMIN (adAccountID) VALUES (1);
INSERT INTO ADMIN_TASKS (adAccountID, task) VALUES (1, 'Add Current Semester');

CREATE TABLE ACCREDITOR (
	acAccountID INT UNSIGNED NOT NULL,
    institution VARCHAR(300),
    
    CONSTRAINT PRIMARY KEY (acAccountID),
    
    CONSTRAINT ACCREDITOR_FK FOREIGN KEY (acAccountID) 
		REFERENCES ACCOUNT (accountID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE ACCREDITOR_SPECIALIZATION (
	acAccountID INT UNSIGNED NOT NULL,
    specialization VARCHAR(300) NOT NULL,
    
    CONSTRAINT PRIMARY KEY (acAccountID, specialization),
    
    CONSTRAINT ACCREDITOR_SPECIALIZATION_FK FOREIGN KEY (acAccountID) 
		REFERENCES ACCREDITOR (acAccountID)
);

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (22, 'Jane', 'Doe', '01456445678', 'janedoe@uni.com', '1234',  'Accreditor');
INSERT INTO ACCREDITOR (acAccountID) VALUES (22);

CREATE TABLE FACULTY (
	fAccountID INT UNSIGNED NOT NULL,
    deptID CHAR(255),
    dateHired DATE,
    specialization VARCHAR(500),
    
    CONSTRAINT PRIMARY KEY (fAccountID),
    
    CONSTRAINT FOREIGN KEY (fAccountID) 
		REFERENCES ACCOUNT (accountID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER TABLE FACULTY
ADD CONSTRAINT FACULTY_FK1 FOREIGN KEY (deptID) 
		REFERENCES DEPARTMENT (deptID)
        ON UPDATE CASCADE ON DELETE RESTRICT;

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (231092, 'Arthur', 'Doe', '01453689612', 'arthurdoe@uni.com', '1234',  'Faculty');
INSERT INTO FACULTY (fAccountID) VALUES (231092);
UPDATE FACULTY
	SET deptID = 'CSE'
    WHERE fAccountID = 231092;
INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (111000, 'Johnny', 'Doe', '01453689612', 'arthurdoe@uni.com', '1234',  'Faculty');
INSERT INTO FACULTY (fAccountID) VALUES (111000);
UPDATE FACULTY
	SET deptID = 'CSE'
    WHERE fAccountID = 111000;
INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (333000, 'Marry', 'Doe', '01453689612', 'marydoe@uni.com', '1234',  'Faculty');
INSERT INTO FACULTY (fAccountID, deptID) VALUES (333000, 'CSE');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (777000, 'Anne', 'Doe', '01453689612', 'annedoe@uni.com', '1234',  'Faculty');
INSERT INTO FACULTY (fAccountID, deptID) VALUES (777000, 'CSE');

CREATE TABLE SCHOOL (
	schoolName VARCHAR(500) NOT NULL,
    location CHAR(255),
    deanInCharge VARCHAR(200),
    
    CONSTRAINT PRIMARY KEY (schoolName)
);

INSERT INTO SCHOOL (schoolName, location, deanInCharge) VALUES ('School of Engineering, Technology & Services', NULL, 'Prof. Yusuf Mahbubul Islam');

CREATE TABLE DEPARTMENT (
	deptID CHAR(255) NOT NULL,
    schoolName VARCHAR(500),
    deptName VARCHAR(500),
    location CHAR(255),
    deptHeadID INT UNSIGNED DEFAULT NULL,
    
    CONSTRAINT PRIMARY KEY (deptID),
    
    CONSTRAINT DEPARTMENT_FK1 FOREIGN KEY
    (schoolName) REFERENCES SCHOOL (schoolName),
    
    CONSTRAINT DEPARTMENT_FK2 FOREIGN KEY
    (deptHeadID) REFERENCES FACULTY (fAccountID)
);

INSERT INTO DEPARTMENT (deptID, schoolName, deptName, location, deptHeadID) VALUES ('CSE', 'School of Engineering, Technology & Services', 'Department of Computer Science & Engineering', NULL, 231092);

CREATE TABLE STUDENT (
	sAccountID INT UNSIGNED NOT NULL,
    deptID CHAR(255) DEFAULT NULL,
    degreeID VARCHAR(500) DEFAULT NULL,
    dateOfAdmission DATE,
    studentType VARCHAR(200),
    
    CONSTRAINT PRIMARY KEY (sAccountID),
    
    CONSTRAINT STUDENT_FK FOREIGN KEY (sAccountID) 
		REFERENCES ACCOUNT (accountID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT STUDENT_FK1 FOREIGN KEY (deptID) 
		REFERENCES DEPARTMENT (deptID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
	CONSTRAINT STUDENT_FK2 FOREIGN KEY (degreeID) 
		REFERENCES DEGREE_PROGRAM(degreeID)
);

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (183454, 'Jemma', 'Doe', '01457665679', 'jemmadoe@uni.com', '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (183454, 'CSE', 'CSE', NULL, 'Undergraduate');
INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1416455, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1416455, 'CSE', 'CSE', NULL, 'Undergraduate');
INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1579288, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1579288, 'CSE', 'CSC', NULL, 'Undergraduate');
INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1528882, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1528882, 'CSE', 'CSC', NULL, 'Undergraduate');
INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1653725, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1653725, 'CSE', 'CSC', NULL, 'Undergraduate');
INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1625654, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1625654, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1669953, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1669953, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1665555, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1665555, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1616161, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1616161, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1633554, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1633554, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1645333, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1645333, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1691291, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1691291, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1662147, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1662147, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1691483, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1691483, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1674181, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1674181, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1641252, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1641252, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1695837, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1695837, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1613273, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1613273, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1612985, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1612985, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1623112, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1623112, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1668314, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1668314, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1622731, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1622731, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1696326, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1696326, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1646434, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1646434, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1614142, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1614142, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1654432, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1654432, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1678812, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1678812, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1614733, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1614733, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1665491, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1665491, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1634352, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1634352, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1661638, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1661638, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1686272, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1686272, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1729416, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1729416, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1763881, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1763881, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1781682, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1781682, 'CSE', 'CSE', NULL, 'Undergraduate');

#######

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1778274, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1778274, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1795656, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1795656, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1773277, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1773277, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1759787, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1759787, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1743714, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1743714, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1747457, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1747457, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1728125, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1728125, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1783512, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1783512, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1768463, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1768463, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1797625, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1797625, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1754681, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1754681, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1798883, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1798883, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1769463, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1769463, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1766156, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1766156, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1772947, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1772947, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1731817, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1731817, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1752538, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1752538, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1731852, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1731852, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1766176, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1766176, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1715578, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1715578, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1745484, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1745484, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1791753, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1791753, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1742892, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1742892, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1788337, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1788337, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1736425, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1736425, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1728439, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1728439, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1712983, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1712983, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1781682, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1781682, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1718437, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1718437, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1784847, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1784847, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1737824, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1737824, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1797789, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1797789, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1728139, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1728139, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1711619, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1711619, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1789481, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1789481, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1711729, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1711729, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1773384, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1773384, 'CSE', 'CSE', NULL, 'Undergraduate');

#########

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1762565, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1762565, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1898334, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1898334, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1863951, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1863951, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1835298, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1835298, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1835874, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1835874, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1849651, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1849651, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1872128, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1872128, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1887973, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1887973, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1886577, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1886577, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1877262, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1877262, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1873255, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1873255, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1834433, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1834433, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1868128, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1868128, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1845457, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1845457, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1855787, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1855787, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1893863, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1893863, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1892367, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1892367, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1763881, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1763881, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1763881, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1763881, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1842333, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1842333, 'CSE', 'CSE', NULL, 'Undergraduate');

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1729416, NULL, NULL, NULL, NULL, '1234',  'Student');
INSERT INTO STUDENT (sAccountID, deptID, degreeID, dateOfAdmission, studentType) VALUES (1729416, 'CSE', 'CSE', NULL, 'Undergraduate');

CREATE TABLE DEGREE_PROGRAM (
	degreeID CHAR(255) NOT NULL,
    degreeTitle VARCHAR(500) NOT NULL,
    deptID CHAR(255),
    
    CONSTRAINT PRIMARY KEY (degreeID),
    
    CONSTRAINT UNIQUE (degreeTitle),
    
    CONSTRAINT FOREIGN KEY (deptID) 
		REFERENCES DEPARTMENT (deptID) 
        ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO DEGREE_PROGRAM (degreeID, degreeTitle, deptID) VALUES ('CSE', 'B.Sc. in Computer Science & Engineering', 'CSE');
INSERT INTO DEGREE_PROGRAM (degreeID, degreeTitle, deptID) VALUES ('CSC', 'B.Sc. in Computer Science', 'CSE');
INSERT INTO DEGREE_PROGRAM (degreeID, degreeTitle, deptID) VALUES ('CEC', 'B.Sc. in Computer Engineering', 'CSE');

CREATE TABLE PROGRAM_LEARNING_OUTCOME (
	PLOID CHAR(255) NOT NULL,
    PLOtitle VARCHAR(500),
    PLOdescription VARCHAR(1000),
    degreeID CHAR(255),
    
    INDEX(degreeID),
    
    CONSTRAINT PRIMARY KEY (PLOID),
    
    CONSTRAINT PLO_FK1 FOREIGN KEY (degreeID) 
		REFERENCES DEGREE_PROGRAM (degreeID)
		ON UPDATE CASCADE ON DELETE RESTRICT
);
select * from PROGRAM_LEARNING_OUTCOME;
INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO1', 'Knowledge', 'An ability to select and apply the knowledge, techniques, skills, and modern tools of the computer science and engineering discipline', 'CSE');
    
INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO2', 'Requirement Analysis', 'An ability to identify, analyze, and solve a problem by defining the computing requirements of the problem through effectively gathering of the actual requirements', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO3', 'Problem Analysis', 'An ability to select and apply the knowledge of mathematics, science, engineering, and technology to computing problems that require the application of principles and applied procedures or methodologies', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO4', 'Design', 'An ability to design computer based systems, components, or processes to meet the desire requirement;', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO5', 'Problem Solving', 'An ability to apply mathematical foundations, simulation, algorithmic principles, and computer science theory in the modeling and design of computer-based systems in a way that demonstrates comprehension of the tradeoffs involved in design choices.', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO6', 'Implementation', 'An ability to apply design and development principles in the construction of software systems of varying complexity.', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO7', 'Experiment and Analysis', 'An ability to conduct standard tests and measurements; to conduct, analyze, and interpret experiments; and to apply experimental results to improve solutions (products or processes).', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO8', 'Community Engagement & Engg.', 'An ability to appreciate human behavior, culture, interaction and organization through studies in the humanities and social sciences. A knowledge of the impact of computing solutions in a local and global context.', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO9', 'Teamwork', 'An ability to function effectively as a member or leader of a technical team to accomplish common goals.', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO10', 'Communication', 'An ability to apply written and oral communication in both technical and nontechnical environments; an ability to communicate with a range of audience; and an ability to identify and use appropriate available technical literature.', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO11', 'Self-Motivated', 'Recognition of the need for and an ability to engage in self-directed continuing professional development; prepared to enter a top-ranked graduate program in Computer Science and Engineering.', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO12', 'Ethics', 'An understanding of and a commitment to address professional, ethical, legal, security, social issues and responsibilities including a respect for diversity.', 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO13', 'Process Management', 'A commitment to quality, timeliness, and continuous improvement.', 'CSE');

CREATE TABLE COURSE (
	courseID VARCHAR(6) NOT NULL,
    courseTitle VARCHAR(200),
    courseDescription LONGTEXT,
    creditHour DECIMAL(3, 2),
    deptID CHAR(255),
    courseType VARCHAR(200),
	passingThreshold FLOAT,
    
    
    CONSTRAINT PRIMARY KEY (courseID),
    
    CONSTRAINT COURSE_FK1 FOREIGN KEY (deptID) 
		REFERENCES DEPARTMENT (deptID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
## insert courseID CSC100

INSERT INTO COURSE (courseID, courseTitle, courseDescription, creditHour, deptID, courseType, passingThreshold) VALUES ('CSC100', 'Introduction To Basic Programming', NULL, 3.0, 'CSE', 'Major', NULL);

## insert courseID CSC101

INSERT INTO COURSE (courseID, courseTitle, courseDescription, creditHour, deptID, courseType, passingThreshold) VALUES ('CSC101', 'Introduction to Computer Programming', NULL, 4.0, 'CSE', 'Foundation', NULL);

## insert courseID CSE201

INSERT INTO COURSE (courseID, courseTitle, courseDescription, creditHour, deptID, courseType, passingThreshold) VALUES ('CSE201', 'Discrete Mathematics', NULL, 3.0, 'CSE', 'Major', NULL);

## insert courseID CSE203

INSERT INTO COURSE (courseID, courseTitle, courseDescription, creditHour, deptID, courseType, passingThreshold) VALUES ('CSE203', 'Data Structure', NULL, 4.0, 'CSE', 'Major', NULL);

## insert courseID CSE303

INSERT INTO COURSE (courseID, courseTitle, courseDescription, creditHour, deptID, courseType, passingThreshold) VALUES ('CSE303', 'Database Management', NULL, 4.0, 'CSE', 'Major', NULL);
UPDATE COURSE 
	SET passingThreshold = 40
    WHERE courseID = 'CSE303';

CREATE TABLE DEGREE_PROGRAM_COURSE (
	degreeID CHAR(255) NOT NULL,
    courseID VARCHAR(6) NOT NULL,
    
    CONSTRAINT PRIMARY KEY (degreeID, courseID),
    
    CONSTRAINT DEGREE_PROGRAM_COURSE_FK1 FOREIGN KEY (degreeID) 
		REFERENCES DEGREE_PROGRAM (degreeID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT DEGREE_PROGRAM_COURSE_FK2 FOREIGN KEY (courseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
## insert courseID CSC100 related degree

INSERT INTO DEGREE_PROGRAM_COURSE (degreeID, courseID) VALUES ('CSC', 'CSC100');

## insert courseID CSC101 related degrees

INSERT INTO DEGREE_PROGRAM_COURSE (degreeID, courseID) VALUES ('CSC', 'CSC101');
INSERT INTO DEGREE_PROGRAM_COURSE (degreeID, courseID) VALUES ('CSE', 'CSC101');

## insert courseID CSE201 related degree

INSERT INTO DEGREE_PROGRAM_COURSE (degreeID, courseID) VALUES ('CSE', 'CSE201');

## insert courseID CSE203 related degree

INSERT INTO DEGREE_PROGRAM_COURSE (degreeID, courseID) VALUES ('CSE', 'CSE203');

## insert courseID CSE303 related degree

INSERT INTO DEGREE_PROGRAM_COURSE (degreeID, courseID) VALUES ('CSE', 'CSE303');

CREATE TABLE PREREQUISITE_COURSE (
	courseID VARCHAR(6) NOT NULL,
    prerequisiteCourseID VARCHAR(6) DEFAULT NULL,
    
    CONSTRAINT PRIMARY KEY (courseID, prerequisiteCourseID),
    
    CONSTRAINT PREREQUISITE_COURSE_FK1 FOREIGN KEY (courseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT PREREQUISITE_COURSE_FK2 FOREIGN KEY (prerequisiteCourseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## insert courseID CSC101 related prereq courses

INSERT INTO PREREQUISITE_COURSE (courseID, prerequisiteCourseID) VALUES ('CSC101', 'CSC100');

## insert courseID CSE201 related prereq courses

INSERT INTO PREREQUISITE_COURSE (courseID, prerequisiteCourseID) VALUES ('CSE201', 'CSC101');

## insert courseID CSE203 related prereq courses

INSERT INTO PREREQUISITE_COURSE (courseID, prerequisiteCourseID) VALUES ('CSE203', 'CSE201');

## insert courseID CSE303 related prereq courses

INSERT INTO PREREQUISITE_COURSE (courseID, prerequisiteCourseID) VALUES ('CSE303', 'CSE203');

CREATE TABLE COURSE_OUTCOME (
	COID CHAR(255) NOT NULL,
    courseID VARCHAR(6) NOT NULL,
    COdescription LONGTEXT,
    domain VARCHAR(20),
    level VARCHAR(20),
    keyword VARCHAR(20),
    
    CONSTRAINT PRIMARY KEY (COID, courseID),
    
    CONSTRAINT COURSE_OUTCOME_FK1 FOREIGN KEY (courseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## insert courseID CSC100 related course outcomes

INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO1', 'CSC100', 'Basic understanding of the structure and operation of a computer', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO2', 'CSC100', 'Explain and interpret internal data representations', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO3', 'CSC100', 'Basic understanding of the role of algorithms in problem solving', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO4', 'CSC100', 'Knowledge of elementary code development in a modern programming language', NULL, NULL, NULL);

## insert courseID CSC101 related course outcomes

INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO1', 'CSC101', 'Know about different data types, operators and memory access techniques. Reason about interleaved statements operating on a shared data structure', 'Cognitive', 'Level - 3', NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO2', 'CSC101', 'Reason about compile errors, common runtime errors (e.g. NullPE) and logical errors in given short code segments', 'Cognitive', 'Level - 2', NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO3', 'CSC101', 'Reason about short-circuiting & different code paths for different data control structures and repeat structures', 'Psychomotor', 'Level - 3', NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO4', 'CSC101', 'Know about procedural coding and in-line coding, direction and indirection operators, call by value and call by reference. Reason about computational cost, and return values', 'Cognitive', 'Level - 4', NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO5', 'CSC101', 'Competence in using an industry-standard fully-featured modern IDE (e.g. Visual Studio, CodeBlocks) as a development tool.', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO6', 'CSC101', 'Know how to analyze and solve a problem formally.', NULL, NULL, NULL);

## insert courseID CSE201 related course outcomes

INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO1', 'CSE201', 'Understand concepts of counting, and sets. Understand different concepts of Bounds and Order (big-O, Omega and Theta) with running time for simple pseudo-code examples, especially recursive examples. Includes finding closed-forms for recursively-defined formulas using unrolling and recursion trees', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO2', 'CSE201', 'Understand recurrence and recursive functions.', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO3', 'CSE201', 'Know the basics of FOL (First Order Logic), Apply predicate logic: determine the truth of statements, perform simple transformations (esp. negation), accurately apply formal definitions (esp. vacuous truth cases, attention to variable types and scope)', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO4', 'CSE201', 'Understand different proof techniques (Proof by Construction/Contradiction/Induction) and be able to apply them.', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO5', 'CSE201', 'State and apply basic definitions, facts, and notation for commonly used discrete mathematics and graph theoretic constructs like graphs and trees.', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO6', 'CSE201', 'Classify the complexity problem solving in terms of countable versus uncountable, polynomial versus exponential (P vs. NP), decidable versus undecidable. Know existence of different knowledge domains: Known, Unknown, Unknowable.', NULL, NULL, NULL);

## insert courseID CSE203 related course outcomes

INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO1', 'CSE203', 'Good understanding of dynamic memory allocation as opposed to Static memory allocation, difference between random memory access structures (Array) and pointer based memory access (Linked List). Be able to navigate, organize, and compile C++ projects of moderate complexity (many objects and dependencies).', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO2', 'CSE203', 'Decompose a problem into its supporting data structures such as lists, stacks, queues, trees, etc.', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO3', 'CSE203', 'Know different search techniques (BFS, DFS). To be able to decide on appropriate data structure to implement efficient algorithms. To be able to solve problems using techniques like graph search, tree traversal, optimization, data organization, etc.', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO4', 'CSE203', 'Implement classic and adapted data structures and applications.', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO5', 'CSE203', 'Analyze the efficiency of implementation choices.', NULL, NULL, NULL);

## insert courseID CSE203 related course outcomes

INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO1', 'CSE303', 'Proficiency in the design of database applications starting from the conceptual design to the implementation of database schemas and user interfaces.', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO2', 'CSE303', 'Solid foundation on database design concepts, data models (E/R model, relational model), the database query language SQL, and components of a database management system.', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO3', 'CSE303', 'Basic understanding of data access structures, query processing and optimization techniques, and transaction management.', NULL, NULL, NULL);
INSERT INTO COURSE_OUTCOME (COID, courseID, COdescription, domain, level, keyword) VALUES ('CO4', 'CSE303', 'Implement user interfaces and database using appropriate tools.', NULL, NULL, NULL);

CREATE TABLE CO_PLO_MAPPING  (
	COID CHAR(255) NOT NULL,
    courseID VARCHAR(6) NOT NULL,
    PLOID CHAR(255) NOT NULL,

    CONSTRAINT PRIMARY KEY (COID, courseID, PLOID),
    
    CONSTRAINT CO_PLO_MAPPING_FK1 FOREIGN KEY (courseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT CO_PLO_MAPPING_FK2 FOREIGN KEY (COID) 
		REFERENCES COURSE_OUTCOME (COID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT CO_PLO_MAPPING_FK3 FOREIGN KEY (PLOID) 
		REFERENCES PROGRAM_LEARNING_OUTCOME (PLOID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## insert courseID CSC101 related CO-PLO mapping

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSC101', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSC101', 'PLO2');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSC101', 'PLO3');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSC101', 'PLO12');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSC101', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSC101', 'PLO3');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSC101', 'PLO5');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSC101', 'PLO7');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSC101', 'PLO3');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSC101', 'PLO4');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSC101', 'PLO7');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO4', 'CSC101', 'PLO2');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO4', 'CSC101', 'PLO3');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO4', 'CSC101', 'PLO5');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO5', 'CSC101', 'PLO6');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO5', 'CSC101', 'PLO9');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO5', 'CSC101', 'PLO13');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO6', 'CSC101', 'PLO2');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO6', 'CSC101', 'PLO3');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO6', 'CSC101', 'PLO5');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO6', 'CSC101', 'PLO6');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO6', 'CSC101', 'PLO13');

## insert courseID CSE201 related CO-PLO mapping

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE201', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE201', 'PLO3');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE201', 'PLO4');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE201', 'PLO5');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE201', 'PLO6');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE201', 'PLO7');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSE201', 'PLO3');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSE201', 'PLO5');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE201', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE201', 'PLO5');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE201', 'PLO6');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE201', 'PLO7');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO4', 'CSE201', 'PLO5');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO4', 'CSE201', 'PLO10');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO4', 'CSE201', 'PLO11');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO5', 'CSE201', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO5', 'CSE201', 'PLO6');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO6', 'CSE201', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO6', 'CSE201', 'PLO7');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO6', 'CSE201', 'PLO10');

## insert courseID CSE203 related CO-PLO mapping

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE203', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE203', 'PLO2');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE203', 'PLO4');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE203', 'PLO5');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE203', 'PLO6');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE203', 'PLO9');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE203', 'PLO13');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSE203', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSE203', 'PLO2');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSE203', 'PLO3');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSE203', 'PLO4');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSE203', 'PLO7');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE203', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE203', 'PLO2');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE203', 'PLO3');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE203', 'PLO4');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE203', 'PLO7');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE203', 'PLO9');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE203', 'PLO10');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO4', 'CSE203', 'PLO5');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO4', 'CSE203', 'PLO6');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO5', 'CSE203', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO5', 'CSE203', 'PLO2');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO5', 'CSE203', 'PLO7');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO5', 'CSE203', 'PLO10');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO5', 'CSE203', 'PLO12');

## insert courseID CSE303 related CO-PLO mapping

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE303', 'PLO2');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE303', 'PLO4');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE303', 'PLO6');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE303', 'PLO12');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO1', 'CSE303', 'PLO13');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSE303', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSE303', 'PLO2');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO2', 'CSE303', 'PLO3');

INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE303', 'PLO1');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE303', 'PLO4');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE303', 'PLO5');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE303', 'PLO6');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO3', 'CSE303', 'PLO6');
INSERT INTO CO_PLO_MAPPING (COID, courseID, PLOID) VALUES ('CO4', 'CSE303', 'PLO6');

CREATE TABLE SEMESTER (
	season VARCHAR(50) NOT NULL,
    year YEAR NOT NULL,
    startDate DATE,
    endDate DATE,

    CONSTRAINT PRIMARY KEY (season, year)
);

## semester information

INSERT INTO SEMESTER (season, year) VALUES ('Summer', 2020);
INSERT INTO SEMESTER (season, year) VALUES ('Spring', 2020);
INSERT INTO SEMESTER (season, year) VALUES ('Autumn', 2020);
INSERT INTO SEMESTER (season, year) VALUES ('Summer', 2019);
INSERT INTO SEMESTER (season, year) VALUES ('Spring', 2019);
INSERT INTO SEMESTER (season, year) VALUES ('Autumn', 2019);

CREATE TABLE OFFERED_COURSES (
	offeredCourseID VARCHAR(6) NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    courseCoordinatorID INT UNSIGNED,
    
    CONSTRAINT PRIMARY KEY (offeredCourseID, semesterSeason, semesterYear),
    
    CONSTRAINT OFFERED_COURSES_FK1 FOREIGN KEY (offeredCourseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT OFFERED_COURSES_FK2 FOREIGN KEY (semesterSeason, semesterYear) 
		REFERENCES SEMESTER (season, year)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT OFFERED_COURSES_FK3 FOREIGN KEY (courseCoordinatorID) 
		REFERENCES FACULTY (fAccountID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## offered courses info

INSERT INTO OFFERED_COURSES (offeredCourseID, semesterSeason, semesterYear, courseCoordinatorID) VALUES ('CSE303', 'Summer', 2020, 231092);
INSERT INTO OFFERED_COURSES (offeredCourseID, semesterSeason, semesterYear, courseCoordinatorID) VALUES ('CSE203', 'Summer', 2020, 333000);

CREATE TABLE SECTION (
	sectionNumber TINYINT UNSIGNED NOT NULL,
    offeredCourseID VARCHAR(6) NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    startTime TIME,
    endTime TIME,
    roomNumber VARCHAR(6),
    capacity INT UNSIGNED,
    courseInstructorID INT UNSIGNED,
    
    CONSTRAINT PRIMARY KEY (sectionNumber, offeredCourseID, semesterSeason, semesterYear),
    
    CONSTRAINT SECTION_FK1 FOREIGN KEY (offeredCourseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT SECTION_FK2 FOREIGN KEY (semesterSeason, semesterYear) 
		REFERENCES SEMESTER (season, year)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT SECTION_FK3 FOREIGN KEY (courseInstructorID) 
		REFERENCES FACULTY (fAccountID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## insert offered course CSE303 section info
INSERT INTO SECTION (sectionNumber, offeredCourseID, semesterSeason, semesterYear, startTime, endTime, roomNumber, capacity, courseInstructorID) VALUES (1, 'CSE303', 'Summer', 2020, NULL, NULL, NULL, NULL, 231092);
INSERT INTO SECTION (sectionNumber, offeredCourseID, semesterSeason, semesterYear, startTime, endTime, roomNumber, capacity, courseInstructorID) VALUES (2, 'CSE303', 'Summer', 2020, NULL, NULL, NULL, NULL, 333000);
INSERT INTO SECTION (sectionNumber, offeredCourseID, semesterSeason, semesterYear, startTime, endTime, roomNumber, capacity, courseInstructorID) VALUES (3, 'CSE303', 'Summer', 2020, NULL, NULL, NULL, NULL, 777000);

CREATE TABLE COURSE_ASSESSMENT (
	courseAssessmentID INT UNSIGNED NOT NULL,
    sectionNumber TINYINT UNSIGNED NOT NULL,
    offeredCourseID VARCHAR(6) NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    totalMarksConvertedBy DOUBLE,
    assessmentTitle VARCHAR(200),
    totalMarks DOUBLE,
    
    CONSTRAINT PRIMARY KEY (courseAssessmentID),
    
    CONSTRAINT COURSE_ASSESSMENT_FK1 FOREIGN KEY (sectionNumber) 
		REFERENCES SECTION (sectionNumber)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT COURSE_ASSESSMENT_FK2 FOREIGN KEY (offeredCourseID) 
		REFERENCES SECTION (offeredCourseID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT COURSE_ASSESSMENT_FK3 FOREIGN KEY (semesterSeason, semesterYear) 
		REFERENCES SECTION (semesterSeason, semesterYear)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## insert offered course CSE303 section 1 course assessment related info
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (1, 1, 'CSE303', 'Summer', 2020, 30, 'Midterm', 150);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (2, 1, 'CSE303', 'Summer', 2020, 40, 'Final', 100);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (3, 1, 'CSE303', 'Summer', 2020, 0, 'Project Work', 30);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (4, 1, 'CSE303', 'Summer', 2020, 0, 'Quiz 1', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (5, 1, 'CSE303', 'Summer', 2020, 0, 'Quiz 2', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (6, 1, 'CSE303', 'Summer', 2020, 0, 'Quiz 3', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (7, 1, 'CSE303', 'Summer', 2020, 0, 'Quiz 4', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (8, 1, 'CSE303', 'Summer', 2020, 0, 'Quiz 5', 20);
    
## insert offered course CSE303 section 2 course assessment related info
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (9, 2, 'CSE303', 'Summer', 2020, 30, 'Midterm', 150);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (10, 2, 'CSE303', 'Summer', 2020, 40, 'Final', 100);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (11, 2, 'CSE303', 'Summer', 2020, 0, 'Project Work', 30);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (12, 2, 'CSE303', 'Summer', 2020, 0, 'Quiz 1', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (13, 2, 'CSE303', 'Summer', 2020, 0, 'Quiz 2', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (14, 2, 'CSE303', 'Summer', 2020, 0, 'Quiz 3', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (15, 2, 'CSE303', 'Summer', 2020, 0, 'Quiz 4', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (16, 2, 'CSE303', 'Summer', 2020, 0, 'Quiz 5', 20);
    
## insert offered course CSE303 section 3 course assessment related info
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (17, 3, 'CSE303', 'Summer', 2020, 30, 'Midterm', 150);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (18, 3, 'CSE303', 'Summer', 2020, 40, 'Final', 100);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (19, 3, 'CSE303', 'Summer', 2020, 0, 'Project Work', 30);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (20, 3, 'CSE303', 'Summer', 2020, 0, 'Quiz 1', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (21, 3, 'CSE303', 'Summer', 2020, 0, 'Quiz 2', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (22, 3, 'CSE303', 'Summer', 2020, 0, 'Quiz 3', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (23, 3, 'CSE303', 'Summer', 2020, 0, 'Quiz 4', 20);
INSERT INTO COURSE_ASSESSMENT (courseAssessmentID, sectionNumber, offeredCourseID, semesterSeason, semesterYear, totalMarksConvertedBy, assessmentTitle, totalMarks)
	VALUES (24, 3, 'CSE303', 'Summer', 2020, 0, 'Quiz 5', 20);

CREATE TABLE QUESTION (
	courseAssessmentID INT UNSIGNED NOT NULL,
    questionNumber TINYINT UNSIGNED NOT NULL,
    fullMarks DOUBLE,
    description VARCHAR(3000),
    assignedCourseOutcomeID CHAR(255),
    assignedCourseID VARCHAR(6) NOT NULL,
    
    CONSTRAINT PRIMARY KEY (courseAssessmentID, questionNumber),
    
    CONSTRAINT QUESTION_FK1 FOREIGN KEY (courseAssessmentID) 
		REFERENCES COURSE_ASSESSMENT (courseAssessmentID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT QUESTION_FK2 FOREIGN KEY (assignedCourseOutcomeID, assignedCourseID) 
		REFERENCES COURSE_OUTCOME (COID, courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## insert question for course assessments of section 1
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (1, 1, 25, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (1, 2, 25, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (1, 3, 30, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (1, 4, 20, NULL, 'CO2', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (1, 5, 30, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (1, 6, 20, NULL, 'CO1', 'CSE303');

INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (2, 1, 20, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (2, 2, 15, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (2, 3, 15, NULL, 'CO2', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (2, 4, 50, NULL, 'CO3', 'CSE303');

INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (3, 4, 30, NULL, 'CO4', 'CSE303');

INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (4, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (5, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (6, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (7, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (8, 1, 20, NULL, NULL, 'CSE303');
    
## insert question for course assessments of section 2
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (9, 1, 25, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (9, 2, 25, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (9, 3, 30, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (9, 4, 20, NULL, 'CO2', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (9, 5, 30, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (9, 6, 20, NULL, 'CO1', 'CSE303');

INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (10, 1, 20, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (10, 2, 15, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (10, 3, 15, NULL, 'CO2', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (10, 4, 50, NULL, 'CO3', 'CSE303');

INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (11, 4, 30, NULL, 'CO4', 'CSE303');

INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (12, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (13, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (14, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (15, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (16, 1, 20, NULL, NULL, 'CSE303');
    
## insert question for course assessments of section 3
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (17, 1, 25, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (17, 2, 25, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (17, 3, 30, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (17, 4, 20, NULL, 'CO2', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (17, 5, 30, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (17, 6, 20, NULL, 'CO1', 'CSE303');

INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (18, 1, 20, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (18, 2, 15, NULL, 'CO1', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (18, 3, 15, NULL, 'CO2', 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (18, 4, 50, NULL, 'CO3', 'CSE303');

INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (19, 4, 30, NULL, 'CO4', 'CSE303');

INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (20, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (21, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (22, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (23, 1, 20, NULL, NULL, 'CSE303');
INSERT INTO QUESTION (courseAssessmentID, questionNumber, fullMarks, description, assignedCourseOutcomeID, assignedCourseID) 
	VALUES (24, 1, 20, NULL, NULL, 'CSE303');
    
CREATE TABLE STUDENT_ENROLLMENT (
	enrolledCourseID VARCHAR(6) NOT NULL,
    sAccountID INT UNSIGNED NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    sectionNumber TINYINT UNSIGNED NOT NULL,
    totalMarksReceived FLOAT,
    
    CONSTRAINT PRIMARY KEY (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived),
    
    CONSTRAINT STUDENT_ENROLLMENT_FK1 FOREIGN KEY (enrolledCourseID) 
		REFERENCES OFFERED_COURSES (offeredCourseID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
    CONSTRAINT STUDENT_ENROLLMENT_FK2 FOREIGN KEY (sAccountID) 
		REFERENCES STUDENT (sAccountID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
    CONSTRAINT STUDENT_ENROLLMENT_FK3 FOREIGN KEY (semesterSeason, semesterYear) 
		REFERENCES OFFERED_COURSES (semesterSeason, semesterYear)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
    CONSTRAINT STUDENT_ENROLLMENT_FK4 FOREIGN KEY (sectionNumber) 
		REFERENCES SECTION (sectionNumber)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## inserting student enrollment data for CSE303 Section 1 Summer 2020

INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1416455, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1579288, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1625654, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1665555, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1613273, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1623112, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1696326, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1646434, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1614142, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1654432, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1661638, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1686272, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1778274, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1795656, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1747457, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1798883, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1766156, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1715578, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1745484, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1788337, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1728439, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1711619, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1711729, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1892367, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1872128, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1868128, 'Summer', 2020, 1, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1845457, 'Summer', 2020, 1, 0);
    
## inserting student enrollment data for CSE303 Section 2 Summer 2020
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1633554, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1645333, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1691291, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1641252, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1695837, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1668314, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1665491, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1763881, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1773277, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1759787, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1743714, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1728125, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1783512, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1768463, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1797625, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1754681, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1769463, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1731817, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1791753, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1712983, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1784847, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1789481, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1773384, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1762565, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1835874, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1886577, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1834433, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1855787, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1893863, 'Summer', 2020, 2, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1842333, 'Summer', 2020, 2, 0);

## inserting student enrollment data for CSE303 Section 3 Summer 2020
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1528882, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1653725, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1669953, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1616161, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1662147, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1691483, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1674181, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1612985, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1622731, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1678812, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1614733, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1634352, 'Summer', 2020, 3, 0);
    
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1729416, 'Summer', 2020, 3, 0);
    
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1781682, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1772947, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1752538, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1731852, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1766176, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1742892, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1736425, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1718437, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1737824, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1797789, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1728139, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1898334, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1863951, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1835298, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1849651, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1887973, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1877262, 'Summer', 2020, 3, 0);
INSERT INTO STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, totalMarksReceived) 
	VALUES ('CSE303', 1873255, 'Summer', 2020, 3, 0);


CREATE TABLE STUDENT_COURSE_ASSESSMENT (
	courseAssessmentID INT UNSIGNED NOT NULL,
    sAccountID INT UNSIGNED NOT NULL,
    totalMarksObtained DOUBLE,
    
    CONSTRAINT PRIMARY KEY (courseAssessmentID, sAccountID),
    
    CONSTRAINT STUDENT_COURSE_ASSESSMENT_FK1 FOREIGN KEY (courseAssessmentID) 
		REFERENCES COURSE_ASSESSMENT (courseAssessmentID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
    CONSTRAINT STUDENT_COURSE_ASSESSMENT_FK2 FOREIGN KEY (sAccountID) 
		REFERENCES STUDENT (sAccountID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## inserting total marks obtained by each student in midterms for section 1
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1416455, 44);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1579288, 35);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1625654, 40);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1665555, 33);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1613273, 20);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1623112, 49);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1696326, 36);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1646434, 0);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1614142, 45);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1654432, 87);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1661638, 45);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1686272, 14);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1778274, 46);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1795656, 61);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1747457, 14);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1798883, 33);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1766156, 72);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1715578, 53);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1745484, 19);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1788337, 85);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1728439, 58);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1711619, 64);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1711729, 6);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1892367, 59);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1872128, 54);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1868128, 88);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (1, 1845457, 20);
    
## inserting total marks obtained by each student in midterms for section 2
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1633554, 30);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1645333, 89);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1691291, 29);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1641252, 124);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1695837, 55);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1668314, 0);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1665491, 59);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1763881, 42);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1773277, 57);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1759787, 48);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1743714, 33);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1728125, 73);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1783512, 61);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1768463, 57);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1797625, 65);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1754681, 102);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1769463, 20);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1731817, 121);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1791753, 107);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1712983, 73);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1784847, 105);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1789481, 109);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1773384, 44);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1762565, 47);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1835874, 53);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1886577, 79);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1834433, 128);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1855787, 71);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1893863, 26);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (9, 1842333, 55);

## inserting total marks obtained by each student in midterms for section 3
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1528882, 26);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1653725, 0);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1669953, 5);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1616161, 69);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1662147, 25);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1691483, 35);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1674181, 38);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1612985, 42);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1622731, 0);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1678812, 17);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1614733, 0);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1634352, 60);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1729416, 71);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1781682, 39);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1772947, 82);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1752538, 35);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1731852, 37);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1766176, 84);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1742892, 10);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1736425, 98);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1718437, 92);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1737824, 87);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1797789, 23);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1728139, 30);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1898334, 35);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1863951, 98);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1835298, 95);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1849651, 70);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1887973, 62);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1877262, 106);
INSERT INTO STUDENT_COURSE_ASSESSMENT (courseAssessmentID, sAccountID, totalMarksObtained)
	VALUES (17, 1873255, 106);


CREATE TABLE STUDENT_QUESTION (
	courseAssessmentID INT UNSIGNED NOT NULL,
    questionNumber TINYINT UNSIGNED NOT NULL,
    sAccountID INT UNSIGNED NOT NULL,
    marksObtained DOUBLE,
    
    CONSTRAINT PRIMARY KEY (courseAssessmentID, questionNumber, sAccountID),
    
    CONSTRAINT STUDENT_QUESTION_FK1 FOREIGN KEY (courseAssessmentID, questionNumber) 
		REFERENCES QUESTION (courseAssessmentID, questionNumber)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT STUDENT_QUESTION_FK2 FOREIGN KEY (sAccountID) 
		REFERENCES STUDENT (sAccountID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## student's data for marks obtained for each question of the midterm/final/project for section 1
## student id = 1416455
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1416455, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1416455, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1416455, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1416455, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1416455, 2);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1416455, 7);
    
# final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1416455, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1416455, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1416455, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1416455, 28);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1416455, 24);
    
## student id = 1579288
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1579288, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1579288, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1579288, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1579288, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1579288, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1579288, 12);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1579288, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1579288, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1579288, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1579288, 23);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1579288, 23);
    
## student id = 1625654
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1625654, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1625654, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1625654, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1625654, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1625654, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1625654, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1625654, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1625654, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1625654, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1625654, 4);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1625654, 24);
    
## student id = 1665555
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1665555, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1665555, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1665555, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1665555, 6);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1665555, 2);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1665555, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1665555, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1665555, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1665555, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1665555, 4);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1665555, 27);
    
## student id = 1613273
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1613273, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1613273, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1613273, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1613273, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1613273, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1613273, 4);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1613273, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1613273, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1613273, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1613273, 4);

## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1613273, 12);

## student id = 1623112
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1623112, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1623112, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1623112, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1623112, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1623112, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1623112, 8);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1623112, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1623112, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1623112, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1623112, 12);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1623112, 12);
    
## student id = 1696326
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1696326, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1696326, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1696326, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1696326, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1696326, 1);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1696326, 9);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1696326, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1696326, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1696326, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1696326, 26);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1696326, 12);
    
## student id = 1646434
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1646434, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1646434, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1646434, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1646434, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1646434, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1646434, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1646434, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1646434, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1646434, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1646434, 26);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1646434, 12);
    
## student id = 1614142
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1614142, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1614142, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1614142, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1614142, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1614142, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1614142, 10);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1614142, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1614142, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1614142, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1614142, 26);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1614142, 12);
    
## student id = 1654432
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1654432, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1654432, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1654432, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1654432, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1654432, 17);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1654432, 14);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1654432, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1654432, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1654432, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1654432, 26);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1614142, 25);
    
## student id = 1661638
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1661638, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1661638, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1661638, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1661638, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1661638, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1661638, 15);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1661638, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1661638, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1661638, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1661638, 13);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1661638, 20);
    
## student id = 1686272
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1686272, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1686272, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1686272, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1686272, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1686272, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1686272, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1686272, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1686272, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1686272, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1686272, 26);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1686272, 12);
    
## student id = 1778274
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1778274, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1778274, 7);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1778274, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1778274, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1778274, 4);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1778274, 4);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1778274, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1778274, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1778274, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1778274, 22);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1778274, 27);
    
## student id = 1795656
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1795656, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1795656, 3);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1795656, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1795656, 19);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1795656, 4);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1795656, 5);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1795656, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1795656, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1795656, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1795656, 19);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1795656, 25);
    
## student id = 1747457
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1747457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1747457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1747457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1747457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1747457, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1747457, 1);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1747457, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1747457, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1747457, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1747457, 19);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1747457, 27);
    
## student id = 1798883
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1798883, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1798883, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1798883, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1798883, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1798883, 3);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1798883, 10);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1798883, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1798883, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1798883, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1798883, 19);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1798883, 20);

## student id = 1766156
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1766156, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1766156, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1766156, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1766156, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1766156, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1766156, 0);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1766156, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1766156, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1766156, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1766156, 6);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1766156, 0);
    
## student id = 1715578
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1715578, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1715578, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1715578, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1715578, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1715578, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1715578, 5);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1715578, 19);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1715578, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1715578, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1715578, 26);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1715578, 26);

## student id = 1745484
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1745484, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1745484, 7);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1745484, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1745484, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1745484, 3);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1745484, 9);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1745484, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1745484, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1745484, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1745484, 0);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1745484, 0);
    
## student id = 1788337
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1788337, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1788337, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1788337, 24);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1788337, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1788337, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1788337, 17);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1788337, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1788337, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1788337, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1788337, 20);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1788337, 23);
    
## student id = 1728439
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1728439, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1728439, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1728439, 24);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1728439, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1728439, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1728439, 14);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1728439, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1728439, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1728439, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1728439, 20);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1728439, 22);
    
## student id = 1711619
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1711619, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1711619, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1711619, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1711619, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1711619, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1711619, 18);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1711619, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1711619, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1711619, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1711619, 11);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1711619, 27);
    
## student id = 1711729
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1711729, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1711729, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1711729, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1711729, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1711729, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1711729, 6);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1711729, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1711729, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1711729, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1711729, 34);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1711729, 0);
    
## student id = 1892367
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1892367, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1892367, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1892367, 24);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1892367, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1892367, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1892367, 7);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1892367, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1892367, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1892367, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1892367, 6);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1892367, 29);
    
## student id = 1872128
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1872128, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1872128, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1872128, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1872128, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1872128, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1872128, 6);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1872128, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1872128, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1872128, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1872128, 24);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1872128, 27);
    
## student id = 1868128
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1868128, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1868128, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1868128, 24);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1868128, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1868128, 4);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1868128, 15);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1868128, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1868128, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1868128, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1868128, 27);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1868128, 27);
    
## student id = 1845457
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 1, 1845457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 2, 1845457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 3, 1845457, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 4, 1845457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 5, 1845457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (1, 6, 1845457, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 1, 1845457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 2, 1845457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 3, 1845457, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (2, 4, 1845457, 0);
    
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (3, 4, 1845457, 0);
    
## student's data for marks obtained for each question of the midterm/final for section 2
## student id = 1633554
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1633554, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1633554, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1633554, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1633554, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1633554, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1633554, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1633554, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1633554, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1633554, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1633554, 0);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1633554, 0);
    
## student id = 1645333
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1645333, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1645333, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1645333, 23);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1645333, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1645333, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1645333, 13);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1645333, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1645333, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1645333, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1645333, 18);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1645333, 23);

## student id = 1691291
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1691291, 6);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1691291, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1691291, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1691291, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1691291, 2);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1691291, 11);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1691291, 17);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1691291, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1691291, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1691291, 17);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1691291, 30);
    
## student id = 1641252
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1641252, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1641252, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1641252, 24);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1641252, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1641252, 25);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1641252, 17);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1641252, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1641252, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1641252, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1641252, 22);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1641252, 34);

## student id = 1695837
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1695837, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1695837, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1695837, 24);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1695837, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1695837, 25);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1695837, 17);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1695837, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1695837, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1695837, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1695837, 25);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1695837, 24);
    
## student id = 1668314
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1668314, 19);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1668314, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1668314, 24);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1668314, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1668314, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1668314, 7);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1668314, 17);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1668314, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1668314, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1668314, 27);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1668314, 11);
    
## student id = 1665491
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1665491, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1665491, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1665491, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1665491, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1665491, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1665491, 5);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1665491, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1665491, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1665491, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1665491, 6);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1665491, 23);
    
## student id = 1763881
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1763881, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1763881, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1763881, 27);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1763881, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1763881, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1763881, 15);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1763881, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1763881, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1763881, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1763881, 6);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1763881, 0);

## student id = 1773277
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1773277, 17);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1773277, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1773277, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1773277, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1773277, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1773277, 0);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1773277, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1773277, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1773277, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1773277, 18);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1773277, 23);

## student id = 1759787
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1759787, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1759787, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1759787, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1759787, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1759787, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1759787, 10);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1759787, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1759787, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1759787, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1759787, 0);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1759787, 0);
    
## student id = 1743714
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1743714, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1743714, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1743714, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1743714, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1743714, 3);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1743714, 2);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1743714, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1743714, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1743714, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1743714, 12);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1743714, 11);
    
## student id = 1728125
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1728125, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1728125, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1728125, 24);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1728125, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1728125, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1728125, 18);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1728125, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1728125, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1728125, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1728125, 20);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1728125, 11);
    
## student id = 1783512
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1783512, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1783512, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1783512, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1783512, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1783512, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1783512, 13);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1783512, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1783512, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1783512, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1783512, 28);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1783512, 11);
    
## student id = 1768463
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1768463, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1768463, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1768463, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1768463, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1768463, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1768463, 11);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1768463, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1768463, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1768463, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1768463, 21);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1768463, 11);
    
## student id = 1797625
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1797625, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1797625, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1797625, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1797625, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1797625, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1797625, 14);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1797625, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1797625, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1797625, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1797625, 19);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1797625, 11);
    
## student id = 1754681
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1754681, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1754681, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1754681, 27);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1754681, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1754681, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1754681, 19);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1754681, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1754681, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1754681, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1754681, 29);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1754681, 23);
    
## student id = 1769463
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1769463, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1769463, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1769463, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1769463, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1769463, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1769463, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1769463, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1769463, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1769463, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1769463, 0);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1769463, 0);
    
## student id = 1731817
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1731817, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1731817, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1731817, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1731817, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1731817, 27);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1731817, 16);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1731817, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1731817, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1731817, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1731817, 8);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1731817, 34);
    
## student id = 1791753
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1791753, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1791753, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1791753, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1791753, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1791753, 17);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1791753, 15);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1791753, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1791753, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1791753, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1791753, 15);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1791753, 34);
    
## student id = 1712983
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1712983, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1712983, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1712983, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1712983, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1712983, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1712983, 13);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1712983, 17);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1712983, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1712983, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1712983, 30);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1712983, 23);
    
## student id = 1784847
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1784847, 23);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1784847, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1784847, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1784847, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1784847, 28);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1784847, 19);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1784847, 17);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1784847, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1784847, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1784847, 27);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1784847, 34);
    
## student id = 1789481
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1789481, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1789481, 19);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1789481, 24);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1789481, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1789481, 27);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1789481, 17);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1789481, 19);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1789481, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1789481, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1789481, 21);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1789481, 34);
    
## student id = 1773384
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1773384, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1773384, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1773384, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1773384, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1773384, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1773384, 9);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1773384, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1773384, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1773384, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1773384, 18);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1773384, 25);
    
## student id = 1762565
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1762565, 6);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1762565, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1762565, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1762565, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1762565, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1762565, 4);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1762565, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1762565, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1762565, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1762565, 17);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1762565, 31);
    
## student id = 1835874
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1835874, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1835874, 25);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1835874, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1835874, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1835874, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1835874, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1835874, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1835874, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1835874, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1835874, 19);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1835874, 31);
    
## student id = 1886577
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1886577, 17);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1886577, 7);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1886577, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1886577, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1886577, 7);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1886577, 18);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1886577, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1886577, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1886577, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1886577, 22);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1886577, 30);
    
## student id = 1834433
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1834433, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1834433, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1834433, 27);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1834433, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1834433, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1834433, 19);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1834433, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1834433, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1834433, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1834433, 25);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1834433, 31);
    
## student id = 1855787
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1855787, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1855787, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1855787, 26);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1855787, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1855787, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1855787, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1855787, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1855787, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1855787, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1855787, 15);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1855787, 23);
    
## student id = 1893863
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1893863, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1893863, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1893863, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1893863, 6);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1893863, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1893863, 0);

## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1893863, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1893863, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1893863, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1893863, 0);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1893863, 0);
    
## student id = 1842333
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 1, 1842333, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 2, 1842333, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 3, 1842333, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 4, 1842333, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 5, 1842333, 6);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (9, 6, 1842333, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 1, 1842333, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 2, 1842333, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 3, 1842333, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (10, 4, 1842333, 15);
    
## project
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (11, 4, 1842333, 25);
    
## student's data for marks obtained for each question of the midterm/final for section 3

## student id = 1528882
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1528882, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1528882, 7);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1528882, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1528882, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1528882, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1528882, 4);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1528882, 2);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1528882, 7);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1528882, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1528882, 13);
    
## student id = 1653725
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1653725, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1653725, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1653725, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1653725, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1653725, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1653725, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1653725, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1653725, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1653725, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1653725, 0);

## student id = 1669953
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1669953, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1669953, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1669953, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1669953, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1669953, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1669953, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1669953, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1669953, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1669953, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1669953, 0);
    
## student id = 1616161
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1616161, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1616161, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1616161, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1616161, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1616161, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1616161, 20);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1616161, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1616161, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1616161, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1616161, 15);
    
## student id = 1662147
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1662147, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1662147, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1662147, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1662147, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1662147, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1662147, 5);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1662147, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1662147, 2);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1662147, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1662147, 4);
    
## student id = 1691483
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1691483, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1691483, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1691483, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1691483, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1691483, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1691483, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1691483, 2);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1691483, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1691483, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1691483, 4);
    
## student id = 1674181
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1674181, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1674181, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1674181, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1674181, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1674181, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1674181, 8);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1674181, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1674181, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1674181, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1674181, 6);

## student id = 1612985
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1612985, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1612985, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1612985, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1612985, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1612985, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1612985, 42);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1612985, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1612985, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1612985, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1612985, 21);
    
## student id = 1622731
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1622731, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1622731, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1622731, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1622731, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1622731, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1622731, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1622731, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1622731, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1622731, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1622731, 0);
    
## student id = 1678812
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1678812, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1678812, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1678812, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1678812, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1678812, 1);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1678812, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1678812, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1678812, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1678812, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1678812, 19);

## student id = 1614733
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1614733, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1614733, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1614733, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1614733, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1614733, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1614733, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1614733, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1614733, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1614733, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1614733, 9);

## student id = 1634352
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1634352, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1634352, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1634352, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1634352, 6);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1634352, 6);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1634352, 13);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1634352, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1634352, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1634352, 7);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1634352, 13);
    
## student id = 1729416
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1729416, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1729416, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1729416, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1729416, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1729416, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1729416, 13);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1729416, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1729416, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1729416, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1729416, 5);

## student id = 1781682
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1781682, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1781682, 7);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1781682, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1781682, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1781682, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1781682, 7);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1781682, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1781682, 7);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1781682, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1781682, 18);
    
## student id = 1772947
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1772947, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1772947, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1772947, 27);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1772947, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1772947, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1772947, 19);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1772947, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1772947, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1772947, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1772947, 15);
    
## student id = 1752538
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1752538, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1752538, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1752538, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1752538, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1752538, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1752538, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1752538, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1752538, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1752538, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1752538, 18);

## student id = 1731852
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1731852, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1731852, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1731852, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1731852, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1731852, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1731852, 17);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1731852, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1731852, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1731852, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1731852, 22);
    
## student id = 1766176
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1766176, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1766176, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1766176, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1766176, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1766176, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1766176, 8);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1766176, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1766176, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1766176, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1766176, 18);
    
## student id = 1742892
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1742892, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1742892, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1742892, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1742892, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1742892, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1742892, 0);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1742892, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1742892, 2);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1742892, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1742892, 2);
    
## student id = 1736425
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1736425, 17);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1736425, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1736425, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1736425, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1736425, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1736425, 19);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1736425, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1736425, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1736425, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1736425, 27);
    
## student id = 1718437
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1718437, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1718437, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1718437, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1718437, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1718437, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1718437, 20);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1718437, 19);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1718437, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1718437, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1718437, 21);
    
## student id = 1737824
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1737824, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1737824, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1737824, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1737824, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1737824, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1737824, 10);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1737824, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1737824, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1737824, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1737824, 6);
    
## student id = 1797789
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1797789, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1797789, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1797789, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1797789, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1797789, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1797789, 8);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1797789, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1797789, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1797789, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1797789, 12);
    
## student id = 1728139
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1728139, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1728139, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1728139, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1728139, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1728139, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1728139, 15);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1728139, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1728139, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1728139, 7);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1728139, 14);
    
## student id = 1797789
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1797789, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1797789, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1797789, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1797789, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1797789, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1797789, 8);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1797789, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1797789, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1797789, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1797789, 12);
    
## student id = 1898334
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1898334, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1898334, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1898334, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1898334, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1898334, 1);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1898334, 6);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1898334, 9);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1898334, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1898334, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1898334, 26);
    
## student id = 1863951
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1863951, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1863951, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1863951, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1863951, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1863951, 17);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1863951, 16);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1863951, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1863951, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1863951, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1863951, 9);
    
## student id = 1835298
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1835298, 4);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1835298, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1835298, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1835298, 20);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1835298, 16);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1835298, 17);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1835298, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1835298, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1835298, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1835298, 5);
    
## student id = 1849651
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1849651, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1849651, 12);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1849651, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1849651, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1849651, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1849651, 8);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1849651, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1849651, 8);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1849651, 11);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1849651, 9);
    
## student id = 1887973
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1887973, 19);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1887973, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1887973, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1887973, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1887973, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1887973, 18);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1887973, 14);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1887973, 5);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1887973, 10);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1887973, 15);
    
## student id = 1877262
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1877262, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1877262, 2);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1877262, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1877262, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1877262, 28);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1877262, 18);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1877262, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1877262, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1877262, 15);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1877262, 9);
    
## student id = 1873255
## midterm
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 1, 1873255, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 2, 1873255, 0);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 3, 1873255, 22);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 4, 1873255, 19);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 5, 1873255, 28);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (17, 6, 1873255, 19);
    
## final
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 1, 1873255, 18);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 2, 1873255, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 3, 1873255, 13);
INSERT INTO STUDENT_QUESTION (courseAssessmentID, questionNumber, sAccountID, marksObtained) 
	VALUES (18, 4, 1873255, 7);



CREATE TABLE STUDENT_ACHIEVED_CO_PLO (
	enrolledCourseID VARCHAR(6) NOT NULL,
    sAccountID INT UNSIGNED NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    COAchieved CHAR(255), # change COAchieved to Boolean
    totalMarksReceivedForCO DOUBLE,
    sectionNumber TINYINT UNSIGNED,
    PLOAchieved CHAR(255), ## change PLOachieved to Boolean
    
    CONSTRAINT PRIMARY KEY (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber),
    
    CONSTRAINT STUDENT_ACHIEVED_CO_PLO_FK1 FOREIGN KEY (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber) 
		REFERENCES STUDENT_ENROLLMENT (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT STUDENT_ACHIEVED_CO_PLO_FK2 FOREIGN KEY (COAchieved) 
		REFERENCES COURSE_OUTCOME (COID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT STUDENT_ACHIEVED_CO_PLO_FK3 FOREIGN KEY (PLOAchieved) 
		REFERENCES PROGRAM_LEARNING_OUTCOME (PLOID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

## tables probably of no use
CREATE TABLE ASSIGNED_COURSE_ASSESSMENT_CO (
	courseAssessmentID INT UNSIGNED NOT NULL,
    COID CHAR(255) NOT NULL,
    
    CONSTRAINT PRIMARY KEY (courseAssessmentID, COID),
    
    CONSTRAINT ASSIGNED_COURSE_ASSESSMENT_CO_FK1 FOREIGN KEY (courseAssessmentID) 
		REFERENCES COURSE_ASSESSMENT (courseAssessmentID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
	
    CONSTRAINT ASSIGNED_COURSE_ASSESSMENT_CO_FK2 FOREIGN KEY (COID) 
		REFERENCES COURSE_OUTCOME (COID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE MAPPING_TAXONOMY (
	taxonomyID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    sectionNumber TINYINT UNSIGNED NOT NULL,
    offeredCourseID VARCHAR(6) NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
	studentsAttempted INT UNSIGNED,
    studentsPassed INT UNSIGNED,
    
    CONSTRAINT PRIMARY KEY (taxonomyID),
    
    CONSTRAINT MAPPING_TAXONOMY_FK1 FOREIGN KEY (offeredCourseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT MAPPING_TAXONOMY_FK2 FOREIGN KEY (semesterSeason, semesterYear) 
		REFERENCES SEMESTER (season, year)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
	CONSTRAINT MAPPING_TAXONOMY_FK3 FOREIGN KEY (sectionNumber) 
		REFERENCES SECTION (sectionNumber)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE TAXONOMY_ACHIEVED_CO_PLO (
	taxonomyID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    COID CHAR(255) NOT NULL,
    PLOID CHAR(255) NOT NULL,
    
    CONSTRAINT PRIMARY KEY (taxonomyID, COID, PLOID),
    
    CONSTRAINT TAXONOMY_ACHIEVED_CO_PLO_FK1 FOREIGN KEY (taxonomyID) 
		REFERENCES MAPPING_TAXONOMY (taxonomyID),
        
    CONSTRAINT TAXONOMY_ACHIEVED_CO_PLO_FK2 FOREIGN KEY (COID) 
		REFERENCES COURSE_OUTCOME (COID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
    CONSTRAINT TAXONOMY_ACHIEVED_CO_PLO_FK3 FOREIGN KEY (PLOID) 
		REFERENCES PROGRAM_LEARNING_OUTCOME (PLOID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
USE spmsdatabaseupdated;

## find number of courses that uses OBE model
SELECT COUNT(DISTINCT C.courseID) AS obeCourses
FROM COURSE AS C, PROGRAM_LEARNING_OUTCOME AS PLO, CO_PLO_MAPPING AS CO_PLO_MAP 
WHERE C.courseID = CO_PLO_MAP.courseID AND PLO.PLOID = CO_PLO_MAP.PLOID;
