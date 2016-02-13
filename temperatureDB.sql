\c temperatureLog temperatureLog temp-level8.fedarch.org 5432

DROP DATABASE IF EXISTS temperature;
CREATE DATABASE temperature;
\c temperature

CREATE TABLE location(
	building	varchar(50),
	room    	varchar(50),
	PRIMARY KEY (building, room)
                      );
CREATE TABLE sensorLog(
	logID           	serial PRIMARY KEY,
	building        	varchar(50),
	room            	varchar(50),
	ipAddress       	inet,
	tstamp          	timestamp default CURRENT_TIMESTAMP,
	temperature     	numeric,
	relativeHumidity	numeric,
	FOREIGN KEY (building, room) REFERENCES location (building, room)
);



                       