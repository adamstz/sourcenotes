/*===================================================================== Create Database */
GO
USE [master]
GO

SP_CONFIGURE 'show advanced options', 1
RECONFIGURE WITH OVERRIDE
GO
 
SP_CONFIGURE 'Database Mail XPs', 1
RECONFIGURE WITH OVERRIDE
GO
 
SP_CONFIGURE 'show advanced options', 0
RECONFIGURE WITH OVERRIDE
GO

DROP DATABASE IF EXISTS [SourceNotes]
GO

CREATE DATABASE [SourceNotes]
GO

USE [SourceNotes]
GO

/*===================================================================== Tables */
CREATE TABLE People(
	[People_Name]							[nvarchar](100)			PRIMARY KEY		NOT NULL
 )
GO

CREATE TABLE Keyword(
	[Keyword_Keyword]						[nvarchar](100)			PRIMARY KEY		NOT NULL
 )
 GO
CREATE TABLE Project(
	[Project_ID]						int			PRIMARY KEY		IDENTITY(1,1)												NOT NULL,
	[Project_Name]						[nvarchar](100)																			NOT NULL,
	[Project_Short_Name]				[nvarchar](10)																			NULL,
	[Project_Description]				[nvarchar](max)																			NULL,
	[Project_Date]						[datetime2](0)	DEFAULT (getdate())														NULL,
	[Project_Public]					bit																						NOT NULL,
	[Project_People_Key]				nvarchar(100)				FOREIGN KEY		REFERENCES People(People_Name)				NOT NULL,
	[Project_Keyword_Key]				nvarchar(100)				FOREIGN KEY		REFERENCES Keyword(Keyword_Keyword)			NOT NULL,
	[SSMA_TimeStamp]					[timestamp]																				NOT NULL
	
 )
GO
CREATE TABLE Users(
	[User_Email]					[nvarchar](255)			PRIMARY KEY						NOT NULL,
	[User_Username]					[nvarchar](255)											NOT NULL,
	[User_Password]					[nvarchar](255)											NOT NULL,
	[User_Bio]						[nvarchar](max)											NULL,
	[User_Admin]					bit														NOT NULL,
	[User_Project_ID]				int		FOREIGN KEY		REFERENCES Project(Project_ID)	NOT NULL,
	[SSMA_TimeStamp]				[timestamp]												NOT NULL
)
GO
CREATE TABLE Sources(
	[Source_Source_ID]					int			PRIMARY KEY		IDENTITY(1,1)							NOT NULL,
	[Source_Text_Details]				[nvarchar](max)														NOT NULL,
	[Note_TimeStamp]					[timestamp]															NOT NULL
 )
GO
CREATE TABLE Note(	
	[Note_ID]							int					PRIMARY KEY		IDENTITY(1,1)										NOT NULL,
	[Note_Text]							[nvarchar](max)																			NOT NULL,
	[Note_Doc_Date]						[datetime2](0)		DEFAULT (getdate())													NOT NULL,
	[Note_Project_ID]					int					FOREIGN KEY		REFERENCES Project(Project_ID)						NOT NULL,
	[Note_Source_ID]					int					FOREIGN KEY		REFERENCES Sources(Source_Source_ID)				NOT NULL,
	[Note_User_Author]					nvarchar(255)		FOREIGN KEY		REFERENCES Users(User_Email)						NOT NULL,											
	[Note_Keyword_Key]					nvarchar(100)		FOREIGN KEY		REFERENCES Keyword(Keyword_Keyword)					NOT NULL,
	[Note_Person_Key]					nvarchar(100)		FOREIGN KEY		REFERENCES People(People_Name)						NOT NULL,
	[SSMA_TimeStamp]					timestamp																				NOT NULL
 )
