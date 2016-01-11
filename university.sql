DROP DATABASE IF EXISTS university;
CREATE DATABASE university;
\c university

CREATE TABLE department (
	name VARCHAR(20),
	telephone NUMERIC(10),
	departmentID VARCHAR(6),
	CONSTRAINT departmentPrimarykey PRIMARY KEY (departmentID)
);

CREATE TABLE postcode (
	postcodeID NUMERIC(4),
	suburb_name VARCHAR(20),
	city VARCHAR(20),
	state VARCHAR(20),
	PRIMARY KEY (postcodeID)
);

CREATE TABLE student (
	firstname VARCHAR(20),
	lastname VARCHAR(20),
	age NUMERIC(3),
	postcodeID NUMERIC(4) REFERENCES postcode,
	studentID NUMERIC(10),
	PRIMARY KEY (studentID)
);

CREATE TABLE professor (
	firstname VARCHAR(20),
	lastname VARCHAR(20),
	age NUMERIC(3),
	postcodeID NUMERIC(4) REFERENCES postcode,
	professorID NUMERIC(10),
	departmentID VARCHAR(6) REFERENCES department,
	PRIMARY KEY (professorID)
);

CREATE TABLE grad_students (
	studentID NUMERIC(10) REFERENCES student,
	professorID NUMERIC(10) REFERENCES professor,
	PRIMARY KEY (studentID, professorID)
);

CREATE TABLE course (
	courseID VARCHAR(6),
	title VARCHAR(20),
	professorID NUMERIC(10) REFERENCES professor,
	PRIMARY KEY (courseID)
);

CREATE TABLE enrolled (
	studentID NUMERIC(10) REFERENCES student,
	courseID VARCHAR(6) REFERENCES course,
	semester NUMERIC(1),
	grade NUMERIC(3),
	PRIMARY KEY (studentID, courseID)
);

CREATE TABLE planned (
	studentID NUMERIC(10) REFERENCES student,
	courseID VARCHAR(6) REFERENCES course,
	semester NUMERIC(1),
	year NUMERIC(4),
	PRIMARY KEY (studentID, courseID)
);

CREATE TABLE time (
	day VARCHAR(20),
	hour NUMERIC(4), --24H 
	PRIMARY KEY (day, hour)
);

CREATE TABLE place (
	room NUMERIC(2),
	building VARCHAR(20),
	PRIMARY KEY (room, building)
);

CREATE TABLE course_location (
	courseID VARCHAR(6) REFERENCES course,
	day VARCHAR(20), 
	hour NUMERIC(4),
	room NUMERIC(2),
	building VARCHAR(20),
	    FOREIGN KEY (day, hour) REFERENCES time(day,hour),
	    FOREIGN KEY (room, building) REFERENCES place(room,building)
);
