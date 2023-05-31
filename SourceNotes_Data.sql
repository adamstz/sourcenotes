USE SourceNotes
GO
/*
DELETE Stats
DELETE Reports
DELETE ProjectstoUsers
DELETE PeotoAnn
DELETE People
DELETE Comments
DELETE Keywords
DELETE KeytoAnn
DELETE Annotations
DELETE Items
DELETE LabBook
DELETE Projects
DELETE Users
*/

DELETE Comment
DELETE Note
DELETE LB_Entry
DELETE Users
DELETE Sources
DELETE People
DELETE Keyword
DELETE LabBook
DELETE Project
GO

DBCC CHECKIDENT ('Project', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('Sources', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('Note', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('LabBook', RESEED, 0) WITH NO_INFOMSGS;
GO
/*
DBCC CHECKIDENT ('Stats', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('Reports', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('ProjectstoUsers', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('PeotoAnn', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('People', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('Comments', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('Keywords', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('KeytoAnn', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('Annotations', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('Items', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('LabBook', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('Projects', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('Users', RESEED, 0) WITH NO_INFOMSGS;
GO
DBCC CHECKIDENT ('Users', RESEED, 0) WITH NO_INFOMSGS;
*/
GO

/*===================================================================== Data Input */
BULK INSERT People			-------------------------------------------------- Users
FROM 'C:\Temp\DataTextFiles\People.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
);
GO
BULK INSERT Keyword			-------------------------------------------------- Users
FROM 'C:\Temp\DataTextFiles\Keyword.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
	
);
GO
BULK INSERT	Project		-------------------------------------------------- Projects
FROM 'c:\temp\DataTextFiles\Projects.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
	
);
GO
/*
BULK INSERT Users		-------------------------------------------------- Users

FROM 'c:\temp\DataTextFiles\Users.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
);
GO
*/


INSERT INTO Users(User_Email, User_Username, User_Password, User_Bio, User_Admin, User_Project_ID)
VALUES ('ringe2@mysql.com','dcops2',	'Spton82MO'	,'Biostatistician II',	'1'	,2);
INSERT INTO Users(User_Email, User_Username, User_Password, User_Bio, User_Admin, User_Project_ID)
VALUES ('udeane3@tuttocitta.it'	,'omcelroy3'	,'a9RThe9ghtet',	'Tax Accountant',	'0',	3);

BULK INSERT Sources		-------------------------------------------------- Sources
FROM 'c:\temp\DataTextFiles\Sources.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY
);
GO
BULK INSERT Note		-------------------------------------------------- Note
FROM 'c:\temp\DataTextFiles\Notes.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY
);
GO

/*
BULK INSERT LabBook		-------------------------------------------------- LabBook
FROM 'c:\temp\DataTextFiles\LabBook.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY
);
GO
*/

INSERT INTO LabBook(LabBook_Date_Time, LabBook_Project_ID)
VALUES ('10-15-2022' ,  1);
INSERT INTO LabBook(LabBook_Date_Time, LabBook_Project_ID)
VALUES ('10-15-2022',   3);
INSERT INTO LabBook(LabBook_Date_Time, LabBook_Project_ID)
VALUES ('7-27-2022',    5);


BULK INSERT LB_Entry	-------------------------------------------------- LabBook
FROM 'c:\temp\DataTextFiles\LabBookEntries.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
);
GO

BULK INSERT Comment	-------------------------------------------------- LabBook
FROM 'c:\temp\DataTextFiles\comments.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
);
GO
/*
BULK INSERT Methodology	-------------------------------------------------- LabBook
FROM 'c:\temp\DataTextFiles\Methodology.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
);
GO
*/
INSERT INTO Methodology(Methodology_Text , Methodology_Update, Methodology_Project_ID)
VALUES ('Quisque id justo sit amet sapien dignissim vestibulum' , '10-15-2022', 1);
INSERT INTO Methodology(Methodology_Text , Methodology_Update, Methodology_Project_ID)
VALUES ('Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' , '10-15-2022', 2);
INSERT INTO Methodology(Methodology_Text , Methodology_Update, Methodology_Project_ID)
VALUES ('Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' , '10-15-2022', 3);
---------------------------------------OLD INSERT COMMENTS-------------------------------------------
/*
BULK INSERT	Projects		-------------------------------------------------- Projects
FROM 'c:\temp\DataTextFiles\Projects.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY,
	KEEPNULLS
)
GO

BULK INSERT	LabBook			-------------------------------------------------- LabBook
FROM 'c:\temp\DataTextFiles\LabBook.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY,
	KEEPNULLS
)
GO


BULK INSERT	Items			-------------------------------------------------- Items
FROM 'c:\temp\DataTextFiles\Items.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY,
	KEEPNULLS
)
GO

BULK INSERT	Annotations		-------------------------------------------------- Annotations
FROM 'c:\temp\DataTextFiles\Annotations.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY,
	KEEPNULLS
)
GO

BULK INSERT	KeytoAnn		-------------------------------------------------- KeytoAnn
FROM 'c:\temp\DataTextFiles\KeytoAnn.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY,
	KEEPNULLS
)
GO

BULK INSERT	Keywords		-------------------------------------------------- Keywords
FROM 'c:\temp\DataTextFiles\Keywords.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY
)
GO

BULK INSERT	Comments		-------------------------------------------------- Comments
FROM 'c:\temp\DataTextFiles\Comments.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY
)
GO

BULK INSERT	People			-------------------------------------------------- People
FROM 'c:\temp\DataTextFiles\People.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY
)
GO

BULK INSERT	PeotoAnn		-------------------------------------------------- PeotoAnn
FROM 'c:\temp\DataTextFiles\PeotoAnn.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY,
	KEEPNULLS
)
GO

BULK INSERT	ProjectstoUsers	-------------------------------------------------- ProjectstoUsers
FROM 'c:\temp\DataTextFiles\ProjectstoUsers.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY,
	KEEPNULLS
)
GO

BULK INSERT	Reports			-------------------------------------------------- Reports
FROM 'c:\temp\DataTextFiles\Reports.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY
)
GO

BULK INSERT Stats			-------------------------------------------------- Stats
FROM 'c:\temp\DataTextFiles\Stats.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY
)
GO
*/