/*create database Final_Lab_Doamne_Ajuta*/
go
use Final_Lab_Doamne_Ajuta
go


CREATE TABLE Freelancer
(
freelancer_id int NOT NULL PRIMARY KEY,
user_name varchar(40),
password varchar(50),
description text
)

CREATE TABLE Certification
(
certification_id int NOT NULL PRIMARY KEY,
freelancer_id int,
certification_name varchar(100),
provider varchar(50),
description varchar(101),
certification_link text
)

CREATE TABLE Company
(
company_id int NOT NULL PRIMARY KEY,
company_name varchar(50),
company_location varchar(101)
)

CREATE TABLE Complexity
(
complexity_id int NOT NULL PRIMARY KEY,
complexity_description varchar(256)
)

CREATE TABLE Contract
(
contract_id int NOT NULL PRIMARY KEY,
proposal_id int,
freelancer_id int,
payment_ammount decimal(8,2),
start_time date,
end_time date
)



CREATE TABLE Skill
(
skill_id int NOT NULL PRIMARY KEY,
skill_name varchar(40)
)

CREATE TABLE Has_Skill
(
has_skill_id int NOT NULL PRIMARY KEY,
freelancer_id int,
skill_id int
)

CREATE TABLE Proposal
(
proposal_id int NOT NULL PRIMARY KEY,
complexity_id int,
skill_id int,
payment_type_id int,
company_id int,
description varchar(256)
)


CREATE TABLE Test_Result
(
test_result_id int NOT NULL PRIMARY KEY,
freelancer_id int,
test_id int,
test_result decimal(3,2),
show_on_profile int
)

CREATE TABLE Test
(
test_id int NOT NULL PRIMARY KEY,
test_description varchar(100)
)




CREATE TABLE payment_type
(
payment_type_id int NOT NULL PRIMARY KEY,
payment_description varchar(256),

)
