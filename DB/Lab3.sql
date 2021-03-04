use Final_Lab_Doamne_Ajuta
GO

/*
a. modify the type of a column;
*/
CREATE PROCEDURE modifyVarChar_to_text_freelancerUserName
AS
	ALTER TABLE Freelancer
	ALTER COLUMN user_name text
GO

CREATE PROCEDURE text_to_varchar_freelancerUserName
AS
	ALTER TABLE Freelancer
	ALTER COLUMN user_name varchar(40)
GO



/*
b. add / remove a column;
*/
CREATE PROCEDURE add_nicknameColumn_varchar
AS
	ALTER TABLE Freelancer
	ADD nickname varchar(50)
GO

CREATE PROCEDURE delete_nicknameColumn_varchar
AS
	ALTER TABLE Freelancer
	DROP COLUMN nickname
GO



/*
c. add / remove a DEFAULT constraint;
*/
CREATE PROCEDURE addDefaultConstraint
AS
	ALTER TABLE Freelancer
	ADD CONSTRAINT df_password
	DEFAULT '1234' FOR password
GO

CREATE PROCEDURE removeDefaultConstraint
AS
	ALTER TABLE Freelancer
	DROP CONSTRAINT df_password
	
GO



/*
d. add / remove a primary key;
*/
CREATE TABLE sparseTable(
	PRIMARYKEY INT,
	PRIMARY KEY(PRIMARYKEY)
)
GO

CREATE PROCEDURE removesparseTablePrimaryKey
AS
	ALTER TABLE sparseTable
	DROP CONSTRAINT PK__sparseKey
GO


CREATE PROCEDURE addsparseTablePrimaryKey
AS
	ALTER TABLE sparseTable
	ADD CONSTRAINT PK__sparseKey PRIMARY KEY(PRIMARYKEY)
GO

/*
e. add / remove a candidate key;
*/
CREATE PROCEDURE addHasSkillCandidateKeyPaymentDescription
AS
	ALTER TABLE payment_type
	ADD CONSTRAINT CK_payment_description UNIQUE (payment_description)
GO
exec addHasSkillCandidateKeyPaymentDescription
exec removeHasSkillCandidateKey
CREATE PROCEDURE removeHasSkillCandidateKey
AS
	ALTER TABLE payment_type
	DROP CONSTRAINT CK_payment_description
GO



/*
f. add / remove a foreign key;
*/
CREATE PROCEDURE removeForeignKeyFreelancerIdTestResult
AS
	ALTER TABLE Certification
	DROP CONSTRAINT FK__Certifica__freel__47DBAE45
GO

CREATE PROCEDURE addForeignKeyFreelancerIdTestResult
AS
	ALTER TABLE Certification
	ADD CONSTRAINT FK__Certifica__freel__47DBAE45
	FOREIGN KEY (freelancer_id) REFERENCES Freelancer(freelancer_id) 
GO

EXEC addForeignKeyFreelancerIdTestResult
EXEC removeForeignKeyFreelancerIdTestResult
/*
g. create / drop a table.
*/

CREATE PROCEDURE createFreelancerNicknamesTable
AS
	CREATE TABLE FreelancerNicknames(id TINYINT IDENTITY (1,1), nickname VARCHAR(50), PRIMARY KEY(id))
GO
CREATE PROCEDURE removeFreelancerNicknamesTable
AS
	DROP TABLE FreelancerNicknames
GO


--- Create a table that holds versions of the database. Changes upon changes of the DB -> verion = number

CREATE TABLE VersionTable(
version TINYINT 
PRIMARY KEY (version))

INSERT INTO VersionTable(version) VALUES (7)

UPDATE VersionTable
SET version = 0

SELECT*
FROM VersionTable


CREATE TABLE DBProcedures(
version TINYINT IDENTITY(1,1),
Proced VARCHAR(80),
ReverseProced VARCHAR(80))

SELECT *
FROM DBProcedures

INSERT INTO DBProcedures(Proced, ReverseProced) 
		VALUES ('modifyVarChar_to_text_freelancerUserName','text_to_varchar_freelancerUserName'),
			   ('add_nicknameColumn_varchar','delete_nicknameColumn_varchar'),
			   ('addDefaultConstraint','removeDefaultConstraint'),
			   ('removesparseTablePrimaryKey','addsparseTablePrimaryKey'),
			   ('addHasSkillCandidateKeyPaymentDescription','removeHasSkillCandidateKey'),
			   ('addForeignKeyFreelancerIdTestResult','removeForeignKeyFreelancerIdTestResult'),
			   ('createFreelancerNicknamesTable','removeFreelancerNicknamesTable')
GO
SELECT * from FreelancerNicknames
EXEC changeDBVersion 2

SELECT * 
FROM FreelancerNicknames

CREATE PROCEDURE changeVersion 
	@updatedVersion INT
AS
	UPDATE VersionTable
	SET version = @updatedVersion
GO
SELECT *
FROM VersionTable
GO
CREATE PROCEDURE changeDBVersion @version INT
AS
	DECLARE @currentVersion INT
	SET @currentVersion = (SELECT version FROM VersionTable)
	IF (@currentVersion > @version)
		WHILE (@currentVersion > @version)
		BEGIN
			PRINT @currentVersion
			DECLARE @reverseCommand VARCHAR(80) 
			SET @reverseCommand = (SELECT ReverseProced FROM DBProcedures WHERE @currentVersion = version)
			EXEC @reverseCommand
			SET @currentVersion = @currentVersion - 1
		END
	ELSE IF (@currentVersion < @version)
		WHILE (@currentVersion < @version)
		BEGIN
			SET @currentVersion = @currentVersion + 1
			PRINT @currentVersion
			DECLARE @command VARCHAR(80) 
			SET @command = (SELECT Proced FROM DBProcedures WHERE version = @currentVersion)
			
				EXEC @command
				PRINT @command
		END
	EXEC changeVersion @currentVersion
GO
exec addForeignKeyFreelancerIdTestResult


--DROP PROCEDURE changeDBVersion