select * from degree_program;

INSERT INTO SCHOOL (schoolName, location, deanInCharge)
	VALUES 			('School of Computer Science and Engineering', '','' );

INSERT INTO Account (accountID, firstName, email, accountType)
	VALUES 			('1821709', 'Shohan1', 'shohan1@school.com', 'Faculty');

ALTER TABLE faculty
	MODIFY  deptID CHAR (255);

INSERT INTO Faculty (fAccountID)
	VALUES 			('1821709');
    
ALTER TABLE department
	MODIFY deptHeadID INT UNSIGNED;

INSERT INTO Department	(deptID, schoolName, deptName, location, deptHeadID)
	VALUES 				('CSE','School of Computer Science and Engineering','Computer Science and Engineering','asd','1821709');

ALTER TABLE PROGRAM_LEARNING_OUTCOME
	MODIFY  degreeID CHAR(255);
    
INSERT INTO degree_program (degreeID, degreeTitle, deptID)
	VALUES ('CSE', 'Computer Science and Engineering', 'CSE');
    
UPDATE degree_program
	SET degreeID = 'BSC_CSE', degreeTitle= 'BSC in Computer Science And Engineering'
    WHERE degreeID = 'CSE';
    