GO
CREATE TABLE LabBook(
	[LabBook_ID]						int			PRIMARY KEY		IDENTITY(1,1)							NOT NULL,
	[LabBook_Date_Time]					[datetime2](0)	DEFAULT(getdate())									NOT NULL,
	[LabBook_Project_ID]				int			FOREIGN KEY		REFERENCES Project(Project_ID)			NOT NULL,
	[SSMA_TimeStamp]					timestamp															NOT NULL
)
GO
CREATE TABLE LB_Entry(
    [LB_Entry_ID]                       int         PRIMARY KEY     IDENTITY(1,1)									NOT NULL,
	[LB_Entry_LabBook_ID]				int			FOREIGN KEY		REFERENCES LabBook(LabBook_ID)					NOT NULL,
    [LB_Entry_User]						[nvarchar](255)			FOREIGN KEY		REFERENCES Users(User_Email)	    NOT NULL,
    [LB_Entry_Date_Time]				[datetime2](0)	DEFAULT(getdate())											NOT NULL,
    [LB_Entry_Text]				        [varchar](max)																NOT NULL,
	[SSMA_TimeStamp]					[timestamp]	
)
CREATE TABLE Comment(
    [Comment_ID]					int			PRIMARY KEY		IDENTITY(1,1)										NOT NULL,
	[Comment_Date_Time]				[datetime2](0)	DEFAULT(getdate())												NOT NULL,
	[Comment_Text]					[varchar](max)																	NOT NULL,
	[Comment_Notes_ID]				int		FOREIGN KEY		REFERENCES Note(Note_ID)								NOT NULL,
	[Comment_From_User]				[nvarchar](255)		FOREIGN KEY		REFERENCES Users(User_Email)				NOT NULL,
	[SSMA_TimeStamp]				timestamp																		NOT NULL
) 
GO
CREATE TABLE Methodology(
    [Methodology_ID]				    int				PRIMARY KEY		IDENTITY(1,1)																NOT NULL,
	[Methodology_Text]					[varchar](max)	DEFAULT ('Create a document of best practices for your research project here.')				NOT NULL,
    [Methodology_Update]				[datetime2](0)	DEFAULT(getdate())																			NOT NULL,
	[Methodology_Project_ID]			int			FOREIGN KEY		REFERENCES Project(Project_ID)													NOT NULL,
	[SSMA_TimeStamp]					timestamp																									NOT NULL
)
GO
/* LAST SEMESTER USERS TABLE
CREATE TABLE [dbo].[Users](
	[Users_ID]							[int]			PRIMARY KEY		IDENTITY(1,1)	NOT NULL,
	[Users_Username]					[varchar](255)									NULL,
	[Users_Password]					[varchar](255)									NULL,
	[Users_Name]						[varchar](255)									NULL,
	[Users_Description]					[varchar](max)									NULL,
	[SSMA_TimeStamp]					[timestamp]										NOT NULL
)
GO
*/
/*
CREATE TABLE [dbo].[Projects](
	[Projects_ID]						[int]			PRIMARY KEY		IDENTITY(1,1)	NOT NULL,
	[Projects_Name]						[varchar](60)									NULL,
	[Projects_Name_Short]				[varchar](10)									NULL,
	[Projects_Date_Time]				[datetime2](0)	DEFAULT (getdate())				NULL,
	[Projects_Link]						[varchar](255)									NULL,
	[Projects_Description]				[varchar](max)									NULL,
	[Projects_Leaderboard_Scheduled]	[varchar](1)									NULL,
	[Projects_Comments_All]				[varchar](1)									NULL,
	[Projects_Notes_All]				[varchar](1)									NULL,
	[Projects_LabBook]					[varchar](max)	DEFAULT('Keep track of your ongoing research and results here.')				NULL,
	[Projects_Methodology]				[varchar](max)	DEFAULT ('Create a document of best practices for your research project here.')	NULL,
	[SSMA_TimeStamp]					[timestamp]										NOT NULL
 )
GO

*/
/*
create table [dbo].[labbook](
	[labbook_id]						[int]			primary key		identity(1,1)				not null,
	[labbook_date_time]					[datetime2](0)	default(getdate())							null,
	[labbook_text]						[varchar](max)												null,
	[labbook_users_id]					[int]			foreign key		references users(users_id)	not null,
	[labbook_projects_id]				[int]														null,
	[ssma_timestamp]					[timestamp]													not null
) 
go
*/
/*
CREATE TABLE [dbo].[Items](
	[Items_ID]							[int]			PRIMARY KEY		IDENTITY(1,1)						NOT NULL,
	[Items_Date_Time]					[datetime2](0)	DEFAULT(getdate())									NULL,
	[Items_Publication]					[varchar](max)														NULL,
	[Items_Publication_Alpha]			[varchar](2000)														NULL,
	[Items_Users_ID]					[int]																NULL,
	[Items_Projects_ID]					[int]			FOREIGN KEY		REFERENCES Projects(Projects_ID)	NOT NULL,
	[Items_Done]						[bit]			DEFAULT(0)											NULL,
	[SSMA_TimeStamp]					[timestamp]															NOT NULL
)
GO
*/
/*
CREATE TABLE [dbo].[Annotations](
	[Annotations_ID]					[int]			PRIMARY KEY		IDENTITY(1,1)				NOT NULL,
	[Annotations_Items_ID]				[int]			FOREIGN KEY		REFERENCES Items(Items_ID)	NOT NULL,
	[Annotations_Items_ID_Move]			[int]			DEFAULT(0)									NULL,
	[Annotations_Text]					[varchar](max)												NULL,
	[Annotations_Year]					[varchar](255)												NULL,
	[Annotations_Month]					[varchar](255)												NULL,
	[Annotations_Day]					[varchar](255)												NULL,
	[Annotations_Users_ID]				[int]														NULL,
	[Annotations_Date_Time]				[datetime2](0)	DEFAULT(getdate())							NULL,
	[Annotations_Projects_ID]			[int]														NULL,
	[SSMA_TimeStamp]					[timestamp]													NOT NULL
)	
GO
*/
/*
CREATE TABLE [dbo].[KeytoAnn](
	[KeytoAnn_ID]						[int]			PRIMARY KEY		IDENTITY(1,1)							NOT NULL,
	[KeytoAnn_Ann_ID]					[int]			FOREIGN KEY		REFERENCES Annotations(Annotations_ID)	NULL,
	[KeytoAnn_Key_ID]					[int]																	NULL,
	[KeytoAnn_Users_ID]					[int]			DEFAULT(0)												NULL,
	[KeytoAnn_Projects_ID]				[int]			DEFAULT(0)												NULL
 )
GO
*/
/*
CREATE TABLE [dbo].[Keywords](
	[Keywords_ID]						[int]			PRIMARY KEY		IDENTITY(1,1)	NOT NULL,
	[Keywords_Keyword]					[varchar](100)									NULL,
	[Keywords_Users_ID]					[int]											NULL,
	[Keywords_Projects_ID]				[int]											NULL
)
GO
*/
/*
CREATE TABLE [dbo].[Comments](
	[Comments_ID]						[int]			PRIMARY KEY		IDENTITY(1,1)	NOT NULL,
	[Comments_Date_Time]				[datetime2](0)	DEFAULT(getdate())				NULL,
	[Comments_Annotations_ID]			[int]			DEFAULT(0)						NULL,
	[Comments_Projects_ID]				[int]			DEFAULT(0)						NULL,
	[Comments_Users_ID]					[int]			DEFAULT(0)						NULL,
	[Comments_Users_Name]				[varchar](255)									NULL,
	[Comments_Filer_ID]					[int]											NULL,
	[Comments_Filer_Name]				[varchar](255)									NULL,
	[Comments_Comment]					[varchar](max)									NULL,
	[SSMA_TimeStamp]					[timestamp]										NOT NULL
) 
GO
*/
/*
CREATE TABLE [dbo].[People](
	[People_ID]							[int]			PRIMARY KEY		IDENTITY(1,1)	NOT NULL,
	[People_Name]						[varchar](100)									NULL,
	[People_Description]				[varchar](255)									NULL,
	[People_Users_ID]					[int]											NULL,
	[People_Projects_ID]				[int]											NULL
)
GO
*/
/*
CREATE TABLE [dbo].[PeotoAnn](
	[PeotoAnn_ID]						[int]			PRIMARY KEY		IDENTITY(1,1)							NOT NULL,
	[PeotoAnn_Ann_ID]					[int]			FOREIGN KEY		REFERENCES Annotations(Annotations_ID)	NOT NULL,
	[PeotoAnn_Peo_ID]					[int]			FOREIGN KEY		REFERENCES People(People_ID)			NULL,
	[PeotoAnn_Users_ID]					[int]																	NULL,
	[PeotoAnn_Projects_ID]				[int]																	NULL,
 )
GO
*/
/*
CREATE TABLE [dbo].[ProjectstoUsers](
	[ProjectstoUsers_ID]				[int]			PRIMARY KEY		IDENTITY(1,1)						NOT NULL,
	[ProjectstoUsers_Users_ID]			[int]			FOREIGN KEY		REFERENCES Users(Users_ID)			NULL,
	[ProjectstoUsers_Projects_ID]		[int]			FOREIGN KEY		REFERENCES Projects(Projects_ID)	NULL,
	[ProjectstoUsers_Admin]				[varchar](1)														NULL,
	[ProjectstoUsers_Public]			[varchar](1)														NULL,
	[ProjectstoUsers_Anonymous]			[varchar](1)														NULL,
	[ProjectstoUsers_Show]				[varchar](1)														NULL,
	[ProjectstoUsers_Group]				[varchar](200)														NULL
)
GO
*/
/*
CREATE TABLE [dbo].[Reports](
	[Reports_ID]						[int]			PRIMARY KEY		IDENTITY(1,1)	NOT NULL,
	[Reports_Projects_ID]				[int]			DEFAULT(0)						NULL,
	[Reports_Date_Time]					[datetime2](0)	DEFAULT(getdate())				NULL,
	[Reports_Users_ID]					[int]											NULL,
	[Reports_Users_Name]				[varchar](255)									NULL,
	[Reports_Filer_ID]					[int]											NULL,
	[Reports_Filer_Name]				[varchar](255)									NULL,
	[Reports_Report]					[varchar](max)									NULL,
	[SSMA_TimeStamp]					[timestamp]										NOT NULL
)
GO
*/
/*
CREATE TABLE [dbo].[Stats](
	[Stats_ID]							[int]			PRIMARY KEY		IDENTITY(1,1)	NOT NULL,
	[Stats_Date_Time]					[datetime2](0)	DEFAULT(getdate())				NULL,
	[Stats_Projects_ID]					[int]			DEFAULT(0)						NULL,
	[Stats_Name]						[varchar](255)									NULL,
	[Stats_Entries]						[int]			DEFAULT(0)						NULL,
	[Stats_Words]						[int]			DEFAULT(0)						NULL,
	[Stats_WRec]						[float]			DEFAULT(0)						NULL,
	[Stats_MinRec]						[float]			DEFAULT(0)						NULL,
	[Stats_KWT]							[int]			DEFAULT(0)						NULL,
	[Stats_KWC]							[int]			DEFAULT(0)						NULL,
	[Stats_PT]							[int]			DEFAULT(0)						NULL,
	[Stats_PC]							[int]			DEFAULT(0)						NULL,
	[SSMA_TimeStamp]					[timestamp]										NOT NULL
)
GO
*/
/*===================================================================== Views */
GO
/* COMMENTED OUT ON 10/29/22
-------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[Boone_Query_Items]
AS 
   SELECT TOP 9223372036854775807 WITH TIES 
      [Items].[Items_ID], 
      [Items].[Items_Publication], 
      [Items].[Items_Users_ID], 
      [Items].[Items_Projects_ID], 
      [Annotations].[Annotations_Text]
   FROM 
      [Items] 
         INNER JOIN [Annotations] 
         ON [Items].[Items_ID] = [Annotations].[Annotations_Items_ID]
   WHERE ((([Items].[Items_Users_ID]) = 40) AND (([Items].[Items_Projects_ID]) = 27))
   ORDER BY [Items].[Items_Publication]
GO

CREATE VIEW [dbo].[CommentsQ]
AS 
   SELECT [Comments].*, [Users].[Users_Name]
   FROM 
      [Comments] 
         LEFT JOIN [Users] 
         ON [Comments].[Comments_Filer_ID] = [Users].[Users_ID]
GO

CREATE VIEW [dbo].[Find_Duplicates_For_Items]
AS 
   SELECT TOP 9223372036854775807 WITH TIES 
      [Items].[Items_Publication_Alpha], 
      [Items].[Items_ID], 
      [Items].[Items_Date_Time], 
      [Items].[Items_Users_ID], 
      [Items].[Items_Projects_ID], 
      [Items].[Items_Done]
   FROM [Items]
   WHERE ((([Items].[Items_Publication_Alpha]) IN 
      (
         SELECT [Items_Publication_Alpha]
         FROM [Items]  AS Tmp
         GROUP BY [Items_Publication_Alpha]
         HAVING Count(*) > 1
      )))
   ORDER BY [Items].[Items_Publication_Alpha]
GO

CREATE VIEW [dbo].[Find_Duplicates_For_Keywords]
AS 
   SELECT TOP 9223372036854775807 WITH TIES [Keywords].[Keywords_Keyword], [Keywords].[Keywords_ID], [Keywords].[Keywords_Users_ID], [Keywords].[Keywords_Projects_ID]
   FROM [Keywords]
   WHERE ((([Keywords].[Keywords_Keyword]) IN 
      (
         SELECT [Keywords_Keyword]
         FROM [Keywords]  AS Tmp
         GROUP BY [Keywords_Keyword]
         HAVING Count(*) > 1
      )) AND (([Keywords].[Keywords_Projects_ID]) = 1))
   ORDER BY [Keywords].[Keywords_Keyword]
GO

CREATE VIEW [dbo].[Items_Without_Matching_Projects]
AS 
   SELECT 
      [Items].[Items_ID], 
      [Items].[Items_Date_Time], 
      [Items].[Items_Publication], 
      [Items].[Items_Publication_Alpha], 
      [Items].[Items_Users_ID], 
      [Items].[Items_Projects_ID], 
      [Items].[Items_Done]
   FROM 
      [Items] 
         LEFT JOIN [Projects] 
         ON [Items].[Items_Projects_ID] = [Projects].[Projects_ID]
   WHERE ((([Projects].[Projects_ID]) IS NULL))
GO

CREATE VIEW [dbo].[KeytoAnnQ]
AS 
   SELECT TOP 9223372036854775807 WITH TIES 
      [KeytoAnn].[KeytoAnn_ID], 
      [KeytoAnn].[KeytoAnn_Ann_ID], 
      [KeytoAnn].[KeytoAnn_Key_ID], 
      [KeytoAnn].[KeytoAnn_Users_ID], 
      [Keywords].[Keywords_ID], 
      [Keywords].[Keywords_Keyword], 
      [Keywords].[Keywords_Users_ID], 
      [KeytoAnn].[KeytoAnn_Projects_ID]
   FROM 
      [Keywords] 
         LEFT JOIN [KeytoAnn] 
         ON [Keywords].[Keywords_ID] = [KeytoAnn].[KeytoAnn_Key_ID]
   ORDER BY [KeytoAnn].[KeytoAnn_Ann_ID], [Keywords].[Keywords_Keyword]
GO

CREATE VIEW [dbo].[LabBookQ]
AS 
   SELECT 
      [LabBook].[LabBook_ID], 
      [LabBook].[LabBook_Date_Time], 
      [LabBook].[LabBook_Text], 
      [LabBook].[LabBook_Users_ID], 
      [LabBook].[LabBook_Projects_ID], 
      [Users].[Users_Name], 
      [Users].[Users_ID]
   FROM 
      [Users] 
         RIGHT JOIN [LabBook] 
         ON [Users].[Users_ID] = [LabBook].[LabBook_Users_ID]
GO

CREATE VIEW [dbo].[PeotoAnnQ]
AS 
   /*
   *   SSMA warning messages:
   *   A2SS0067: Synchronization may run with errors because column names may repeat in '*' expression. 
   *
   *   A2SS0067: Synchronization may run with errors because column names may repeat in '*' expression. 
   *
   */

   SELECT [People].*, [PeotoAnn].*
   FROM 
      [People] 
         LEFT JOIN [PeotoAnn] 
         ON [People].[People_ID] = [PeotoAnn].[PeotoAnn_Peo_ID]
