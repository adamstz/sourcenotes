/*===================================================================== Create Database */
GO
USE [master]
GO
/*
SP_CONFIGURE 'show advanced options', 1
RECONFIGURE WITH OVERRIDE
GO
 
SP_CONFIGURE 'Database Mail XPs', 1
RECONFIGURE WITH OVERRIDE
GO
 /SP_CONFIGURE 'show advanced options', 0
RECONFIGURE WITH OVERRIDE
GO
*/
DROP DATABASE IF EXISTS [SourceNotes]
GO

CREATE DATABASE [SourceNotes]
GO

USE [SourceNotes]
GO
/*=========================================*/
/****** Object: Table [dbo].[__EFMigrationsHistory] Script Date: 11/21/2022 2:56:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE IF EXISTS [dbo].[__EFMigrationsHistory]

CREATE TABLE [dbo].[__EFMigrationsHistory] (
    [MigrationId]    NVARCHAR (150) NOT NULL,
    [ProductVersion] NVARCHAR (32)  NOT NULL
);
DROP TABLE IF EXISTS [dbo].[AspNetRoleClaims];


GO
CREATE TABLE [dbo].[AspNetRoleClaims] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [RoleId]     NVARCHAR (450) NOT NULL,
    [ClaimType]  NVARCHAR (MAX) NULL,
    [ClaimValue] NVARCHAR (MAX) NULL
);

DROP TABLE IF EXISTS [dbo].[AspNetRoles];


GO
CREATE TABLE [dbo].[AspNetRoles] (
    [Id]               NVARCHAR (450) NOT NULL,
    [Name]             NVARCHAR (256) NULL,
    [NormalizedName]   NVARCHAR (256) NULL,
    [ConcurrencyStamp] NVARCHAR (MAX) NULL
);

DROP TABLE IF EXISTS [dbo].[AspNetUserClaims];


GO
CREATE TABLE [dbo].[AspNetUserClaims] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [UserId]     NVARCHAR (450) NOT NULL,
    [ClaimType]  NVARCHAR (MAX) NULL,
    [ClaimValue] NVARCHAR (MAX) NULL
);

DROP TABLE IF EXISTS [dbo].[AspNetUserLogins];


GO
CREATE TABLE [dbo].[AspNetUserLogins] (
    [LoginProvider]       NVARCHAR (128) NOT NULL,
    [ProviderKey]         NVARCHAR (128) NOT NULL,
    [ProviderDisplayName] NVARCHAR (MAX) NULL,
    [UserId]              NVARCHAR (450) NOT NULL
);

DROP TABLE IF EXISTS [dbo].[AspNetUserRoles];


GO
CREATE TABLE [dbo].[AspNetUserRoles] (
    [UserId] NVARCHAR (450) NOT NULL,
    [RoleId] NVARCHAR (450) NOT NULL
);

DROP TABLE IF EXISTS [dbo].[AspNetUsers];


GO
CREATE TABLE [dbo].[AspNetUsers] (
    [Id]                   NVARCHAR (450)      NOT NULL,
    [UserName]             NVARCHAR (256)     NULL,
    [NormalizedUserName]   NVARCHAR (256)     NULL,
    [Email]                NVARCHAR (256) primary key     not NULL,
    [NormalizedEmail]      NVARCHAR (256)     NULL,
    [EmailConfirmed]       BIT                NOT NULL,
    [PasswordHash]         NVARCHAR (MAX)     NULL,
    [SecurityStamp]        NVARCHAR (MAX)     NULL,
    [ConcurrencyStamp]     NVARCHAR (MAX)     NULL,
    [PhoneNumber]          NVARCHAR (MAX)     NULL,
    [PhoneNumberConfirmed] BIT                NOT NULL,
    [TwoFactorEnabled]     BIT                NOT NULL,
    [LockoutEnd]           DATETIMEOFFSET (7) NULL,
    [LockoutEnabled]       BIT                NOT NULL,
    [AccessFailedCount]    INT                NOT NULL
);
DROP TABLE IF EXISTS [dbo].[AspNetUserTokens];
GO
CREATE TABLE [dbo].[AspNetUserTokens] (
    [UserId]        NVARCHAR (450) NOT NULL,
    [LoginProvider] NVARCHAR (128) NOT NULL,
    [Name]          NVARCHAR (128) NOT NULL,
    [Value]         NVARCHAR (MAX) NULL
);

DROP TABLE IF EXISTS [dbo].[WeatherForecast];



/*===================================================================== Tables */

