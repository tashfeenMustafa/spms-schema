CREATE database spmsdatabasenew;
SHOW databases;
USE spmsdatabasenew;

CREATE TABLE ACCOUNT_TYPES (
	accountTypeID INT UNSIGNED AUTO_INCREMENT NOT NULL,
    accountType VARCHAR(20) CHECK (accountType IN ('Faculty', 'Student', 'Admin', 'Accreditor', 'Management')),
    
    CONSTRAINT PRIMARY KEY (accountTypeID)
);

INSERT INTO ACCOUNT_TYPES (accountType) VALUES ('Faculty');
INSERT INTO ACCOUNT_TYPES (accountType) VALUES ('Student');
INSERT INTO ACCOUNT_TYPES (accountType) VALUES ('Admin');
INSERT INTO ACCOUNT_TYPES (accountType) VALUES ('Accreditor');

CREATE TABLE ACCOUNT (
	accountID INT UNSIGNED NOT NULL,
    firstName VARCHAR(30) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    address VARCHAR(100),
    phoneNumber VARCHAR(11) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(20),
    accountType VARCHAR(20) CHECK (accountType IN ('Faculty', 'Student', 'Admin', 'Accreditor', 'Management')),
    
    CONSTRAINT PRIMARY KEY (accountID)
);

select * from ACCOUNT;

SELECT * from SEMESTER;

INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (1, 'John', 'Doe', '01221122346', 'johndoe@uni.com', '1234',  'Admin');
INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (22, 'Jane', 'Doe', '01456445678', 'janedoe@uni.com', '1234',  'Accreditor');
INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (183454, 'Mary', 'Doe', '01457665679', 'marydoe@uni.com', '1234',  'Student');
INSERT INTO ACCOUNT (accountID, firstName, lastName, phoneNumber, email, password, accountType) VALUES (231092, 'Arthur', 'Doe', '01453689612', 'arthurdoe@uni.com', '1234',  'Faculty');
INSERT INTO FACULTY (fAccountID, deptID, dateHired, specialization) VALUES (231092, 'CSE', '2014-08-18', 'Databases');
update DEPARTMENT set deptHeadID=102809 where deptID='CSE';
SELECT * FROM ACCOUNT;
SELECT * FROM ADMIN;
SELECT * from STUDENT;
SELECT * from FACULTY;
select * from DEPARTMENT;
delete from account where accountID='110600';
SELECT * FROM ACCOUNT as a, FACULTY as f where accountType="Faculty" and a.accountID = f.fAccountID;

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
    task VARCHAR(200),
    
    CONSTRAINT PRIMARY KEY (adAccountID, task),
    
    CONSTRAINT ADMINTASK_FK FOREIGN KEY (adAccountID) 
		REFERENCES ADMIN (adAccountID)
);

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
    specialization VARCHAR(300),
    
    CONSTRAINT PRIMARY KEY (acAccountID, specialization),
    
    CONSTRAINT ACCREDITOR_SPECIALIZATION_FK FOREIGN KEY (acAccountID) 
		REFERENCES ACCREDITOR (acAccountID)
);

CREATE TABLE SCHOOL (
	schoolName VARCHAR(500) NOT NULL,
    location CHAR(255) NOT NULL,
    deanInCharge VARCHAR(200) NOT NULL,
    
    INDEX(schoolName, deanInCharge),
    
    CONSTRAINT PRIMARY KEY (schoolName)
);

SELECT * from DEGREE_PROGRAM;
DELETE FROM SCHOOL WHERE schoolName = '';

CREATE TABLE DEPARTMENT (
	deptID CHAR(255) DEFAULT 'x' NOT NULL,
    schoolName VARCHAR(500) NOT NULL,
    deptName VARCHAR(500) NOT NULL,
    location CHAR(255) NOT NULL,

	INDEX(deptName),
    
    CONSTRAINT PRIMARY KEY (deptID)
);

DELETE FROM DEPARTMENT where deptHeadID=0;

ALTER TABLE DEPARTMENT
	ADD deptHeadID INT UNSIGNED NOT NULL;

ALTER TABLE DEPARTMENT
	ADD CONSTRAINT DEPARTMENT_FK1 FOREIGN KEY
    (schoolName) REFERENCES SCHOOL (schoolName);

