USE SourceNotes
GO

DELETE UsersToProjects
DELETE __EFMigrationsHistory
DELETE AspNetRoleClaims
DELETE AspNetRoles
DELETE AspNetUserClaims
DELETE AspNetUserLogins
DELETE AspNetUserRoles
DELETE AspNetUserTokens

DELETE Methodology
DELETE NotesToPerson
DELETE NotesToKeyword

DELETE Comment
DELETE LB_Entry
DELETE People

DELETE Keyword
DELETE Note
/*DELETE Users*/
DELETE Sources
/*DELETE LabBook*/
DELETE Project

DELETE AspNetUsers




GO


DBCC CHECKIDENT ('UsersToProjects', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('Project', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('Sources', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('Note', RESEED, 0) WITH NO_INFOMSGS;
/*DBCC CHECKIDENT ('LabBook', RESEED, 0) WITH NO_INFOMSGS;*/
DBCC CHECKIDENT ('Keyword', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('People', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('NotesToKeyword', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('NotesToPerson', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('Comment', RESEED, 0) WITH NO_INFOMSGS;
DBCC CHECKIDENT ('Methodology', RESEED, 0) WITH NO_INFOMSGS;
GO





/*===================================================================== Data Input */
/*
BULK INSERT	Project		-------------------------------------------------- Projects
FROM 'c:\Temp\DataTextFiles\projects.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
	
);
GO
*/


INSERT INTO Project(Project_Name, Project_Short_Name, Project_Description, Project_Date, Project_Public)
VALUES ('Project1', 'prjct1','The is a description of project', '20120618 10:34:09 AM', 1);
INSERT INTO Project(Project_Name, Project_Short_Name, Project_Description, Project_Date, Project_Public)
VALUES ('Project2', 'prjct2','The is a description of project', '20120618 10:34:09 AM', 0);
INSERT INTO Project(Project_Name, Project_Short_Name, Project_Description, Project_Date, Project_Public)
VALUES ('Project3', 'prjct3','The is a description of project', '20120618 10:34:09 AM', 1);
INSERT INTO Project(Project_Name, Project_Short_Name, Project_Description, Project_Date, Project_Public)
VALUES ('Project4', 'prjct4','The is a description of project', '20120618 10:34:09 AM', 0);
INSERT INTO Project(Project_Name, Project_Short_Name, Project_Description, Project_Date, Project_Public)
VALUES ('Project5', 'prjct5','The is a description of project', '20120618 10:34:09 AM', 0);
INSERT INTO Project(Project_Name, Project_Short_Name, Project_Description, Project_Date, Project_Public)
VALUES ('Project6', 'prjct6','The is a description of project', '20120618 10:34:09 AM', 1);
Go



BULK INSERT NotesToKeyword	--------------------------------------------------NotesToKeyword
FROM 'C:\Temp\DataTextFiles\NotesToKeyword.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
);
GO
BULK INSERT NotesToPerson	--------------------------------------------------NotesToKeyword
FROM 'C:\Temp\DataTextFiles\NotesToPerson.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
);
GO
BULK INSERT People			-------------------------------------------------- People
FROM 'C:\Temp\DataTextFiles\People.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
);
GO
BULK INSERT Keyword			-------------------------------------------------- Users
FROM 'C:\Temp\DataTextFiles\Keywords.txt'
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


/*INSERT INTO Users(User_Email, User_Username, User_Password, User_Bio, User_Admin, User_Project_ID)
VALUES ('ringe2@mysql.com','dcops2',	'Spton82MO'	,'Biostatistician II',	'1'	,2);
*/
/*
INSERT INTO Users(User_Email, User_Username, User_Password, User_Bio, User_Admin, User_Project_ID)
VALUES ('udeane3@tuttocitta.it'	,'omcelroy3'	,'a9RThe9ghtet',	'Tax Accountant',	'0',	3);
*/
INSERT INTO AspNetUsers(Id,UserName,NormalizedUserName, Email,NormalizedEmail,EmailConfirmed, PasswordHash,SecurityStamp,ConcurrencyStamp,PhoneNumber,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnd,LockoutEnabled,AccessFailedCount)
VALUES ('980-68b48260a6ea'	,'test@gmail.com'	,'TEST@GMAIL.COM','test@gmail.com'	,'TEST@GMAIL.COM',	'True',	'AQAAAAIAAYagAAAAEHyVOgE37Pfo/Ac0lMij6NG0pWFZ8OmVxYSkIO2GmKJkxBPiZrM08/SqhrfTOM4tJw==','DGU2O6TEFTBRCAMM4XYRQBPZCH6QCQDX','2bd773c8-8775-4417-b0a6-4c2fa033784f','NULL','False','False',NULL,'True','0');
INSERT INTO AspNetUsers(Id,UserName,NormalizedUserName, Email,NormalizedEmail,EmailConfirmed, PasswordHash,SecurityStamp,ConcurrencyStamp,PhoneNumber,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnd,LockoutEnabled,AccessFailedCount)
VALUES ('602a5839-003e-405e-8825-f520fa369513'	,'test1@gmail.com'	,'TEST1@GMAIL.COM','test1@gmail.com'	,'TEST1@GMAIL.COM',	'True',	'AQAAAAIAAYagAAAAEA51gZU3Re471u9IFV9RlbK5nEUlCB5O4JWHkHLp1CG7DnMFc6MVi9IZ/EeT9AryDA==','SEEA4P43VNWJA55EAX62FBI75RBS5UV2','711ec1fc-9956-4346-b0cf-4b3d0ea54a49','NULL','False','False',NULL,'True','0');
INSERT INTO AspNetUsers(Id,UserName,NormalizedUserName, Email,NormalizedEmail,EmailConfirmed, PasswordHash,SecurityStamp,ConcurrencyStamp,PhoneNumber,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnd,LockoutEnabled,AccessFailedCount)
VALUES ('09c1ee45-360b-40b9-b2a7-72a9388d083b'	,'test2@gmail.com'	,'TEST2@GMAIL.COM','test2@gmail.com'	,'TEST2@GMAIL.COM',	'True',	'AQAAAAIAAYagAAAAEBUv+4VtWvUls9aWAB9ScN2NefUbT01zerVJH5HOYXbqTuHFxb1mzNBrJZNVHzBtrg==','ZRYXPDZCPCFCPAL7UMFNRAR5QCWZTGGW','7b41ffb4-5fc2-468c-a72a-01eed982d034','NULL','False','False',NULL,'True','0');
INSERT INTO AspNetUsers(Id,UserName,NormalizedUserName, Email,NormalizedEmail,EmailConfirmed, PasswordHash,SecurityStamp,ConcurrencyStamp,PhoneNumber,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnd,LockoutEnabled,AccessFailedCount)
VALUES ('36c9985f-c112-45d3-9343-2eb45df3d8e4'	,'test3@gmail.com'	,'TEST3@GMAIL.COM','test3@gmail.com'	,'TEST3@GMAIL.COM',	'True',	'AQAAAAIAAYagAAAAEBdjo0p/PwP5xkV6OdNy3hzbSF64lRckz6/TVrv9hHMkdv4VUTayPTzby+T1rOr9Cg==','YYYQC2DUTS2QVNPZRSUPWNF3HPH7WGCT','822b7a40-b656-49e5-93ce-f22a333b23ff','NULL','False','False',NULL,'True','0');
INSERT INTO UsersToProjects(User_Email,Project_ID)
VALUES ('test@gmail.com'	,1);
INSERT INTO UsersToProjects(User_Email,Project_ID)
VALUES ('test2@gmail.com'	,1);
INSERT INTO UsersToProjects(User_Email,Project_ID)
VALUES ('test3@gmail.com'	,1);
INSERT INTO UsersToProjects(User_Email,Project_ID)
VALUES ('test@gmail.com'	,2);
INSERT INTO UsersToProjects(User_Email,Project_ID)
VALUES ('test2@gmail.com'	,2);
INSERT INTO UsersToProjects(User_Email,Project_ID)
VALUES ('test3@gmail.com'	,2);
INSERT INTO UsersToProjects(User_Email,Project_ID)
VALUES ('test@gmail.com'	,3);
INSERT INTO UsersToProjects(User_Email,Project_ID)
VALUES ('test2@gmail.com'	,3);
INSERT INTO UsersToProjects(User_Email,Project_ID)
VALUES ('test3@gmail.com'	,3);
INSERT INTO AspNetRoles(Id,Name,NormalizedName,ConcurrencyStamp)
VALUES('bfd36f94-5290-48d9-b903-0123eb1e785c','Admin','ADMIN',null)
INSERT INTO AspNetUserRoles(UserId,RoleId)
VALUES('980-68b48260a6ea','bfd36f94-5290-48d9-b903-0123eb1e785c')

BULK INSERT Sources		-------------------------------------------------- Sources
FROM 'c:\temp\DataTextFiles\Sources.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KEEPIDENTITY
);
GO
SET IDENTITY_INSERT Note ON
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (1,'The is a description of a note', '20120618 10:34:09 AM',1,1, 'test@gmail.com');
go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (2,'The is a description of a note', '20120618 10:34:09 AM',1,3, 'test@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (3,'The is a description of a note', '20120618 10:34:09 AM',3,5, 'test@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (4,'The is a description of a note', '20120618 10:34:09 AM',4,7, 'test@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (5,'The is a description of a note', '20120618 10:34:09 AM',5,9, 'test@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (6,'The is a description of a note', '20120618 10:34:09 AM',6,11, 'test@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (7,'The is a description of a note', '20120618 10:34:09 AM',1,1, 'test2@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (8,'The is a description of a note', '20120618 10:34:09 AM',2,3, 'test2@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (9,'The is a description of a note', '20120618 10:34:09 AM',3,5, 'test3@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (10,'The is a description of a note', '20120618 10:34:09 AM',4,7, 'test3@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (11,'The is a description of a note', '20120618 10:34:09 AM',5,9, 'test2@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (12,'The is a description of a note', '20120618 10:34:09 AM',2,11, 'test2@gmail.com');
Go
INSERT INTO Note(Note_ID, Note_Text, Note_Doc_Date,Note_Project_ID, Note_Source_ID, Note_User_Author)
VALUES (13,'The is a description of a note', '20120618 10:34:09 AM',3,11, 'test3@gmail.com');


Go
SET IDENTITY_INSERT Note OFF
/*
BULK INSERT Note		-------------------------------------------------- Note
FROM 'c:\temp\DataTextFiles\Notes.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n',
	KeepIdentity
	
);
GO
*/
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
/*
INSERT INTO LabBook(LabBook_Date_Time, LabBook_Project_ID)
VALUES ('10-15-2022' ,  1);
INSERT INTO LabBook(LabBook_Date_Time, LabBook_Project_ID)
VALUES ('10-15-2022',   3);
INSERT INTO LabBook(LabBook_Date_Time, LabBook_Project_ID)
VALUES ('7-27-2022',    5);
*/
SET IDENTITY_INSERT LB_ENTRY ON
INSERT INTO LB_Entry(LB_Entry_ID ,LB_Entry_User,LB_Entry_Date_Time, LB_Entry_Text, LabBook_Project_ID)
VALUES (1,'test@gmail.com','10-15-2022','Quisque id justo sit amet sapien dignissim vestibulum' , 1);
INSERT INTO LB_Entry(LB_Entry_ID ,LB_Entry_User,LB_Entry_Date_Time, LB_Entry_Text, LabBook_Project_ID)
VALUES (2,'test@gmail.com','10-15-2022','Quisque id justo sit amet sapien dignissim vestibulum' , 1);
INSERT INTO LB_Entry(LB_Entry_ID ,LB_Entry_User,LB_Entry_Date_Time, LB_Entry_Text, LabBook_Project_ID)
VALUES (3,'test1@gmail.com','10-15-2022','Quisque id justo sit amet sapien dignissim vestibulum' , 1);
INSERT INTO LB_Entry(LB_Entry_ID ,LB_Entry_User,LB_Entry_Date_Time, LB_Entry_Text, LabBook_Project_ID)
VALUES (4,'test2@gmail.com','10-15-2022','Quisque id justo sit amet sapien dignissim vestibulum' , 2);
INSERT INTO LB_Entry(LB_Entry_ID ,LB_Entry_User,LB_Entry_Date_Time, LB_Entry_Text, LabBook_Project_ID)
VALUES (5,'test1@gmail.com','10-15-2022','Quisque id justo sit amet sapien dignissim vestibulum' , 2);
INSERT INTO LB_Entry(LB_Entry_ID ,LB_Entry_User,LB_Entry_Date_Time, LB_Entry_Text, LabBook_Project_ID)
VALUES (6,'test2@gmail.com','10-15-2022','Quisque id justo sit amet sapien dignissim vestibulum' , 3);
INSERT INTO LB_Entry(LB_Entry_ID ,LB_Entry_User,LB_Entry_Date_Time, LB_Entry_Text, LabBook_Project_ID)
VALUES (7,'test1@gmail.com','10-15-2022','Quisque id justo sit amet sapien dignissim vestibulum' , 3);
INSERT INTO LB_Entry(LB_Entry_ID ,LB_Entry_User,LB_Entry_Date_Time, LB_Entry_Text, LabBook_Project_ID)
VALUES (8,'test@gmail.com','10-15-2022','Quisque id justo sit amet sapien dignissim vestibulum' , 1);
INSERT INTO LB_Entry(LB_Entry_ID ,LB_Entry_User,LB_Entry_Date_Time, LB_Entry_Text, LabBook_Project_ID)
VALUES (9,'test2@gmail.com','10-15-2022','Quisque id justo sit amet sapien dignissim vestibulum' , 2);

/*
  [LB_Entry_ID]                       int         PRIMARY KEY     IDENTITY(1,1)									NOT NULL,
    [LB_Entry_User]						[nvarchar](256)			FOREIGN KEY		REFERENCES AspNetUsers(Email)		    NOT NULL,
    [LB_Entry_Date_Time]				[datetime2](0)	DEFAULT(getdate())											NOT NULL,
    [LB_Entry_Text]				        [varchar](max)																NOT NULL,
    [LabBook_Project_ID]				int			FOREIGN KEY		REFERENCES Project(Project_ID)			NOT NULL,
	[SSMA_TimeStamp]		
*/
/*
BULK INSERT LB_Entry	-------------------------------------------------- LabBook
FROM 'c:\temp\DataTextFiles\LabBookEntries.txt'
WITH (
	FIRSTROW		= 1,
	FIELDTERMINATOR	= '\t',
	ROWTERMINATOR	= '\n'
);
GO
*/
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
