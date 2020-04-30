# drop database if exists PetHappyWeHappy;
# create database PetHappyWeHappy;
use PetHappyWeHappy;

DROP TABLE IF EXISTS `PET`
CREATE TABLE PET (
         Pet_ID int(10) NOT NULL AUTO_INCREMENT,
         User_ID int(10) NOT NULL,
         Pet_Name VARCHAR(25) NULL,
         DOB DATE NULL,
         Gender VARCHAR(2) NULL,
         PRIMARY KEY (Pet_ID)
     )ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE 'C:/Users/admin/Desktop/test.csv'
INTO TABLE PET
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(Pet_ID,User_ID,Pet_Name,DOB,Gender);



DROP TABLE if EXISTS `Grooming_Services`;
CREATE TABLE Grooming_Services(
         GService_ID INT(2) NOT NULL AUTO_INCREMENT,
         Service_name VARCHAR(40) NOT NULL,
         PRIMARY KEY (GService_ID)
     );

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Grooming_Services.csv'
INTO TABLE Grooming_Services
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE  IF EXISTS 'Groomer';
CREATE TABLE Groomer (
    Groomer_ID int(3) NOT NULL AUTO_INCREMENT,
    Groomer_name varchar(40) NOT NULL,
    City VARCHAR(20) NOT NULL ,
    State VARCHAR(2) NOT NULL,
    PRIMARY KEY (Groomer_ID)
);

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Desktop/SPRING 2020/INFO 257/PETSOCIALPLATFORM/data/Groomer.csv'
INTO TABLE Groomer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS `Grooming_Record`;
CREATE TABLE Grooming_Record (
    GRecord_ID int(7) NOT NULL AUTO_INCREMENT,
    Pet_ID int(8) NOT NULL,
    Groomer_ID int(3),
    Date_visit DATE,
    GService_ID int(2) NOT NULL,
    Price int(3),
    Service_time int(3),
    PRIMARY KEY (GRecord_ID),
    FOREIGN KEY (GService_ID) REFERENCES Grooming_Services(GService_ID),
    FOREIGN KEY (Groomer_ID) REFERENCES Groomer(Groomer_ID)
);


LOAD DATA LOCAL INFILE '/Users/CHELSEY/Desktop/SPRING 2020/INFO 257/PETSOCIALPLATFORM/data/Grooming_Record.csv'
INTO TABLE Grooming_Record
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


DROP TABLE  IF EXISTS `Pet_Training_Type`;
CREATE TABLE Pet_Training_Type (
    Training_ID INT(2) NOT NULL AUTO_INCREMENT,
    Training_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (Training_ID)
;)


LOAD DATA LOCAL INFILE '/Users/CHELSEY/Desktop/SPRING 2020/INFO 257/PETSOCIALPLATFORM/data/Pet_Training_Type.csv'
INTO TABLE Pet_Training_Type
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS `Pet_Training_Agent`;
CREATE TABLE Pet_Training_Agent (
    Agent_ID INT(3) NOT NULL AUTO_INCREMENT,
    Agent_name VARCHAR(100) NOT NULL,
    City VARCHAR(20) NOT NULL ,
    State VARCHAR(2) NOT NULL,
    PRIMARY KEY (Agent_ID)
);

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Desktop/SPRING 2020/INFO 257/PETSOCIALPLATFORM/data/Pet_Training_Agent.csv'
INTO TABLE Pet_Training_Agent
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE  IF EXISTS `Pet_Training_Record`;
CREATE TABLE Pet_Training_Record (
    TRecord_ID INT(7) NOT NULL,
    Pet_ID INT(8) NOT NULL ,
    Training_ID INT(2) NOT NULL,
    Agent_ID INT (3) NOT NULL,
    Training_time INT(2),
    Training_cost INT(4),
    PRIMARY KEY (TRecord_ID),
#     FOREIGN KEY (Pet_ID) references Pet(Pet_ID)
    FOREIGN KEY (Training_ID) REFERENCES Pet_Training_Type(Training_ID),
    FOREIGN KEY (Agent_ID) REFERENCES Pet_Training_Agent(Agent_ID)
);


LOAD DATA LOCAL INFILE '/Users/CHELSEY/Desktop/SPRING 2020/INFO 257/PETSOCIALPLATFORM/data/Pet_Training_Records.csv'
INTO TABLE Pet_Training_Record
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


DROP TABLE IF EXISTS `Friend_Match_List`;
CREATE TABLE Friend_Match_List
(
    Match_ID INT (5) NOT NULL AUTO_INCREMENT,
    Pet_ID INT(8) NOT NULL,
    Friend_ID INT(8) NOT NULL,
    Like_this_friend BOOLEAN NOT NULL,
    PRIMARY KEY (Match_ID)
#     FOREIGN KEY Pet_ID references Pet(Pet_ID),
#     FOREIGN KEY Friend_ID references Pet(Pet_ID),
);


LOAD DATA LOCAL INFILE '/Users/CHELSEY/Desktop/SPRING 2020/INFO 257/PETSOCIALPLATFORM/data/Friend_Matching_List.csv'
INTO TABLE Friend_Match_List
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