GO

CREATE VIEW [dbo].[ProjectstoUsersQ]
AS 
   SELECT 
      [ProjectstoUsers].[ProjectstoUsers_ID], 
      [Users].[Users_Name], 
      [Projects].[Projects_Name], 
      [Projects].[Projects_Name_Short], 
      [Projects].[Projects_ID], 
      [Users].[Users_ID], 
      [ProjectstoUsers].[ProjectstoUsers_Admin], 
      [ProjectstoUsers].[ProjectstoUsers_Public], 
      [Projects].[Projects_Link], 
      [Projects].[Projects_Description], 
      [Users].[Users_Description], 
      [ProjectstoUsers].[ProjectstoUsers_Show], 
      [ProjectstoUsers].[ProjectstoUsers_Group], 
      [Users].[Users_Username], 
      [Users].[Users_Password], 
      [Projects].[Projects_Comments_All] AS [Projects_Projects_Comments_All], 
      [ProjectstoUsers].[ProjectstoUsers_Anonymous], 
      [Projects].[Projects_Date_Time], 
      [Projects].[Projects_Leaderboard_Scheduled], 
      [Projects].[Projects_Comments_All] AS [Projects_Projects_Comments_All$2], 
      [Projects].[Projects_Notes_All]
   FROM 
      [Users] 
         RIGHT JOIN ([Projects] 
         RIGHT JOIN [ProjectstoUsers] 
         ON [Projects].[Projects_ID] = [ProjectstoUsers].[ProjectstoUsers_Projects_ID]) 
         ON [Users].[Users_ID] = [ProjectstoUsers].[ProjectstoUsers_Users_ID]
