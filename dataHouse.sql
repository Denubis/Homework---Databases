DROP DATABASE IF EXISTS datahouse;
CREATE DATABASE datahouse;
\c datahouse

CREATE TABLE Owner (
	OwnerID INTEGER PRIMARY KEY,
	OwnerName VARCHAR(50)
);

CREATE TABLE SalesOffice (
	OfficeNumber INTEGER PRIMARY KEY,
	Location VARCHAR(50)
);

CREATE TABLE Employee(
	EmployeeID INTEGER PRIMARY KEY,
	EmployeeName VARCHAR(50),
	OfficeNumber INTEGER REFERENCES SalesOffice
);

ALTER TABLE SalesOffice ADD COLUMN 
	EmployeeID INTEGER REFERENCES Employee;

CREATE TABLE Property (
	PropertyID INTEGER PRIMARY KEY,
	Address VARCHAR(50),
	City VARCHAR(50),
	State VARCHAR(50),
	ZipCode NUMERIC(4),
	OfficeNumber INTEGER REFERENCES SalesOffice
);

CREATE TABLE PropertyOwner(
   OwnerID INTEGER REFERENCES Owner,
   PropertyID INTEGER REFERENCES Property,
   PercentOwned NUMERIC,
   CONSTRAINT PropertyOwnerPK PRIMARY KEY (ownerID, PropertyID)
);

INSERT INTO Owner VALUES(1, 'Brian Ballsun-Stanton'), (2, 'Georgia Burnett');
INSERT INTO property(propertyID, address) VALUES(1,'MQ'), (2,'Eastwood');

INSERT INTO PropertyOwner VALUES(1,1,50),(2,1,50), (2,2,100);


SELECT 'a'
UNION
SELECT '1'; 


SELECT 'a'
INTERSECT
SELECT 'b';

SELECT 'a'
INTERSECT
SELECT 'a';


select COLUMN
SELECT OwnerName, Address
  FROM Owner, PropertyOwner, Property;

SELECT OwnerName, Address, OwnerName || ' ' || Address as foo
  FROM Owner JOIN PropertyOwner USING (ownerID)
  JOIN Property USING (PropertyID)
  WHERE foo = 'Georgia Burnett Eastwood'
  ;



SELECT OwnerName, Address, foo
FROM (
	SELECT OwnerName, Address, OwnerName || ' ' || Address as foo
	  FROM Owner JOIN PropertyOwner USING (ownerID)
	  JOIN Property USING (PropertyID)
	  ) as a
where foo LIKE 'Georgia%';

SELECT OwnerName
FROM Owner
WHERE OwnerID IN (SELECT OwnerID 
                    from PropertyOwner 
                   where percentOwned < 100);

SELECT OwnerName
FROM Owner
WHERE OwnerID IN (1);                   



create table bullshit (
                       foo VARCHAR(50),
                       bar VARCHAR(50));

INSERT INTO bullshit VALUES ('a','');
INSERT INTO BULLSHIT VALUES ('b',null);

select * from bullshit;

select * from bullshit where bar is null;

SELECT TRUE;

SELECT 1+1;

SELECT TRUE AND TRUE;

/*

X Y |	AND	OR
1 1  	1  	1
1 ?  	?  	1
0 1  	0  	1
1 0  	0  	1
0 0  	0  	0
*/

SELECT (TRUE AND NULL);

SELECT TRUE AND FALSE;