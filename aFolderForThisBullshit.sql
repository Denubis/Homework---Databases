drop view if exists personName;

drop table if exists employee;
drop table if exists person;

--remember, idiot, you're using a persistent DB, not like sqlite.
--you forgot, didn't you?

create table person (
	personID	INTEGER	PRIMARY KEY,
	FirstName	VARCHAR(50),
	LastName	VARCHAR(100)

	);

create table employee (
	employeeID		INTEGER PRIMARY KEY,
	supervisorID	INTEGER,
	CONSTRAINT employeeIDPKFK FOREIGN KEY (employeeID) REFERENCES person (personID),
	CONSTRAINT employeeSupervisorFK	FOREIGN KEY (supervisorID) REFERENCES employee (employeeID)
);

INSERT INTO person VALUES(1, 'Brian', 'Ballsun-Stanton');
INSERT INTO person VALUES(2, 'Georgia', 'Burnett');
INSERT INTO person VALUES(3, 'Shawn', 'Ross');

INSERT INTO employee VALUES(2);
INSERT INTO employee VALUES(1, 2);


select * from person;

select * from person join employee on (personid = employeeID);


create view personName as 
select personid, firstname || ' ' || lastname as name from person;


select * from personName;

select employee.name as Employee, supervisor.name as Supervisor
  from (select name, employeeID, supervisorID
          from personName JOIN employee ON (personid = employeeid)) as employee
  LEFT OUTER JOIN (select name, employeeID
                     from personName join employee on (personID = employeeID)
                   ) as supervisor ON (employee.supervisorID = supervisor.employeeID);
