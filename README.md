# PetHappyWeHappy Webapp
This is a simple web application for pet users to obtain information based on their needs. The web application is linked to a database. 

## Prerequisites

1. First create the database PetHappyWeHappy in your DBMS by running the PetHappyWeHappy_backup.sql file.

2. Set up the flask container to run the web application following all sections before 'Flask Workshop' Python and Flask workshop written by [Luis Aguilar](https://github.com/munners17/python-flask-app.git")

3. Clone everything in the webapp folder into your webapp folder. 

4. Make sure your database is on and you are login to the flask container

5. Once everything ready, then you can negigate our web application using the following links or explore on your own in the home page

- http://127.0.0.1:5000/
- http://127.0.0.1:5000/breedingpartner?search0=F&search1=Long+Beach&search2=American+Shorthair&search3=0&search4=13
- http://127.0.0.1:5000/info?search=Austin
- http://127.0.0.1:5000/AllInsuranceInfo
- http://127.0.0.1:5000/InsuranceInfo?category=Dog
- http://127.0.0.1:5000/AllBreedInfo
- http://127.0.0.1:5000/BreedInfo?breed=Chihuahua
    

## Files in this Repo

* The weapp folder is for webb application 
* The PetHappyWeHappy_backup.sql is the sql file to create the database
* The Pet_Data_Tables contains all the tables inserted into the databases
