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