ALTER TABLE DEPARTMENT
	ADD CONSTRAINT DEPARTMENT_FK2 FOREIGN KEY
    (deptHeadID) REFERENCES FACULTY (fAccountID);
    
select * from department;
alter table DEPARTMENT DROP FOREIGN KEY DEPARTMENT_FK1;
alter table DEPARTMENT DROP FOREIGN KEY department_ibfk_1;
  
  SELECT 
  TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME, REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'spmsdatabasenew' AND
  REFERENCED_TABLE_NAME = 'DEPARTMENT';

CREATE TABLE FACULTY (
	fAccountID INT UNSIGNED NOT NULL,
    deptID CHAR(255) DEFAULT 'x' NOT NULL,
    dateHired DATE NOT NULL,
    specialization VARCHAR(500) NOT NULL,
	
    INDEX(deptID),
    
    CONSTRAINT PRIMARY KEY (fAccountID),
    
    CONSTRAINT FOREIGN KEY (fAccountID) 
		REFERENCES ACCOUNT (accountID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT FACULTY_FK1 FOREIGN KEY (deptID) 
		REFERENCES DEPARTMENT (deptID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER table STUDENT ADD constraint STUDENT_FK2 foreign key (major) REFERENCES DEGREE_PROGRAM(degreeTitle);
select * from student;
CREATE TABLE STUDENT (
	sAccountID INT UNSIGNED NOT NULL,
    deptID CHAR(255) NOT NULL,
    major VARCHAR(500) NOT NULL,
    dateOfAdmission DATE NOT NULL,
    studentType VARCHAR(200) NOT NULL,
    
    INDEX(deptID, major, studentType, dateOfAdmission),
    
    CONSTRAINT PRIMARY KEY (sAccountID),
    
    CONSTRAINT STUDENT_FK FOREIGN KEY (sAccountID) 
		REFERENCES ACCOUNT (accountID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT STUDENT_FK1 FOREIGN KEY (deptID) 
		REFERENCES DEPARTMENT (deptID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

SELECT * FROM ACCOUNT as a, STUDENT as s where accountType="Student" and a.accountID = s.sAccountID;

ALTER table DEGREE_PROGRAM ADD constraint unique (degreeTitle);

CREATE TABLE DEGREE_PROGRAM (
	degreeID CHAR(255) DEFAULT 'x' NOT NULL,
    degreeTitle VARCHAR(500) NOT NULL,
    deptID CHAR(255) DEFAULT 'x',
    
    INDEX(degreeTitle, deptID),
    
    CONSTRAINT PRIMARY KEY (degreeID),
    
    CONSTRAINT FOREIGN KEY (deptID) 
		REFERENCES DEPARTMENT (deptID) 
        ON UPDATE CASCADE ON DELETE RESTRICT
);

delete from DEGREE_PROGRAM where degreeID='bscCEN';

select * from COURSE;

CREATE TABLE PROGRAM_LEARNING_OUTCOME (
	PLOID CHAR(255) DEFAULT 'x' NOT NULL,
    PLOtitle VARCHAR(500) NOT NULL,
    PLOdescription VARCHAR(1000) NOT NULL,
    degreeID CHAR(255) DEFAULT 'x' NOT NULL,
    
    INDEX(degreeID),
    
    CONSTRAINT PRIMARY KEY (PLOID),
    
    CONSTRAINT PLO_FK1 FOREIGN KEY (degreeID) 
		REFERENCES DEGREE_PROGRAM (degreeID)
		ON UPDATE CASCADE ON DELETE RESTRICT
);


INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO1', 'Knowledge','An ability to select and apply the knowledge, techniques, skills, and modern tools of the
computer science and engineering discipline','CSE');
    
INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO2', 'Requirement Analysis','An ability to identify, analyze, and solve a problem by defining the
computing requirements of the problem through effectively gathering of the actual requirements','CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO3', 'Problem Analysis','An ability to select and apply the knowledge of mathematics, science,
engineering, and technology to computing problems that require the application of principles and applied procedures or methodologies','CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO4', 'Design','An ability to design computer based systems, components, or processes to meet the desire
requirement;','CSE');

select * from course;

CREATE TABLE COURSE (
	courseID VARCHAR(6) DEFAULT 'x' NOT NULL,
    courseTitle VARCHAR(500) NOT NULL,
    courseDescription VARCHAR(3000) NOT NULL,
    creditHour DECIMAL(1, 0) NOT NULL,
    deptID CHAR(255) NOT NULL,
    
    INDEX(courseTitle, deptID),
    
    CONSTRAINT PRIMARY KEY (courseID),
    
    CONSTRAINT COURSE_FK1 FOREIGN KEY (deptID) 
		REFERENCES DEPARTMENT (deptID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

select * from degree_program_course;

CREATE TABLE DEGREE_PROGRAM_COURSE (
	degreeID CHAR(255) DEFAULT 'x' NOT NULL,
    courseID VARCHAR(6) DEFAULT 'x' NOT NULL,
    
    CONSTRAINT PRIMARY KEY (degreeID, courseID),
    
    CONSTRAINT DEGREE_PROGRAM_COURSE_FK1 FOREIGN KEY (degreeID) 
		REFERENCES DEGREE_PROGRAM (degreeID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT DEGREE_PROGRAM_COURSE_FK2 FOREIGN KEY (courseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO DEGREE_PROGRAM_COURSE (degreeID, courseID) VALUES ('CSE', 'CSE303');
INSERT INTO DEGREE_PROGRAM_COURSE (degreeID, courseID) VALUES ('CSE', 'CSC101'); 

CREATE TABLE PREREQUISITE_COURSE (
	courseID VARCHAR(6) DEFAULT 'x' NOT NULL,
    prerequisiteCourseID VARCHAR(6) DEFAULT NULL,
    
    CONSTRAINT PRIMARY KEY (courseID, prerequisiteCourseID),
    
    CONSTRAINT PREREQUISITE_COURSE_FK1 FOREIGN KEY (courseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT PREREQUISITE_COURSE_FK2 FOREIGN KEY (prerequisiteCourseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE COURSE_OUTCOME (
	COID CHAR(255) NOT NULL,
    courseID VARCHAR(6) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    domain VARCHAR(20) NOT NULL,
    level VARCHAR(20) NOT NULL,
    keyword VARCHAR(20) NOT NULL,
    passingThreshold FLOAT NOT NULL,
    
    CONSTRAINT PRIMARY KEY (COID, courseID),
    
    CONSTRAINT COURSE_OUTCOME_FK1 FOREIGN KEY (courseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

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

SELECT * from SEMESTER;

CREATE TABLE SEMESTER (
	season VARCHAR(50) NOT NULL,
    year YEAR NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NUll,

    CONSTRAINT PRIMARY KEY (season, year)
);

alter table OFFERED_COURSES drop courseInstructorID;
alter table OFFERED_COURSES change courseInstructorID courseCoordinatorID INT UNSIGNED NOT NULL;
select * from OFFERED_COURSES;

CREATE TABLE OFFERED_COURSES (
	offeredCourseID VARCHAR(6) NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    courseCoordinatorID INT UNSIGNED NOT NULL,

    INDEX(courseCoordinatorID),
    
    CONSTRAINT PRIMARY KEY (offeredCourseID, semesterSeason, semesterYear),
    
    CONSTRAINT OFFERED_COURSES_FK1 FOREIGN KEY (offeredCourseID) 
		REFERENCES COURSE (courseID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT OFFERED_COURSES_FK2 FOREIGN KEY (semesterSeason, semesterYear) 
		REFERENCES SEMESTER (season, year)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT OFFERED_COURSES_FK4 FOREIGN KEY (courseCoordinatorID) 
		REFERENCES FACULTY (fAccountID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
	REFERENCED_TABLE_SCHEMA = 'spmsdatabasenew'
    AND REFERENCED_TABLE_NAME = 'section';

alter table OFFERED_COURSES DROP courseInstructorID;

CREATE TABLE SECTION (
	sectionNumber TINYINT UNSIGNED NOT NULL,
    offeredCourseID VARCHAR(6) DEFAULT 'x' NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    roomNumber VARCHAR(6),
    capacity INT UNSIGNED NOT NULL,
    courseInstructorID INT UNSIGNED NOT NULL,
    
    INDEX(courseInstructorID),
    
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

CREATE TABLE STUDENT_ENROLLMENT (
	enrolledCourseID VARCHAR(6) DEFAULT 'x' NOT NULL,
    sAccountID INT UNSIGNED NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    sectionNumber TINYINT UNSIGNED NOT NULL,
    gradeReceived CHAR(1),
    
    CONSTRAINT PRIMARY KEY (enrolledCourseID, sAccountID, semesterSeason, semesterYear, sectionNumber, gradeReceived),
    
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

CREATE TABLE COURSE_ASSESSMENT (
	courseAssessmentID INT UNSIGNED NOT NULL,
    sectionNumber TINYINT UNSIGNED NOT NULL,
    offeredCourseID VARCHAR(6) DEFAULT 'x' NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    totalMarksConvertedBy DOUBLE NOT NULL,
    assessmentType VARCHAR(300),
    totalMarks DOUBLE NOT NULL,
	
    INDEX(sectionNumber, offeredCourseID, semesterSeason, semesterYear, assessmentType),
    
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

CREATE TABLE QUESTION (
	courseAssessmentID INT UNSIGNED NOT NULL,
    questionNumber TINYINT UNSIGNED NOT NULL,
    fullMarks DOUBLE NOT NULL,
    description VARCHAR(3000) NOT NULL,
    assignedCourseOutcomeID CHAR(255) NOT NULL,
    
    INDEX(assignedCourseOutcomeID),
    
    CONSTRAINT PRIMARY KEY (courseAssessmentID, questionNumber),
    
    CONSTRAINT QUESTION_FK1 FOREIGN KEY (courseAssessmentID) 
		REFERENCES COURSE_ASSESSMENT (courseAssessmentID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT QUESTION_FK2 FOREIGN KEY (assignedCourseOutcomeID) 
		REFERENCES COURSE_OUTCOME (COID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE STUDENT_QUESTION (
	courseAssessmentID INT UNSIGNED NOT NULL,
    questionNumber TINYINT UNSIGNED NOT NULL,
    sAccountID INT UNSIGNED NOT NULL,
    marksObtained DOUBLE NOT NULL,
    
    INDEX(sAccountID, marksObtained),
    
    CONSTRAINT PRIMARY KEY (courseAssessmentID, questionNumber, sAccountID),
    
    CONSTRAINT STUDENT_QUESTION_FK1 FOREIGN KEY (courseAssessmentID, questionNumber) 
		REFERENCES QUESTION (courseAssessmentID, questionNumber)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT STUDENT_QUESTION_FK2 FOREIGN KEY (sAccountID) 
		REFERENCES STUDENT (sAccountID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE STUDENT_COURSE_ASSESSMENT (
	courseAssessmentID INT UNSIGNED NOT NULL,
    sAccountID INT UNSIGNED NOT NULL,
    totalMarksObtained DOUBLE NOT NULL,
    
    CONSTRAINT PRIMARY KEY (courseAssessmentID, sAccountID),
    
    CONSTRAINT STUDENT_COURSE_ASSESSMENT_FK1 FOREIGN KEY (courseAssessmentID) 
		REFERENCES COURSE_ASSESSMENT (courseAssessmentID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
        
    CONSTRAINT STUDENT_COURSE_ASSESSMENT_FK2 FOREIGN KEY (sAccountID) 
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
    offeredCourseID VARCHAR(6) DEFAULT 'x' NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
	studentsAttempted INT UNSIGNED NOT NULL,
    studentsPassed INT UNSIGNED NOT NULL,
    
    INDEX(sectionNumber, offeredCourseID, semesterSeason, semesterYear),
    
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
    PLOID CHAR(255) DEFAULT 'x' NOT NULL,
    
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
	enrolledCourseID VARCHAR(6) DEFAULT 'x' NOT NULL,
    sAccountID INT UNSIGNED NOT NULL,
    semesterSeason VARCHAR(50) NOT NULL,
    semesterYear YEAR NOT NULL,
    COAchieved CHAR(255) NOT NULL,
    totalMarksReceivedForCO DOUBLE NOT NULL,
    totalMarksForCOinPercentage DOUBLE NOT NULL,
    sectionNumber TINYINT UNSIGNED NOT NULL,
    PLOAchieved CHAR(255) DEFAULT 'x' NOT NULL,
    
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
SHOW TABLES;
select * from DEPARTMENT;

















