drop database if exists PetHappyWeHappy;
create database PetHappyWeHappy;
use PetHappyWeHappy;

# ________________________________________
DROP TABLE IF EXISTS `Users`;
CREATE TABLE Users (
         User_ID int(8) NOT NULL AUTO_INCREMENT,
         User_first_name VARCHAR(30) NOT NULL,
         User_last_name VARCHAR(30) NOT NULL,
         Street VARCHAR(40) NULL,
         City VARCHAR(10) NULL,
         State VARCHAR(2) NULL,
         Pet_owner boolean NOT NULL,
         Want_to_help_look_after_pets boolean NOT NULL,
         PRIMARY KEY (User_ID)
     )ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE 'C:/Users/admin/Desktop/257project/Pet-Social-Platform-App/Pet_Data_Tables/User.csv'
INTO TABLE Users
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(User_ID, User_first_name,User_last_name,Street,City,State,Pet_owner,Want_to_help_look_after_pets);

# ________________________________________
DROP TABLE IF EXISTS `Pet_Category`
CREATE TABLE Pet_Category (
         Pet_Category_ID int(2) NOT NULL AUTO_INCREMENT,
         Pet_Category_name VARCHAR(15) NOT NULL,
         PRIMARY KEY (Pet_Category_ID)
     )ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE 'C:/Users/admin/Desktop/257project/Pet-Social-Platform-App/Pet_Data_Tables/Pet_Category.csv'
INTO TABLE Pet_Category
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(Pet_Category_ID,Pet_Category_name);

# ________________________________________
DROP TABLE IF EXISTS `Insurance_Company`
CREATE TABLE Insurance_Company (
         Insurance_company_ID int(3) NOT NULL AUTO_INCREMENT,
         Insurance_company_Name VARCHAR(20) NOT NULL,
         Company_Link VARCHAR(50) NULL,
         PRIMARY KEY (Insurance_company_ID)
     )ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE 'C:/Users/admin/Desktop/257project/Pet-Social-Platform-App/Pet_Data_Tables/Insurance_Company.csv'
INTO TABLE Insurance_Company
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(Insurance_company_ID,Insurance_company_Name,Company_Link);

# ________________________________________
DROP TABLE IF EXISTS `Breed`;
CREATE TABLE Breed (
         Breed_ID int(4) NOT NULL AUTO_INCREMENT,
         Breed_name VARCHAR(20) NOT NULL,
         AltBreedName VARCHAR(10) NULL,
         PetGroup1 VARCHAR(10) NULL,
         PetGroup2 VARCHAR(10) NULL,
         MaleWtKg int(4) NULL,
         Fur_Length VARCHAR(10),
         Avg_life_time VARCHAR(8) NULL,
         Temperament VARCHAR(60) NULL,
         Pet_Category_ID INT(2) not null,
         PRIMARY KEY (Breed_ID),
         Foreign Key (Pet_Category_ID) REFERENCES Pet_Category(Pet_Category_ID)
         ON DELETE CASCADE
         ON UPDATE CASCADE
     )ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE 'C:/Users/admin/Desktop/257project/Pet-Social-Platform-App/Pet_Data_Tables/Breed.csv'
INTO TABLE Breed
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(Breed_ID,Breed_name,AltBreedName,PetGroup1,PetGroup2,MaleWtKg,Fur_Length,Avg_life_time,Temperament,Pet_Category_ID)

# ________________________________________
DROP TABLE IF EXISTS `Insurance_Record`;
CREATE TABLE Insurance_Record (
         IRecord_ID int(7) NOT NULL AUTO_INCREMENT,
         Insurance_company_ID int(5) NOT NULL,
         Pet_ID int(8) NOT NULL,
         Cost_per_year INT NOT NULL,
         Date_Start DATE,
         PRIMARY KEY (IRecord_ID),
         Foreign Key (Insurance_company_ID) REFERENCES Insurance_Company(Insurance_company_ID),
         Foreign Key (Pet_ID) REFERENCES Pet(Pet_ID)
         ON DELETE CASCADE
         ON UPDATE CASCADE
     )ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE 'C:/Users/admin/Desktop/257project/Pet-Social-Platform-App/Pet_Data_Tables/Insurance_Record.csv'
INTO TABLE Insurance_Record
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(IRecord_ID,Insurance_company_ID,Pet_ID,Cost_per_year,Date_Start);

# ________________________________________
DROP TABLE IF EXISTS `Pet`
CREATE TABLE Pet (
         Pet_ID int(8) NOT NULL AUTO_INCREMENT,
         User_ID int(8),
         Pet_F_Name varCHAR(40),
         Pet_L_Name varCHAR(40),
         Data_of_birth Date,
         Gender varCHAR(1),
         Breed_ID int(4),
         Want_friend Binary,
         Want_breeding Binary,
         Friendly Binary,
         Quiet Binary,
         Height_inch DOUBLE,
         Weight_lb DOUBLE,
         Length_inch DOUBLE null,
         Coat_Color varChar(30),
         PRIMARY KEY (Pet_ID),
         Foreign Key (User_ID) REFERENCES Users(User_ID),
         Foreign Key (Breed_ID) REFERENCES Breed(Breed_ID)
         ON DELETE CASCADE
         ON UPDATE CASCADE
     )ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE 'C:/Users/admin/Desktop/257project/Pet-Social-Platform-App/Pet_Data_Tables/Pet.csv'
