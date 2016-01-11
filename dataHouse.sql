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