GO

CREATE VIEW [dbo].[QCDateNone]
AS 
   SELECT TOP 9223372036854775807 WITH TIES Count([Annotations].[Annotations_ID]) AS CountOfAnnotations_ID, [Users].[Users_Name]
   FROM 
      [Users] 
         LEFT JOIN [Annotations] 
         ON [Users].[Users_ID] = [Annotations].[Annotations_Users_ID]
   GROUP BY 
      [Users].[Users_Name], 
      [Annotations].[Annotations_Year], 
      [Annotations].[Annotations_Month], 
      [Annotations].[Annotations_Day], 
      [Annotations].[Annotations_Projects_ID]
   HAVING (
      (([Annotations].[Annotations_Year]) = '') AND 
      (([Annotations].[Annotations_Month]) = '') AND 
      (([Annotations].[Annotations_Day]) = '') AND 
      (([Annotations].[Annotations_Projects_ID]) = 54))
   ORDER BY Count([Annotations].[Annotations_ID]) DESC, [Users].[Users_Name]
GO

CREATE VIEW [dbo].[AllItems]
AS 
   SELECT 
      [Items].[Items_Users_ID], 
      [Annotations].[Annotations_Text], 
      [Annotations].[Annotations_ID], 
      [Annotations].[Annotations_Users_ID] AS [Annotations_Annotations_Users_ID], 
      [Items].[Items_ID], 
      [Annotations].[Annotations_Date_Time], 
      [Items].[Items_Publication] AS [Items_Items_Publication], 
      [Annotations].[Annotations_Projects_ID], 
      [Annotations].[Annotations_Year], 
      [Annotations].[Annotations_Month], 
      [Annotations].[Annotations_Day], 
      [ProjectstoUsersQ].[Users_Name], 
      [ProjectstoUsersQ].[Projects_Name], 
      [ProjectstoUsersQ].[Projects_ID], 
      [ProjectstoUsersQ].[Users_ID], 
      [ProjectstoUsersQ].[ProjectstoUsers_Public], 
      [ProjectstoUsersQ].[Projects_Description], 
      [ProjectstoUsersQ].[Users_Description], 
      [Items].[Items_Publication] AS [Items_Items_Publication$2], 
      [Annotations].[Annotations_Users_ID] AS [Annotations_Annotations_Users_ID$3], 
      [Annotations].[Annotations_Items_ID], 
      [Items].[Items_Publication_Alpha], 
      [ProjectstoUsersQ].[ProjectstoUsers_Anonymous]
   FROM 
      ([Items] 
         RIGHT JOIN [Annotations] 
         ON [Items].[Items_ID] = [Annotations].[Annotations_Items_ID]) 
         INNER JOIN [ProjectstoUsersQ] 
         ON ([Annotations].[Annotations_Users_ID] = [ProjectstoUsersQ].[Users_ID]) AND ([Annotations].[Annotations_Projects_ID] = [ProjectstoUsersQ].[Projects_ID])
