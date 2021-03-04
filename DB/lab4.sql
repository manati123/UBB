SELECT * FROM Tests
SELECT * FROM Tables
SELECT * FROM TestTables
SELECT * FROM Views 
SELECT * FROM TestViews 
SELECT * FROM TestRuns
SELECT * FROM TestRunTables 
SELECT * FROM TestRunViews
GO
/*
delete from TestViews
delete from Views
delete from Tests
delete from TestTables
delete from  Tables
delete from  TestRunViews
delete from  TestRuns
*/

CREATE OR ALTER VIEW ViewOneTable
AS
SELECT * FROM Freelancer
GO

CREATE OR ALTER VIEW ViewTwoTables
AS
SELECT F.freelancer_id,F.user_name, C.certification_id, C.certification_name
FROM Freelancer F
INNER JOIN Certification C
ON F.freelancer_id = C.freelancer_id
GO

CREATE OR ALTER VIEW ViewGroupBy
AS
SELECT COUNT(F.freelancer_id) as NoOfFreelancers, F.freelancer_id
FROM Freelancer F
GROUP BY F.freelancer_id
HAVING F.freelancer_id IN (SELECT C.certification_id FROM Certification C)
GO

CREATE OR ALTER PROCEDURE delete_table
	@table_name VARCHAR(30)
AS
BEGIN
	IF @table_name='Test_result'
	BEGIN
	DELETE FROM Test_Result
	END
	
	ELSE IF @table_name='Freelancer'
	BEGIN
	DELETE FROM Freelancer
	END
	
	ELSE IF @table_name='Test'
	BEGIN
	DELETE FROM Test
	END

	ELSE
	BEGIN
	PRINT('Table unknown ') 
	END
END
GO

CREATE OR ALTER PROCEDURE insert_tabLe
	@noOfRows INT,
	@tableName VARCHAR(30)
AS
BEGIN
	DECLARE @id INT
	IF @tableName='Test'
	BEGIN
		SET @id=@noOfRows
		WHILE @noOfRows > 0
		BEGIN
			INSERT INTO Test(test_id,test_description) VALUES (@id,'Lorem ipsum')

			SET @id=@id+1
			SET @noOfRows=@noOfRows-1
		END
	END
	
	ELSE IF @tableName='Freelancer'
	BEGIN
	SET @id=@noOfRows
		WHILE @noOfRows > 0
		BEGIN
		
			INSERT INTO Freelancer(freelancer_id,user_name,password,description,nickname) VALUES (@id,'Gion Coca','1245','lorem ipsum','sandu ciorba')

			SET @id=@id+1
			SET @noOfRows=@noOfRows-1
		END
	END
	
	ELSE IF @tableName='Test_Result'
	BEGIN
		SET @id=@noOfRows
		DECLARE @fk1 INT
		SET @fk1=(SELECT TOP 1 freelancer_id from Freelancer)

		DECLARE @fk2 INT
		SET @fk2=(SELECT TOP 1 test_id FROM Test)

		WHILE @noOfRows > 0
		BEGIN
			DECLARE @randVar decimal(3,2)
			SET @randVar = CEILING(RAND() * 9) * 0.1
			INSERT INTO Test_Result(test_result_id,freelancer_id,test_id,test_result,show_on_profile)  VALUES(@id,@id,@id,@randVar,1)
		
			SET @id=@id+1
			SET @noOfRows=@noOfRows-1
		END
	END

	ELSE
	BEGIN
	PRINT('Table unknown ') 
	END

END
GO
CREATE OR ALTER PROCEDURE select_view
	@view_name VARCHAR(30)
AS
BEGIN
	IF @view_name='ViewOneTable'
	BEGIN 
		SELECT * FROM ViewOneTable
	END

	ELSE IF @view_name='ViewTwoTables'
	BEGIN 
		SELECT * FROM ViewTwoTables
	END

	ELSE IF @view_name='ViewGroupBy'
	BEGIN 
		SELECT * FROM ViewGroupBy
	END

	ELSE
	BEGIN 
		PRINT('Not a valid view name')
		RETURN 1
	END
END
GO

