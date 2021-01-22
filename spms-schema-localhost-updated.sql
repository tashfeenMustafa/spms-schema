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

## insert offered course CSE303 section 1 related info
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
    
## insert offered course CSE303 section 2 related info
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
    
## insert offered course CSE303 section 3 related info
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

CREATE TABLE STUDENT_ACHIEVED_CO_PLO (
	enrolledCourseID VARCHAR(6) NOT NULL,
    sAccountID INT UNSIGNED NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    COAchieved CHAR(255),
    totalMarksReceivedForCO DOUBLE,
    sectionNumber TINYINT UNSIGNED,
    PLOAchieved CHAR(255),
    
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