GO

CREATE VIEW [dbo].[AllItemsComments]
AS 
   /*
   *   SSMA warning messages:
   *   A2SS0067: Synchronization may run with errors because column names may repeat in '*' expression. 
   *
   */

   SELECT 
      [AllItems].*, 
      [CommentsQ].[Comments_Date_Time], 
      [CommentsQ].[Comments_Users_ID], 
      [CommentsQ].[Comments_Projects_ID], 
      [CommentsQ].[Comments_Comment], 
      [CommentsQ].[Comments_Filer_ID], 
      [CommentsQ].[Comments_Filer_Name]
   FROM 
      [CommentsQ] 
         INNER JOIN [AllItems] 
         ON [CommentsQ].[Comments_Annotations_ID] = [AllItems].[Annotations_ID]
GO

CREATE VIEW [dbo].[AllItemsPublic]
AS 
   SELECT 
      [Items].[Items_Users_ID], 
      [Annotations].[Annotations_Text], 
      [Annotations].[Annotations_ID], 
      [Annotations].[Annotations_Users_ID], 
      [Items].[Items_ID], 
      [Annotations].[Annotations_Date_Time], 
      [Items].[Items_Publication], 
      [Annotations].[Annotations_Projects_ID], 
      [Annotations].[Annotations_Year], 
      [Annotations].[Annotations_Month], 
      [Annotations].[Annotations_Day], 
      [ProjectstoUsersQ].[Users_Name], 
      [ProjectstoUsersQ].[ProjectstoUsers_Public], 
      [ProjectstoUsersQ].[Projects_Name], 
      [ProjectstoUsersQ].[Projects_Description] AS [ProjectstoUsersQ_Projects_Description], 
      [ProjectstoUsersQ].[Projects_Description] AS [ProjectstoUsersQ_Projects_Description$2], 
      [ProjectstoUsersQ].[Users_Description], 
      [Comments].[Comments_Annotations_ID], 
      [ProjectstoUsersQ].[ProjectstoUsers_Anonymous]
   FROM 
      [Comments] 
         RIGHT JOIN (([Items] 
         RIGHT JOIN [Annotations] 
         ON [Items].[Items_ID] = [Annotations].[Annotations_Items_ID]) 
         LEFT JOIN [ProjectstoUsersQ] 
         ON ([Items].[Items_Users_ID] = [ProjectstoUsersQ].[Users_ID]) AND ([Items].[Items_Projects_ID] = [ProjectstoUsersQ].[Projects_ID])) 
         ON [Comments].[Comments_Annotations_ID] = [Annotations].[Annotations_ID]
   WHERE ((([ProjectstoUsersQ].[ProjectstoUsers_Public]) = 'Y'))
