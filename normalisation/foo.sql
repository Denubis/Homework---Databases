/*
A university research group publishes an analysis of all journal papers relating to a particular area of chemistry, namely reaction kinetics. 

	Each paper may have one or more authors, 
	Paper may discuss one or more reactions, 
	Paper may appear in only one journal. 

	Journals are identified by title, volume, and issue number.
	Each issue contains many papers.
	Each paper contains a series of references to other papers. 

	Authors may contribute to a zero or more of papers appearing in a variety of journals.



1)~Which authors have written one or more papers which discuss a particular reaction? 
2)~Which papers either discuss a particular reaction, or have been referred to by a paper which discusses that reaction?

AUTHOR (_AuthorID_, FirstName, MiddleName, LastName)

JOURNAL (_JournalID_, JournalTitle)
ISSUE (_IssueID_, IssueNumber, /JournalID/, Volume)
	ISSUE (JournalID) MEI Journal (JournalID)

PAPER (_PaperID_, PaperTitle, /IssueID/)
	Paper (IssueID) MEI Issue (IssueID)

PAPER-AUTHOR (_/PaperID/_, _/AuthorID/_)
	PAPER-AUTHOR (PaperID) MEI PAPER (PaperID)
	PAPER-AUTHOR (AuthorID) MEI AUTHOR (AuthorID)

REACTION (_ReactionID_, ReactionDetails)

PAPER-REACTION (_/PaperID/_, _/ReactionID/_)
	PAPER-REACTION (PaperID) MEI Paper (PaperID)
	PAPER-REACTION (ReactionID) MEI Reaction (ReactionID)


REFERENCE (_/ReferringPaperID/_, _/ReferencedPaperID/_)
	REFERENCE (ReferringPaperID) MEI Paper (PaperID)
	REFERENCE (ReferencedPaperID) MEI Paper (PaperID)
*/

DROP DATABASE IF EXISTS journal;
CREATE DATABASE journal;
\c journal

CREATE TABLE Author (
  AuthorID 	INTEGER	PRIMARY KEY,
  FirstName	Varchar(50),
  MiddleName 	Varchar(50),
  LastName	Varchar(100)
);

CREATE TABLE Journal (
  JournalID INTEGER PRIMARY KEY,
  JournalTitle Varchar(100)  
);

CREATE TABLE Issue (
  IssueID 		INTEGER PRIMARY KEY,
  IssueNumber	Varchar(50),
  JournalID 	INTEGER REFERENCES Journal,
  volume 		Varchar(50)
);

CREATE TABLE Paper (
  PaperID 		INTEGER PRIMARY KEY,
  PaperTitle	Varchar(200),
  IssueID 		INTEGER REFERENCES Issue
);

CREATE TABLE PaperAuthor (
  PaperID 	INTEGER REFERENCES Paper,
  AuthorID 	INTEGER REFERENCES Author,
  PRIMARY KEY (PaperID, AuthorID)                          
);

CREATE TABLE Reaction (
  ReactionID INTEGER PRIMARY KEY,
  ReactionDetails Text
);

CREATE TABLE PaperReaction (
  PaperID 	INTEGER REFERENCES Paper,
  ReactionID 	INTEGER REFERENCES Reaction,
  PRIMARY KEY (PaperID, ReactionID)                           
);
--REFERENCE (_/ReferringPaperID/_, _/ReferencedPaperID/_)

CREATE TABLE Reference (
  ReferringPaperID INTEGER REFERENCES Paper (PaperID),
  ReferencedPaperID INTEGER REFERENCES Paper (PaperID),
  PRIMARY KEY (ReferringPaperID, ReferencedPaperID)
);

INSERT INTO Author (AuthorID, 	FirstName, 	MiddleName, 	LastName) 
           VALUES  (1, 		  	'Georgia', 	'I have two', 	'Burnett'),
                   (2, 		  	'Brian', 	'Paul', 	    'Ballsun-Stanton'),
                   (3, 		  	'Shawn',	'Adrian',		'Ross'),
                   (4,			'Bad', 		'Really', 		'Author');