INSERT INTO Tables Values('Freelancer'),('Test_Result'),('Test')
INSERT INTO Views VALUES ('ViewOneTable'),('ViewTwoTables'),('ViewGroupBy')
INSERT INTO Tests VALUES ('test_10'),('test_100'),('test_1000'),('test_5000')
INSERT INTO TestViews(TestID,ViewID) VALUES (11,7)
INSERT INTO TestViews(TestID,ViewID) VALUES (11,8)
INSERT INTO TestViews(TestID,ViewID) VALUES (11,9)
INSERT INTO TestViews(TestID,ViewID) VALUES (12,7)
INSERT INTO TestViews(TestID,ViewID) VALUES (12,8)
INSERT INTO TestViews(TestID,ViewID) VALUES (12,9)
INSERT INTO TestViews(TestID,ViewID) VALUES (13,7)
INSERT INTO TestViews(TestID,ViewID) VALUES (13,8)
INSERT INTO TestViews(TestID,ViewID) VALUES (13,9)
INSERT INTO TestViews(TestID,ViewID) VALUES (14,7)
INSERT INTO TestViews(TestID,ViewID) VALUES (14,8)
INSERT INTO TestViews(TestID,ViewID) VALUES (14,9)

select * from tables
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (11,4,10,2)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (11,5,10,1)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (11,6,10,3)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (12,4,100,2)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (12,5,100,1)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (12,6,100,3)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (13,4,1000,2)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (13,5,1000,1)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (13,6,1000,3)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (14,4,5000,2)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (14,5,5000,1)
INSERT INTO TestTables(TestId, TableID, NoOfRows, Position) VALUES (14,6,5000,3)
GO
/*
CREATE OR ALTER PROCEDURE main
	@testID INT
AS
BEGIN
	INSERT INTO TestRuns VALUES ((SELECT Name FROM Tests WHERE TestID=@testID),GETDATE(),GETDATE())
	DECLARE @testRunID INT
	SET @testRunID=(SELECT MAX(TestRunID) FROM TestRuns)

	DECLARE @noOfRows INT
	DECLARE @tableID INT
	DECLARE @tableName VARCHAR(30)
	DECLARE @startAt DATETIME
	DECLARE @endAt DATETIME
	DECLARE @viewID INT
	DECLARE @viewName VARCHAR(30)

	DECLARE testDeleteCursor CURSOR FOR
	SELECT TableID,NoOfRows
	FROM TestTables
	WHERE TestID=@testID
	ORDER BY Position DESC

	OPEN testDeleteCursor

	FETCH NEXT 
	FROM testDeleteCursor
	INTO @tableID,@noOfRows

	WHILE @@FETCH_STATUS=0
	BEGIN
		SET @tableName=(SELECT Name FROM Tables WHERE TableID=@tableID)

		EXEC delete_table @tableName

		FETCH NEXT 
		FROM testDeleteCursor
		INTO @tableID,@noOfRows
	END

	CLOSE testDeleteCursor
	DEALLOCATE testDeleteCursor

	DECLARE testInsertCursor CURSOR FOR
	SELECT TableID,NoOfRows
	FROM TestTables
	WHERE TestID=@testID
	ORDER BY Position ASC

	OPEN testInsertCursor

	FETCH NEXT 
	FROM testInsertCursor
	INTO @tableID,@noOfRows

	WHILE @@FETCH_STATUS=0
	BEGIN
		SET @tableName=(SELECT Name FROM Tables WHERE TableID=@tableID)

		SET @startAt=GETDATE()
		EXEC insert_tabLe @noOfRows,@tableName
		SET @endAt=GETDATE()

		INSERT INTO TestRunTables VALUES (@testRunID,@tableID,@startAt,@endAt)

		FETCH NEXT 
		FROM testInsertCursor
		INTO @tableID,@noOfRows
	END

	CLOSE testInsertCursor
	DEALLOCATE testInsertCursor

	DECLARE testViewCursor CURSOR FOR
	SELECT ViewID
	FROM TestViews
	WHERE TestID=@testID

	OPEN testViewCursor

	FETCH NEXT 
	FROM testViewCursor
	INTO @viewID

	WHILE @@FETCH_STATUS=0
	BEGIN
		SET @viewName=(SELECT Name FROM Views WHERE ViewID=@viewID)

		SET @startAt=GETDATE()
		EXEC select_view @viewName
		SET @endAt=GETDATE()

		INSERT INTO TestRunViews VALUES (@testRunID,@viewID,@startAt,@endAt)

		FETCH NEXT 
		FROM testViewCursor
		INTO @viewID
	END

	CLOSE testViewCursor
	DEALLOCATE testViewCursor

	UPDATE TestRuns
	SET EndAt=GETDATE()
	WHERE TestRunID=@testRunID

END
GO
*/