GO

CREATE VIEW [dbo].[AllItems_SAVE]
AS 
   SELECT 
      [Items].[Items_Users_ID], 
      [Annotations].[Annotations_Text], 
      [Annotations].[Annotations_ID], 
      [Annotations].[Annotations_Users_ID] AS [Annotations_Annotations_Users_ID], 
      [Items].[Items_ID], 
      [Annotations].[Annotations_Date_Time], 
      [Items].[Items_Publication] AS [Items_Items_Publication], 
      [Annotations].[Annotations_Projects_ID], 
      [Annotations].[Annotations_Year], 
      [Annotations].[Annotations_Month], 
      [Annotations].[Annotations_Day], 
      [ProjectstoUsersQ].[Users_Name], 
      [ProjectstoUsersQ].[Projects_Name], 
      [ProjectstoUsersQ].[Projects_ID], 
      [ProjectstoUsersQ].[Users_ID], 
      [ProjectstoUsersQ].[ProjectstoUsers_Public], 
      [ProjectstoUsersQ].[Projects_Description], 
      [ProjectstoUsersQ].[Users_Description], 
      [Items].[Items_Publication] AS [Items_Items_Publication$2], 
      [Annotations].[Annotations_Users_ID] AS [Annotations_Annotations_Users_ID$3], 
      [Annotations].[Annotations_Items_ID], 
      [Items].[Items_Publication_Alpha], 
      [ProjectstoUsersQ].[ProjectstoUsers_Anonymous]
   FROM 
      ([Items] 
         RIGHT JOIN [Annotations] 
         ON [Items].[Items_ID] = [Annotations].[Annotations_Items_ID]) 
         LEFT JOIN [ProjectstoUsersQ] 
         ON ([Items].[Items_Users_ID] = [ProjectstoUsersQ].[Users_ID]) AND ([Items].[Items_Projects_ID] = [ProjectstoUsersQ].[Projects_ID])
GO

CREATE VIEW [dbo].[AllItemsPeople]
	AS 
		SELECT	
			[AllItems].[Items_Users_ID], 
			[AllItems].[Annotations_Text], 
			[AllItems].[Annotations_ID], 
			[AllItems].[Annotations_Annotations_Users_ID],
			[AllItems].[Items_ID],
			[AllItems].[Annotations_Date_Time],
			[PeotoAnn].[PeotoAnn_Peo_ID], 
			[People].[People_Name],
			[PeotoAnn].[PeotoAnn_Projects_ID],
			[People].[People_ID], 
			[AllItems].[Annotations_Year],
			[AllItems].[Annotations_Month],
			[AllItems].[Annotations_Day],
			[AllItems].[Items_Items_Publication],
			[ProjectstoUsersQ].[Users_Name],
			[ProjectstoUsersQ].[Users_Description],
			[ProjectstoUsersQ].[Projects_Name],
			[ProjectstoUsersQ].[Projects_Description],
			[ProjectstoUsersQ].[ProjectstoUsers_Public],
			[ProjectstoUsersQ].[Projects_ID], 
			[ProjectstoUsersQ].[Users_ID], 
			[AllItems].[Annotations_Projects_ID],
			[ProjectstoUsersQ].[ProjectstoUsers_Anonymous],
			[PeotoAnn].[PeotoAnn_Users_ID],
			[People].[People_Users_ID], 
			[People].[People_Projects_ID]
	FROM 
		([People]
			RIGHT JOIN ([AllItems] 
			LEFT JOIN [PeotoAnn] 
			ON [AllItems].[Annotations_ID]	= [PeotoAnn].[PeotoAnn_Ann_ID]) 
			ON [People].[People_ID]			= [PeotoAnn].[PeotoAnn_Peo_ID]) 
			LEFT JOIN [ProjectstoUsersQ] 
			ON ([AllItems].[Projects_ID]	= [ProjectstoUsersQ].[Projects_ID]) AND ([AllItems].[Items_Users_ID] = [ProjectstoUsersQ].[Users_ID]);


GO