INSERT INTO Journal (JournalID, JournalTitle)                  
			VALUES	(1, 'The Bullshit journal of bullshit'),
					(2, 'The Highly ranked journal of awesome'),
					(3, 'The Medorcre Journal of student pubs');

INSERT INTO Issue 	(IssueID, 	JournalID, 	IssueNumber, 	Volume)					
			VALUES 	(1, 		1, 			'1', 			'1'),
					(2, 		1, 			'haha', 		'1'),
					(3, 		1, 			'hoho', 		'1'),
					(4, 		2, 			'1',	 		'1'),					
					(5, 		2, 			'2',	 		'2'),										
					(6, 		2, 			'3',	 		'3'),										
					(7, 		3, 			'1a',	 		'1');

INSERT INTO Paper 	(PaperID, 	IssueID, 	PaperTitle)					
		VALUES		(1,			4,			'This is a good paper'),
					(2,			4,			'This is a best paper'),		
					(3,			3,			'This is a plagarised paper'),					
					(4,			3,			'This is a badly plagarised paper'),
					(5,			7,			'This is a badly written paper');

INSERT INTO PaperAuthor (PaperID, 	AuthorID)
		VALUES			(1, 		2),
						(1,			1),
						(2,			3),
						(2,			1),
						(3,			4),
						(4,			4),
						(5,			1);


SELECT paperTitle, Firstname, lastname
  FROM Paper JOIN PaperAuthor USING (PaperID)
  JOIN Author USING (AuthorID);


select * from paperAuthor;

INSERT INTO Reaction 	(ReactionID, ReactionDetails)
			VALUES 		(1, 		'This is when the foo bars.'),
						(2, 		'This is when the bar foos.'),
						(3, 		'Help, everything exploded.'),
						(4, 		'Help, nothing exploded.');

INSERT INTO PaperReaction 	(PaperId, ReactionID)						
		VALUES 				(1, 1),
							(1, 2),
							(1, 3),
							(1, 4),
							(2, 4),
							(3, 2),
							(3, 3),
							(4, 3),
							(5, 1);

INSERT INTO Reference 	(ReferringPaperID, ReferencedPaperID)
			VALUES		(2, 1),
						(4, 3),
						(5, 1),
						(5, 2);

SELECT Referencing.PaperTitle as "The Paper", Referenced.PaperTitle as "Referenced Paper"
  FROM Paper as Referencing JOIN Reference ON (Referencing.PaperID = Reference.ReferringPaperID)
  JOIN Paper as Referenced ON (Referenced.PaperID = Reference.ReferencedPaperID);


/*
1)~Which authors have written one or more papers which discuss a particular reaction? 
*/

SELECT DISTINCT Firstname, lastname
  FROM Author 
  JOIN PaperAuthor USING (AuthorID)
  JOIN Paper USING (PaperID)
  JOIN PaperReaction USING (PaperID)
  JOIN Reaction USING (ReactionID)
 WHERE ReactionDetails = 'This is when the foo bars.';

 SELECT FirstName, LastName
   FROM AUTHOR
  WHERE AuthorID IN (SELECT AuthorID
                       FROM PaperAuthor
                       JOIN PaperReaction USING (PaperID)
                       JOIN Reaction USING (ReactionID)                     
                      WHERE ReactionDetails = 'This is when the foo bars.')
;

SELECT AuthorID
                       FROM PaperAuthor
                       JOIN PaperReaction USING (PaperID)
                       JOIN Reaction USING (ReactionID)                     
                      WHERE ReactionDetails = 'This is when the foo bars.';

--2)~Which papers either discuss a particular reaction,
-- or have been referred to by a paper which discusses that reaction?

SELECT PaperTitle
  FROM Paper 
 WHERE PaperID in (SELECT PaperID
					 FROM PaperReaction 
					 JOIN Reaction USING (ReactionID)                     
					WHERE ReactionDetails = 'This is when the foo bars.')
   OR PaperID IN (SELECT Reference.ReferencedPaperID 
                    FROM Reference 
                    WHERE ReferringPaperID IN  (SELECT PaperID
												 FROM PaperReaction 
												 JOIN Reaction USING (ReactionID)                     
												WHERE ReactionDetails = 'This is when the foo bars.'));