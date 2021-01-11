

select * from Program_learning_outcome;

SELECT * from account;
SELECT * from school;
SELECT * from faculty;
SELECT * from department;
Select * from degree_program;

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

select * from PROGRAM_LEARNING_OUTCOME;
delete from PROGRAM_LEARNING_OUTCOME where degreeID='BSC_CSE';

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO1', 'Knowledge','An ability to select and apply the knowledge, techniques, skills, and modern tools of the
computer science and engineering discipline','CSE');
UPDATE degree_program
	SET degreeID = 'BSC_CSE', degreeTitle= 'BSC in Computer Science And Engineering'
    WHERE degreeID = 'CSE';
    
INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO2', 'Requirement Analysis','An ability to identify, analyze, and solve a problem by defining the
computing requirements of the problem through effectively gathering of the actual requirements','BSC_CSE');
INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO3', 'Problem Analysis','An ability to select and apply the knowledge of mathematics, science,
engineering, and technology to computing problems that require the application of principles and applied procedures or methodologies','BSC_CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME (PLOID, PLOtitle, PLOdescription, degreeID) VALUES ('PLO4', 'Design','An ability to design computer based systems, components, or processes to meet the desire
requirement;','BSC_CSE');
Insert INTO PROGRAM_LEARNING_OUTCOME(PLOID,PLOtitle, PLOdescription, degreeID) VALUES ('PLO5', 'Problem Solving', 'An ability to apply mathematical foundations, simulation, algorithmic principles,
and computer science theory in the modeling and design of computer-based systems in a way that demonstrates comprehension of the tradeoffs involved in design choices', 'CSE');
INSERT INTO PROGRAM_LEARNING_OUTCOME(PLOID, PLOtitle, PLOdescription, degreeID) VAlUES ('PLO6', 'Implementation', 'An ability to apply design and development principles in the construction of
software systems of varying complexity' , 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME(PLOID, PLOtitle, PLOdescription, degreeID) VAlUES ('PLO7', 'Experiment and Analysis', 'An ability to conduct standard tests and measurements; to conduct,
analyze, and interpret experiments; and to apply experimental results to improve solutions (products or processes)' , 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME(PLOID, PLOtitle, PLOdescription, degreeID) VAlUES ('PLO8', 'Community Engagement and Engineering', 'An ability to appreciate human behavior, culture,
interaction and organization through studies in the humanities and social sciences. A knowledge of the impact of computing solutions in a local and global context' , 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME(PLOID, PLOtitle, PLOdescription, degreeID) VAlUES ('PLO9', 'Team Work', 'An ability to function effectively as a member or leader of a technical team to
accomplish common goals;' , 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME(PLOID, PLOtitle, PLOdescription, degreeID) VAlUES ('PLO10', 'Communication', 'An ability to apply written and oral communication in both technical and non-
technical environments; an ability to communicate with a range of audience; and an ability to identify and use appropriate available technical literature' , 'CSE');


INSERT INTO PROGRAM_LEARNING_OUTCOME(PLOID, PLOtitle, PLOdescription, degreeID) VAlUES ('PLO11', 'Self-Motivated', 'Recognition of the need for and an ability to engage in self-directed continuing
professional development; prepared to enter a top-ranked graduate program in Computer Science and Engineering' , 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME(PLOID, PLOtitle, PLOdescription, degreeID) VAlUES ('PLO12', 'Ethics', 'An understanding of and a commitment to address professional, ethical, legal, security, social
issues and responsibilities including a respect for diversity' , 'CSE');

INSERT INTO PROGRAM_LEARNING_OUTCOME(PLOID, PLOtitle, PLOdescription, degreeID) VAlUES ('PLO13', 'Process Management', 'A commitment to quality, timeliness, and continuous improvement', 'CSE');


select * from PROGRAM_LEARNING_OUTCOME;