CREATE VIEW [dbo].[AllItemsKeyword]
	AS 
		SELECT 
			[KeytoAnn].[KeytoAnn_Key_ID], 
			[AllItems].[Items_Users_ID], 
			[AllItems].[Annotations_Text], 
			[AllItems].[Annotations_ID], 
			[AllItems].[Annotations_Annotations_Users_ID], 
			[AllItems].[Items_ID], 
			[AllItems].[Annotations_Date_Time], 
			[Keywords].[Keywords_ID], 
			[Keywords].[Keywords_Keyword], 
			[KeytoAnn].[KeytoAnn_Projects_ID], 
			[AllItems].[Annotations_Year], 
			[AllItems].[Annotations_Month], 
			[AllItems].[Annotations_Day], 
			[ProjectstoUsersQ].[Users_Name], 
			[ProjectstoUsersQ].[ProjectstoUsers_Public], 
			[ProjectstoUsersQ].[Projects_Name],
			[ProjectstoUsersQ].[Projects_Description], 
			[ProjectstoUsersQ].[Users_Description], 
			[AllItems].[Annotations_Projects_ID], 
			[AllItems].[Items_Items_Publication], 
			[ProjectstoUsersQ].[ProjectstoUsers_Anonymous],
			[KeytoAnn].[KeytoAnn_Users_ID], 
			[Keywords].[Keywords_Users_ID], 
			[Keywords].[Keywords_Projects_ID], 
			[ProjectstoUsersQ].[Users_ID]
	FROM 
		([AllItems]
			LEFT JOIN ([Keywords] 
			RIGHT JOIN [KeytoAnn]
			ON [Keywords].[Keywords_ID]			= [KeytoAnn].[KeytoAnn_Key_ID]) 
			ON [AllItems].[Annotations_ID]		= [KeytoAnn].[KeytoAnn_Ann_ID]) 
			LEFT JOIN [ProjectstoUsersQ]	
			ON ([AllItems].[Projects_ID]		= [ProjectstoUsersQ].[Projects_ID]) AND ([AllItems].[Items_Users_ID]	= [ProjectstoUsersQ].[Users_ID]);
GO

--===========================================================================================================
--==== STORED PROCEDURE LIST FOR SOURCENOTES ====--

-- =============================================
-- Author:		M. Stahr
-- Create date: 2022-02-10
-- Description:	Return a person by project & id
-- =============================================
CREATE PROCEDURE [dbo].[getPersonByID_ProjectsID] 
	@People_ID	INT,
	@People_Projects_ID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		People_ID, 
		People_Name,
		[People_Description] = ISNULL(People_Description, ''),
		People_Users_ID,
		People_Projects_ID
	FROM [People] 
	WHERE	People_ID = @People_ID AND 
			People_Projects_ID = @People_Projects_ID
END
GO

-- =============================================
-- Author:		Stahr, Mike
-- Create date: 2022-02-10
-- Description:	Login validation
-- =============================================
CREATE PROCEDURE [dbo].[spValidate]
	@username VARCHAR(25),
	@password varchar(25)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Users_ID FROM Users WHERE (Users_Username = @username) AND (Users_Password = @password)
END
GO


--=================================================
--==== GET PUBLIC PROJECTS
GO
CREATE PROC spGetPublicProjects
AS BEGIN SET NOCOUNT ON
	SELECT DISTINCT	
		Projects_ID,
		Projects_Date_Time,
		Projects_Name,
		Projects_Link, 
		Projects_Description,
		[Total_Notes] =  (SELECT COUNT(*) FROM [AllItemsPublic] WHERE Annotations_Projects_ID = p.Projects_ID)
	FROM 
		ProjectstoUsersQ p
	WHERE 
		ProjectstoUsers_Public ='Y'
	ORDER BY Projects_Date_Time DESC
END

--=================================================
--==== GET PUBLIC PROJECT DETAILS
GO
CREATE PROC spGetPublicProjectDetails
	@Project_ID INT
AS Begin SET NOCOUNT ON
SELECT DISTINCT *
FROM Projects
WHERE Projects_ID = @Project_ID
END

--select * from Projects p where p.Projects_ID = 174

--=================================================
--==== GET PUBLIC PROJECT PEOPLE
GO
CREATE PROC spGetPublicProjectPeople
	@Project_ID INT
AS Begin SET NOCOUNT ON

	DECLARE @cnt INT = (
         SELECT   COUNT(distinct People_ID) 
	        FROM AllItemsPeople
	        WHERE  (PeotoAnn_Projects_ID = @Project_ID) AND (People_ID > 0)	
    )

	SELECT 
		People_Name, People_ID, 
		COUNT(*) AS numOfEntries, [RowCount] = @cnt
	FROM 
		AllItemsPeople
	WHERE 
			(PeotoAnn_Projects_ID = @Project_ID)
		AND (People_ID > 0)	
	GROUP BY People_Name, People_ID
	ORDER BY People_Name ASC

	/*
		spGetPublicProjectsPeopl 174
	*/

END

--=================================================
--==== GET PUBLIC PROJECT KEYWORDS
GO
CREATE PROC spGetPublicProjectKeywords
	@Project_ID INT
AS Begin SET NOCOUNT ON 

    DECLARE @cnt INT = (
         SELECT   COUNT(distinct Keywords_ID) 
	        FROM AllItemsKeyword
	        WHERE  (KeytoAnn_Projects_ID = @Project_ID) AND (Keywords_ID > 0)	
    )
    
	    SELECT 
		    Keywords_Keyword, Keywords_ID, 
		    COUNT(*) AS numOfEntries,[RowCount] = @cnt
	    FROM 
		    AllItemsKeyword
	    WHERE 
			    (KeytoAnn_Projects_ID = @Project_ID)
		    AND (Keywords_ID > 0)	
	    GROUP BY Keywords_Keyword, Keywords_ID
	    ORDER BY Keywords_Keyword ASC

        /*
            spGetPublicProjectKeywords 174
        */