CREATE OR ALTER PROCEDURE mainTwo
	@testID INT
AS
BEGIN
	DECLARE @startAtTestRun DATETIME
	DECLARE @endedAtTestRun DATETIME
	DECLARE @description varchar(30)
	DECLARE @testRunID INT
	SET @startAtTestRun=GETDATE()
	SET @testRunID=(SELECT MAX(TestRunID) FROM TestRuns)


	DECLARE @noOfRows INT
	DECLARE @tableID INT
	DECLARE @tableName VARCHAR(30)
	DECLARE @startAt DATETIME
	DECLARE @endAt DATETIME
	DECLARE @viewID INT
	DECLARE @viewName VARCHAR(30)

	DECLARE testDeleteCursor CURSOR FOR SELECT TableID, NoOfRows FROM TestTables WHERE TestID=@testID ORDER BY Position ASC
	
	OPEN testDeleteCursor
	FETCH NEXT
	FROM testDeleteCursor
	INTO @tableID,@noOfRows

	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @tableName=(SELECT Name FROM Tables WHERE TableID=@tableID)
			EXEC delete_table @tableName

		
		FETCH NEXT
		FROM testDeleteCursor
		INTO @tableID,@noOfRows
		END

	CLOSE testDeleteCursor
	DEALLOCATE testDeleteCursor
	DECLARE testInsertCursor CURSOR FOR SELECT TableID, NoOfRows FROM TestTables WHERE TestID=@testID ORDER BY Position DESC

	OPEN testInsertCursor

	FETCH NEXT
	FROM testInsertCursor
	INTO @tableID, @noOfRows

	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @tableName=(SELECT Name FROM Tables WHERE TableID=@tableID)
			--PRINT 'sdfsdfdsf'
			SET @startAt=GETDATE()
			EXEC insert_tabLe @noOfRows,@tableName
			SET @endAt=GETDATE()

			INSERT INTO TestRunTables VALUES (@testRunID,@tableID,@startAt,@endAt)
			
			FETCH NEXT
			FROM testInsertCursor
			INTO @tableID,@noOfRows
		END
	CLOSE testInsertCursor
	DEALLOCATE testInsertCursor

	DECLARE testViewCursor CURSOR FOR SELECT ViewID FROM TestViews WHERE TestID=@testID

	OPEN testViewCursor

	FETCH NEXT
	FROM testViewCursor
	INTO @viewID

	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @viewName=(SELECT Name FROM Views WHERE ViewID=@viewID)
			SET @startAt=GETDATE()
			EXEC select_view @viewName
			SET @endAt=GETDATE()

			INSERT INTO TestRunViews VALUES (@testRunID, @viewID, @startAt, @endAt)

			FETCH NEXT
			FROM testViewCursor
			INTO @viewID
		END

		CLOSE testViewCursor
		DEALLOCATE testViewCursor

		SET @endedAtTestRun=GETDATE()

			INSERT INTO TestRuns VALUES ((SELECT Name FROM Tests WHERE TestID=@testID),@startAtTestRun,@endedAtTestRun)


END
GO

--EXEC main 3
EXEC mainTwo 11
EXEC mainTwo 12
EXEC mainTwo 13
EXEC mainTwo 14
select * from TestRuns
exec insert_tabLe 5000,Freelancer
exec insert_tabLe 5000,Test
exec insert_tabLe 5000,Test_Result
exec delete_table Test_Result
EXEC delete_table Freelancer
EXEC delete_table Test
exec delete_table Freelancer
select * from Freelancer
--for the love of God IT WORKS