CREATE TABLE Project(
	[Project_ID]						int			PRIMARY KEY		IDENTITY(1,1)	NOT NULL,
	[Project_Name]						[nvarchar](100)							    NOT NULL,
	[Project_Short_Name]				[nvarchar](10)								NULL,
	[Project_Description]				[nvarchar](max)							    NULL,
	[Project_Date]						[datetime2](0)	DEFAULT (getdate())		    NULL,
	[Project_Public]					int											NULL,
	[SSMA_TimeStamp]					[timestamp]									NOT NULL
	
 )
GO
/*
CREATE TABLE Users(
	[User_Email]					[nvarchar](255)			PRIMARY KEY						NOT NULL,
	[User_Username]					[nvarchar](255)											NOT NULL,
	[User_Password]					[nvarchar](255)											NOT NULL,
	[User_Bio]						[nvarchar](max)											NULL,
	[User_Admin]					bit														NOT NULL,
	[User_Project_ID]				int		FOREIGN KEY		REFERENCES Project(Project_ID)	NOT NULL,
	[SSMA_TimeStamp]				[timestamp]												NOT NULL
)
*/
GO
CREATE TABLE UsersToProjects(
	[UsersToProject_ID]			int			PRIMARY KEY		IDENTITY(1,1)				NOT NULL,
	[User_Email]              NVARCHAR (256)  foreign key REFERENCES AspNetUsers(Email)			NOT NULL,
	[Project_ID]				int		FOREIGN KEY		REFERENCES Project(Project_ID)	NOT NULL
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
	[Note_User_Author]					nvarchar(256)		FOREIGN KEY		REFERENCES AspNetUsers(Email)						NOT NULL,											
	[SSMA_TimeStamp]					timestamp																				NOT NULL
 )
GO
CREATE TABLE People(
	[People_ID]							int			PRIMARY KEY		Identity(1,1),
	[People_Name]							[nvarchar](100)					NOT NULL
	

 )
GO
CREATE TABLE Keyword(
	[Keyword_ID]							int			PRIMARY KEY		Identity(1,1),
	[Keyword_Name]							[nvarchar](100)				NOT NULL
	
 )
 GO
CREATE TABLE NotesToKeyword(
    [Notes_To_Keyword_ID]			    int			        PRIMARY KEY		Identity(1,1),
    [Notes_ID]				int		    FOREIGN KEY		    REFERENCES Note(Note_ID)	    NOT NULL,
    [Keyword_ID]			int			FOREIGN KEY		    REFERENCES Keyword(Keyword_ID)	NOT NULL,
)
GO
CREATE TABLE NotesToPerson(
        [Notes_To_Person_ID]			        int			PRIMARY KEY		    Identity(1,1),
        [Notes_ID]				                int		    FOREIGN KEY		    REFERENCES Note(Note_ID)	NOT NULL,
        [Person_ID]			                int			FOREIGN KEY		    REFERENCES People(People_ID)	NOT NULL
)
GO


CREATE TABLE LB_Entry(
    [LB_Entry_ID]                       int         PRIMARY KEY     IDENTITY(1,1)									NOT NULL,
    [LB_Entry_User]						[nvarchar](256)			FOREIGN KEY		REFERENCES AspNetUsers(Email)		    NOT NULL,
    [LB_Entry_Date_Time]				[datetime2](0)	DEFAULT(getdate())											NOT NULL,
    [LB_Entry_Text]				        [varchar](max)																NOT NULL,
    [LabBook_Project_ID]				int			FOREIGN KEY		REFERENCES Project(Project_ID)			NOT NULL,
	[SSMA_TimeStamp]					[timestamp]	
)
CREATE TABLE Comment(
    [Comment_ID]					int			PRIMARY KEY		IDENTITY(1,1)										NOT NULL,
	[Comment_Date_Time]				[datetime2](0)	DEFAULT(getdate())												NOT NULL,
	[Comment_Text]					[varchar](max)																	NOT NULL,
	[Comment_Notes_ID]				int		FOREIGN KEY		REFERENCES Note(Note_ID)								NOT NULL,
	[Comment_From_User]				[nvarchar](256)		FOREIGN KEY		REFERENCES AspNetUsers(Email)				NOT NULL,
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