END

--=================================================
--==== Browse Public Notes
GO
CREATE Proc spBrowsePublicNotesPages
	@Project_ID INT=0,
	@Page		INT=1,
	@count		INT=1
AS Begin SET NOCOUNT ON
	SET @Page = @Page-1;
	SET @Page = IIF(@Page < 0, 0, @page)
	SET @count= IIF(@count < 1, 1, @count)

	DECLARE @noteCount INT = (SELECT COUNT(*) FROM AllItemsPublic WHERE Annotations_Projects_ID = @Project_ID);

	SELECT *, [pages] = @noteCount / @count + IIF(@noteCount % @count = 0, 0 , 1)
	FROM
			AllItemsPublic
	WHERE
			Annotations_Projects_ID		= @Project_ID		--AND
		--	Items_ID					= 26103
	ORDER BY Annotations_Date_Time
		OFFSET (@page * @count) ROWS
		FETCH NEXT @count ROWS ONLY

END



--================================================
--========= DBMail Setup for Account Requests
--DBMail gmail account
-- SourceNotesDB@gmail.com
-- Password: SourceNotesDB2022

--EXEC msdb.dbo.sysmail_add_account_sp
--    @account_name = 'SourceNotesDBAccount',
--    @description = 'Send emails using SQL Server Stored Procedure',
--    @email_address = 'SourceNotesDB@gmail.com',
--    @display_name = 'SourceNotes',
--    @replyto_address = 'SourceNotesDB@gmail.com',
--    @mailserver_name = 'smtp.gmail.com',
--    @username = 'SourceNotesDB@gmail.com',
--    @password = 'SourceNotesDB2022',
--    @port = 587,
--    @enable_ssl = 1
--GO

--EXEC msdb.dbo.sysmail_add_profile_sp
--    @profile_name = 'SourceNotesDBProfile',
--    @description = 'Send emails using SQL Server Stored Procedure'
--GO

--EXEC msdb.dbo.sysmail_add_profileaccount_sp
--    @profile_name = 'SourceNotesDBProfile',
--    @account_name = 'SourceNotesDBAccount',
--    @sequence_number = 1
--GO


----===============================================
----====== Request Account
--GO
--CREATE Proc spRequestAccount
--    @Email VARCHAR(255),
--    @Name VARCHAR(255),
--    @Project_Name VARCHAR(60),
--    @Project_Name_Short VARCHAR(10),
--    @Project_Description VARCHAR(max)

--AS Begin SET NOCOUNT ON
    
--    DECLARE @CurrUID INT, @CurrProjID INT
    
--    DECLARE @ExistingID INT
--    SELECT @ExistingID = Users_ID FROM Users WHERE Users_Username = @Email

--    IF @ExistingID IS NULL
--    BEGIN
        
--        INSERT INTO Users (Users_Username, Users_Password, Users_Name)
--        VALUES(
--            @Email,
--            'TEMPORARY',
--            @Name
--        )
--        SET @CurrUID = (SELECT @@IDENTITY)
        
--    END
--    ELSE BEGIN

--        SET @CurrUID = @ExistingID

--    END

--    INSERT INTO Projects (Projects_Name, Projects_Name_Short, Projects_Description, Projects_Leaderboard_Scheduled, Projects_Comments_ALL)
--        VALUES(
--            @Project_Name,
--            @Project_Name_Short,
--            @Project_Description,
--            'N',
--            'Y'
--        )
--    SET @CurrProjID = (SELECT @@IDENTITY)


--    INSERT INTO ProjectsToUsers (ProjectsToUsers_Users_ID, ProjectsToUsers_Projects_ID, ProjectsToUsers_Show, ProjectsToUsers_Admin)
--        VALUES(
--            @CurrUID,
--            @CurrProjID,
--            'Y',
--            'Y'
--        )

--    DECLARE @message VARCHAR(Max) = 'Account Request: ' + @Project_Name + CHAR(10) + 'Name: ' + @Name + CHAR(10) + 'Email: ' + @Email + CHAR(10) + 'Description: ' + @Project_Description

--    EXEC msdb.dbo.sp_send_dbmail
--        @profile_name = 'SourceNotesDBProfile',
--        @recipients = 'offenba@miamioh.edu',
--        @subject = 'New Account Request',
--        @body = @message,
--        @importance ='HIGH'
    


--END

--=================================================
--==== Full Text Search - public projects
GO

CREATE PROC spSearchAllItemsPublic
	@search	varchar(50),
	@project_id	INT = 0
AS BEGIN SET NOCOUNT ON
	if(len(rtrim(ltrim((@search)))) < 4) return;

	Select TOP (20)*
	FROM AllItemsPublic
	WHERE 
		Annotations_Text LIKE '%'+ @search +'%' AND
		Annotations_Projects_ID = @project_id
	ORDER BY Annotations_Year, Annotations_Month, Annotations_Day, Annotations_Date_Time DESC

END

----------------------------------------------------------------------------------------------------------
COMMENTED OUT ON 10-29-22*/