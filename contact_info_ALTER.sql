DROP DATABASE IF EXISTS contactinfo;
CREATE DATABASE contactinfo;
\c contactinfo

CREATE TABLE contact_info (
	firstname VARCHAR(20),
	middleinital CHAR(3),
	lastname VARCHAR(20),
	suffix_description VARCHAR(5),
	title_description VARCHAR(5),
	jobtitle VARCHAR(40),
	department VARCHAR(30),
	email VARCHAR(35),
	url VARCHAR(50),
	IMaddress VARCHAR(20),
	phone_number VARCHAR(20),
	phonetype_description VARCHAR(10),
	birthday DATE,
	notes VARCHAR(255),
	companyname VARCHAR(30),
	street1 VARCHAR(40),
	street2 VARCHAR(40),
	city VARCHAR(20),
	state_province VARCHAR(15),
	zip_postcode VARCHAR(10),
	country_region VARCHAR(15),
	company_url VARCHAR(40),
	company_phone VARCHAR(12)
);

INSERT INTO contact_info (firstname, middleinital, lastname, suffix_description, title_description, jobtitle, department, email, url, IMaddress, phone_number, phonetype_description, birthday, notes, companyname, street1, city, state_province, zip_postcode, country_region, company_url, company_phone) VALUES ('Jacob', 'P', 'Jacoby', 'Jr.', 'Mr.', 'Director', 'Finance', 'jjacoby@concor.com', 'www.concor.com/~jacoby', 'jpjacoby', '323-546-3322 ext. 29', 'work', '1969-07-15', 'All meetings must be sheduled through his assistant.', 'Concor International, Inc.', '143 North Main Street', 'Beverly Hills', 'CA', '90210-3712', 'USA', 'www.concor.com', '323-546-5000'); 

INSERT INTO contact_info (firstname, lastname, title_description, jobtitle, department, email, IMaddress, phone_number, phonetype_description, birthday, notes, companyname, street1, city, state_province, zip_postcode, country_region, company_url, company_phone) VALUES ('Charlene', 'Smith', 'Ms.', 'Assistant to Finance Director', 'Finance', 'csmith@concor.com', 'charsmith', '323-546-3322 ext. 30', 'work', '1972-06-15', 'Very helpful.', 'Concor International, Inc.', '143 Main Street', 'Beverly Hills', 'CA', '90210-3712', 'USA', 'www.concor.com', '323-546-5000');

INSERT INTO contact_info (firstname, middleinital, lastname, title_description, jobtitle, department, email, phone_number, phonetype_description, birthday, notes, companyname, company_url) VALUES ('Carson', 'B', 'Campbell', 'Dr.', 'Chief Resident', 'Geriatrics', 'cbc232@mvch.org', '585-544-2121', 'Home', '1955-01-05', 'Wife: Lisa, Kids: Lane, Lucy, Lucinda.', 'Mountain View Hospital', 'www.mvch.org');

INSERT INTO contact_info (firstname, middleinital, lastname, suffix_description, title_description, jobtitle, department, email, phone_number, phonetype_description, birthday, notes, companyname, street1, street2, city, state_province, zip_postcode, country_region, company_url) VALUES ('Les', 'M', 'Nessman', 'Ph.D.', 'Prof.', 'Professor', 'Communications', 'lmncom@rit.edu', '585-475-1111', 'work', '1964-03-23', 'Likes when work is handed in on time.', 'RIT', 'Bldg. 6', '106 Lomb Memorial Drive', 'Rochester', 'NY', '14623', 'USA', 'www.rit.edu');

INSERT INTO contact_info (firstname, lastname, title_description, email, IMaddress, phone_number, phonetype_description, birthday, notes) VALUES ('Rachel', 'Raye', 'Miss.', 'goof@go.com', 'goofy14', '585-532-4332', 'cell', '1985-05-06', 'Favourite colour is orange.');

INSERT INTO contact_info (firstname, middleinital, lastname, title_description, jobtitle, department, email, birthday, companyname, city, state_province, country_region) 
                  VALUES ('Georgia', 'G H', 	   'Burnett', 'Ms.', 			'Ph.D. Candidate', 'Ancient History', 'georgia@fedarch.org', '1991-10-03', 'Macquarie University', 'Sydney', 'NSW', 'Australia');

SELECT *
  FROM contact_info;

SELECT firstname, lastname
  FROM contact_info
 WHERE lastname = 'Smith';

SELECT firstname, lastname, jobtitle, department
  FROM contact_info
 WHERE companyname = 'Concor International, Inc.';

SELECT firstname, lastname
  FROM contact_info
 WHERE state_province = 'CA';

SELECT firstname, lastname, phone_number
  FROM contact_info
 WHERE phonetype_description = 'work' OR phonetype_description = 'cell';

ALTER TABLE contact_info 
  ADD contactID varchar(9),
  ADD suffixID varchar(10),
  ADD titleID varchar(11),
  ADD companyID varchar(12),
  ADD phonetypeID varchar(13);


update contact_info set contactid = '123456789' where firstname = 'Jacob';
 update contact_info set contactid = '987654321' where firstname =  'Charlene';
 update contact_info set contactid = '121212121' where firstname =  'Carson';
 update contact_info set contactid = '33333' where firstname =  'Les';
 update contact_info set contactid = '556' where firstname =  'Rachel';









DELETE FROM contact_info
 WHERE firstname = 'Georgia'
   AND lastname = 'Burnett';

ALTER TABLE contact_info 
	ADD CONSTRAINT contact_info_pk PRIMARY KEY (phone_number, contactID)