--tables are -> Test - one PK
--			 -> Test_Result - one PK, Two FK's
--			 -> Freelancer - one PK

--Tb = Test
sp_helpindex Test
GO
--Ta = Freelancer
sp_helpindex Freelancer
GO
--Tc = Test_Result
sp_helpindex Test_Result
GO

--a
--clustered index scan
SELECT * FROM Freelancer
--0.05
--clustered index seek
SELECT * FROM Freelancer WHERE Freelancer.freelancer_id=5000
--0.003
--nonclustered index scan
--CREATE NONCLUSTERED INDEX index_freelancer_password ON Freelancer(password)
SELECT password from Freelancer
--0.01
--nonclustered index seek
SELECT password from Freelancer WHERE password='12345'
--0.003
--key lookup -> 
SELECT password, user_name FROM Freelancer WHERE Freelancer.password='1245'
--b
--query on Test with WHERE

SELECT * FROM Test
Select * FROM Test WHERE Test.test_id=7432
CREATE NONCLUSTERED INDEX index_test_testID ON Test(test_id)
Select test_id FROM Test WHERE Test.test_id=7432
GO
--c
-- views that joins at least 2 tables
-- check if indexes are useful
-- reasses existing indexes
-- examine cardinality of the tables
CREATE OR ALTER VIEW ViewTwoTables
AS
SELECT F.freelancer_id,F.user_name, T.test_id,T.test_result
FROM Freelancer F
INNER JOIN Test_Result T
ON F.freelancer_id = T.freelancer_id
GO

SELECT * FROM ViewTwoTables

SELECT ServerProperty('ProductVersion');  
GO  


  ALTER DATABASE Final_Lab_Doamne_Ajuta  
SET COMPATIBILITY_LEVEL = 130;  
GO  

SELECT d.name, d.compatibility_level  
FROM sys.databases AS d  
WHERE d.name = 'Final_Lab_Doamne_Ajuta';  
GO  

ALTER DATABASE SCOPED CONFIGURATION 
SET LEGACY_CARDINALITY_ESTIMATION = ON;  
GO  
  
SELECT name, value  
FROM sys.database_scoped_configurations  
WHERE name = 'LEGACY_CARDINALITY_ESTIMATION';  
GO
--SELECT * FROM Test_Result
CREATE NONCLUSTERED INDEX index_testResult_testResult ON Test_Result(test_result)
SELECT test_result from Test_Result WHERE test_result>0.5
OPTION (USE HINT ('FORCE_LEGACY_CARDINALITY_ESTIMATION'))