INTO TABLE Pet
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(Pet_ID,User_ID,Pet_F_Name,Pet_L_Name,Data_of_birth,Gender,Breed_ID,Want_friend,Want_breeding,Friendly,Quiet,Height_inch,Weight_lb,Length_inch,Coat_Color)
;

# ________________________________________
DROP TABLE IF EXISTS `User_Pet_Accomendation_Preference`;
CREATE TABLE User_Pet_Accomendation_Preference(
         User_ID INT(8) NOT NULL AUTO_INCREMENT,
         Number_of_pet_willing_to_take int(2),
         Fst_genus_willing_to_take varchar(10),
         Scd_genus_willing_to_take varchar(10),
         Trd_genus_willing_to_take varchar(10),
         Extra_preference_details varchar(60),
         PRIMARY KEY (User_ID)
     )ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE 'C:/Users/admin/Desktop/257project/Pet-Social-Platform-App/Pet_Data_Tables/User_Pet_Accomendation_Preference.csv'
INTO TABLE User_Pet_Accomendation_Preference
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
# ________________________________________

DROP TABLE if EXISTS `Grooming_Services`;
CREATE TABLE Grooming_Services(
         GService_ID INT(2) NOT NULL AUTO_INCREMENT,
         Service_name VARCHAR(40) NOT NULL,
         PRIMARY KEY (GService_ID)
     )ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Grooming_Services.csv'
INTO TABLE Grooming_Services
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE  IF EXISTS `Groomer`;
CREATE TABLE Groomer (
    Groomer_ID int(3) NOT NULL AUTO_INCREMENT,
    Groomer_name varchar(40) NOT NULL,
    City VARCHAR(20) NOT NULL ,
    State VARCHAR(2) NOT NULL,
    PRIMARY KEY (Groomer_ID)
)ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Groomer.csv'
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
    FOREIGN KEY (GService_ID) REFERENCES Grooming_Services(GService_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Groomer_ID) REFERENCES Groomer(Groomer_ID) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;


LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Grooming_Record.csv'
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
)ENGINE=INNODB DEFAULT CHARSET=latin1;


LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Pet_Training_Type.csv'
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
)ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Pet_Training_Agent.csv'
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
    FOREIGN KEY (Pet_ID) references Pet(Pet_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Training_ID) REFERENCES Pet_Training_Type(Training_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Agent_ID) REFERENCES Pet_Training_Agent(Agent_ID) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;


LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Pet_Training_Records.csv'
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
    PRIMARY KEY (Match_ID),
    FOREIGN KEY (Pet_ID) references Pet(Pet_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Friend_ID) references Pet(Pet_ID) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;


LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Friend_Matching_List.csv'
INTO TABLE Friend_Match_List
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


# ****************************************************************#

DROP TABLE IF EXISTS Breeding_Record;
CREATE TABLE Breeding_Record (
    BRecord_ID INT(7) NOT NULL AUTO_INCREMENT,
    F_Pet_ID INT(8),
    M_Pet_ID INT(8),
    Appearance_inherited_or_not BOOLEAN,
    Breeding_date DATE,
    Cost FLOAT,
    PRIMARY KEY (BRecord_ID),
    FOREIGN KEY (F_Pet_ID) REFERENCES Pet(Pet_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (M_Pet_ID) REFERENCES Pet(Pet_ID)  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Breeding_Record.csv'
INTO TABLE Breeding_Record
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS Foster_Care_Record;
CREATE TABLE Foster_Care_Record (
    Request_ID INT(8) NOT NULL AUTO_INCREMENT,
    Pet_ID INT(8),
    User_ID INT(8),
    Request_date DATE,
    Date_of_travle DATE,
    Date_of_return DATE,
    PRIMARY KEY (Request_ID),
    FOREIGN KEY (Pet_ID) REFERENCES Pet(Pet_ID)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Foster_Care_Record.csv'
INTO TABLE Foster_Care_Record
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


DROP TABLE IF EXISTS Veterinary_Company;
CREATE TABLE Veterinary_Company (
    Veterinary_ID INT NOT NULL AUTO_INCREMENT,
    Veterinary_Name VARCHAR(100),
    City VARCHAR(20),
    State VARCHAR(2),
    PRIMARY KEY (Veterinary_ID)
)ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Veterinary_Company.csv'
INTO TABLE Veterinary_Company
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS Purpose_of_Visit;
CREATE TABLE Purpose_of_Visit (
    Purpose_ID INT(3) NOT NULL AUTO_INCREMENT,
    Purpose_discription VARCHAR(100),
    PRIMARY KEY (Purpose_ID)
)ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Purpose_of_Visit.csv'
INTO TABLE Purpose_of_Visit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS Medical_History;
CREATE TABLE Medical_History (
    MRecord_ID INT(9) NOT NULL AUTO_INCREMENT,
    Pet_ID INT(8),
    Veterinary_ID INT,
    Date_of_visit DATE,
    Purpose_ID INT(3),
    PRIMARY KEY (MRecord_ID),
    FOREIGN KEY (Pet_ID) REFERENCES Pet(Pet_ID)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Veterinary_ID) REFERENCES Veterinary_Company(Veterinary_ID)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Purpose_ID) REFERENCES Purpose_of_Visit(Purpose_ID)  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE '/Users/CHELSEY/Documents/Github/info257-gitlcone/Pet-Social-Platform-App/Pet_Data_Tables/Medical_History.csv'
INTO TABLE Medical_History
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

