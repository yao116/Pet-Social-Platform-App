from flask import Flask,render_template, request, redirect
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:mypass@mariadb-diveshop.db-network/PetHappyWeHappy'
# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:mypass@mariadb-diveshop.db-network/Diveshop'
db = SQLAlchemy(app) 

@app.route("/database")
def datab():
   result = db.engine.execute("SELECT DATABASE()")
   names = [row[0] for row in result]
   return names[0] 
 
# @app.route("/")
# def index():
#    return render_template('index.html')

@app.route("/")
def index():
   result = db.engine.execute("select DISTINCT(Breed_name) from Breed")
   result2 = db.engine.execute("select DISTINCT(Pet_Category_name) from Pet_Category")
   result3 = db.engine.execute("select DISTINCT(City) from Groomer")
   accs = []
   accs2 = []
   accs3 = []

   for row in result:
       name = {}
       name["Breed_name"] = row[0]
       accs.append(name)
   for row in result2:
       name = {}
       name["Pet_Category_name"] = row[0]
       accs2.append(name)
   for row in result3:
       name = {}
       name["City"] = row[0]
       accs3.append(name)


   result8 = db.engine.execute("select DISTINCT(Gender) from Pet")
   accs8 = []
   for row in result8:
    name = {}
    name["Gender"] = row[0]
    accs8.append(name)

   result9 = db.engine.execute("select DISTINCT(City) from Groomer")
   accs9 = []
   for row in result9:
    name = {}
    name["City"] = row[0]
    accs9.append(name)

   result10 = db.engine.execute("select DISTINCT(Breed_name) from Breed")
   accs10 = []
   for row in result10:
    name = {}
    name["Breed"] = row[0]
    accs10.append(name)
  
   accs11 = []
   for i in range(21):
    accs11.append(i)
   result11 = accs11

   accs12 = []
   for i in range(1,22):
    accs12.append(i)
   result12 = accs12


   return render_template("index.html", data=accs, data2 = accs2, data3 = accs3, data8=accs8,data9=accs9,data10=accs10,data11=accs11,data12=accs12)

 # ************************Chelsey*************************************
@app.route("/info", methods=["POST", "GET"])

@app.route("/info")
def groomer():
    Search = request.args.get('search')

    result = db.engine.execute("SELECT G.Groomer_name as top_groomers, ROUND(AVG(GR.Service_time),0) as AVG_TIME_SPENT, ROUND(AVG(GR.Price),0) AS AVG_COST_SPENT, count(GR.GRecord_ID) as ctn FROM  Grooming_Record GR, Groomer G, Pet P, Users U WHERE GR.Groomer_ID = G.Groomer_ID AND GR.Pet_ID = P.Pet_ID AND P.User_ID = U.User_ID AND G.City =%s  group by G.Groomer_ID order by ctn DESC limit 3",Search)

    result2 = db.engine.execute("SELECT TA.Agent_name as top_trainers, round(AVG(TR.Training_time),0) AS AVG_TRAINING_WEEK_TIME, round(AVG(Training_cost),0) AS AVG_TRAIN_COST, count(TR.TRecord_ID) as ctn FROM Pet_Training_Record TR,Pet_Training_Agent TA, Pet P, Users U WHERE TR.Agent_ID=TA.Agent_ID AND TR.Pet_ID = P.Pet_ID AND P.User_ID = U.User_ID AND TA.City = %s group by TA.Agent_ID order by ctn desc, TA.Agent_name ASC LIMIT 3",Search)

    result3 = db.engine.execute("SELECT VC.Veterinary_Name as top_vets,count(MH.MRecord_ID) as ctn FROM Veterinary_Company VC, Medical_History MH, Pet P, Users U WHERE MH.Veterinary_ID=VC.Veterinary_ID AND MH.Pet_ID = P.Pet_ID AND P.User_ID = U.User_ID AND VC.City = %s group by VC.Veterinary_ID order by 2 DESC limit 3", Search)

    names  = []
    names2 = []
    names3 = []
    
    for row in result:
        name = {}
        name["top_groomers"] = row[0]
        name["AVG_TIME_SPENT"] = row[1]
        name["AVG_COST_SPENT"] = row[2]
        names.append(name)

    for row in result2:
        name = {}
        name["top_trainers"] = row[0]
        name["AVG_TRAINING_WEEK_TIME"] = row[1]
        name["AVG_TRAIN_COST"] = row[2]

        names2.append(name)

    for row in result3:
        name = {}
        name["top_vets"] = row[0]

        names3.append(name)

    return render_template('show_info.html',groomers=names
      ,trainers=names2, vets=names3)
      
# ********************************Namcy****************************

@app.route("/AllBreedInfo", methods=["POST"])
def dest():
    result = db.engine.execute("select * from Breed")
    result2 = db.engine.execute("select b.Breed_name, GS.Service_name, round(avg(GR.Price),1), max(GR.Price), min(GR.Price) from Breed b join Pet p on b.Breed_ID = p.Breed_ID join Grooming_Record GR on p.Pet_ID = GR.Pet_ID join Grooming_Services GS on GR.GService_ID = GS.GService_ID group by b.Breed_ID, GR.GService_ID")
    result3 = db.engine.execute("select b2.Breed_name, P2.Breed_ID, MH.Purpose_ID, PoV.Purpose_discription, count(P2.Breed_ID) as count, dense_rank() over (partition by Breed_ID order by count(P2.Breed_ID) desc) as rank from Breed b2 join Pet P2 on b2.Breed_ID = P2.Breed_ID join Medical_History MH on P2.Pet_ID = MH.Pet_ID join Purpose_of_Visit PoV on PoV.Purpose_ID = MH.Purpose_ID group by P2.Breed_ID, MH.Purpose_ID order by P2.Breed_Id, rank ")
    names = []
    names2 = []
    names3 = []
    for row in result:
            name = {}
            name["Breed_name"] = row[1]
            name["Petgroup1"] = row[3]
            name["Petgroup2"] = row[4]
            name["MaleWtLb"] = row[5]
            name["Fur_Length"] = row[6]
            name["Avg_life_time"] = row[7]
            name["Temperament"] = row[8]
            names.append(name)

    for row in result2:
            name = {}
            name["breed_name"] = row[0]
            name["serv_name"] = row[1]
            name["avg_price"] = row[2]
            name["max_price"] = row[3]
            name["min_price"] = row[4]
            names2.append(name)

    for row in result3:
            name = {}
            name["breed_name"] = row[0]
            name["sick_id"] = row[2]
            name["sick_type"] = row[3]
            name["sick_count"] = row[4]
            name["count_rank"] = row[5]
            names3.append(name)

    return render_template('show_a.html',dest=names, dest2 = names2, dest3 = names3)
    #return str(Search)

@app.route("/BreedInfo", methods=["GET"])
def dest2():
    Search = request.args.get('breed')
    result = db.engine.execute("select * from Breed where Breed_name=%s",Search)
    result2 = db.engine.execute("select b.Breed_name, GS.Service_name, round(avg(GR.Price),1), max(GR.Price), min(GR.Price) from Breed b join Pet p on b.Breed_ID = p.Breed_ID join Grooming_Record GR on p.Pet_ID = GR.Pet_ID join Grooming_Services GS on GR.GService_ID = GS.GService_ID where Breed_name=%s group by GR.GService_ID",Search)
    result3 = db.engine.execute("select b2.Breed_name, P2.Breed_ID, MH.Purpose_ID, PoV.Purpose_discription, count(P2.Breed_ID) as count, dense_rank() over (partition by Breed_ID order by count(P2.Breed_ID) desc) as rank from Breed b2 join Pet P2 on b2.Breed_ID = P2.Breed_ID join Medical_History MH on P2.Pet_ID = MH.Pet_ID join Purpose_of_Visit PoV on PoV.Purpose_ID = MH.Purpose_ID where b2.Breed_name=%s group by P2.Breed_ID, MH.Purpose_ID order by P2.Breed_Id, rank ",Search)
    names = []
    names2 = []
    names3 = []
    for row in result:
            name = {}
            # name["Breed_name"] = row[1]
            name["Petgroup1"] = row[3]
            name["Petgroup2"] = row[4]
            name["MaleWtLb"] = row[5]
            name["Fur_Length"] = row[6]
            name["Avg_life_time"] = row[7]
            name["Temperament"] = row[8]
            names.append(name)

    for row in result2:
            name = {}
            # name["breed_name"] = row[0]
            name["serv_name"] = row[1]
            name["avg_price"] = row[2]
            name["max_price"] = row[3]
            name["min_price"] = row[4]
            names2.append(name)

    for row in result3:
            name = {}
            # name["breed_name"] = row[0]
            name["sick_id"] = row[2]
            name["sick_type"] = row[3]
            name["sick_count"] = row[4]
            name["count_rank"] = row[5]
            names3.append(name)

    return render_template('show_d.html',dest=names, dest2 = names2, dest3 = names3)

@app.route("/AllInsuranceInfo", methods=["POST"])
def customers():
    result = db.engine.execute("Select e.Pet_Category_name, Insurance_company_Name, Company_Link, dense_rank() over (partition by e.Pet_Category_ID order by count(IRecord_ID) desc) as rank, max(cost_per_year), min(cost_per_year) From Insurance_Record i, Insurance_Company c, Pet p, Breed b, Pet_Category e Where e.Pet_Category_name = 'Dog' And i.Insurance_company_ID = c.Insurance_company_ID And i.Pet_ID = p.Pet_ID And p.Breed_ID = b.Breed_ID And b.Pet_Category_ID = e.Pet_Category_ID Group by e.Pet_Category_name, i.Insurance_company_ID Order by e.Pet_Category_name, Rank")
    result2 = db.engine.execute("Select e.Pet_Category_name, Insurance_company_Name, Company_Link, dense_rank() over (partition by e.Pet_Category_ID order by count(IRecord_ID) desc) as rank, max(cost_per_year), min(cost_per_year) From Insurance_Record i, Insurance_Company c, Pet p, Breed b, Pet_Category e Where e.Pet_Category_name = 'Cat' And i.Insurance_company_ID = c.Insurance_company_ID And i.Pet_ID = p.Pet_ID And p.Breed_ID = b.Breed_ID And b.Pet_Category_ID = e.Pet_Category_ID Group by e.Pet_Category_name, i.Insurance_company_ID Order by e.Pet_Category_name, Rank")
    names = []
    names2 = []

    for row in result:
        name = {}
        name["Pet_Catefory"] = row[0]
        name["Insurance_company_Name"] = row[1]
        name["Company_Link"] = row[2]
        name["Rank_of_Insurance"] = row[3]
        name["max_cost_per_year"] = row[4]
        name["min_cost_per_year"] = row[5]
        names.append(name)

    for row in result2:
        name = {}
        name["Pet_Catefory"] = row[0]
        name["Insurance_company_Name"] = row[1]
        name["Company_Link"] = row[2]
        name["Rank_of_Insurance"] = row[3]
        name["max_cost_per_year"] = row[4]
        name["min_cost_per_year"] = row[5]
        names2.append(name)
    return render_template('show_b.html',customers=names, customers2=names2)

@app.route("/InsuranceInfo", methods=["GET"])
def customers2():
    Search = request.args.get('category')
    result = db.engine.execute("Select e.Pet_Category_name, Insurance_company_Name, Company_Link, dense_rank() over (partition by e.Pet_Category_ID order by count(IRecord_ID) desc) as rank, max(cost_per_year), min(cost_per_year) From Insurance_Record i, Insurance_Company c, Pet p, Breed b, Pet_Category e Where i.Insurance_company_ID = c.Insurance_company_ID And i.Pet_ID = p.Pet_ID And p.Breed_ID = b.Breed_ID And b.Pet_Category_ID = e.Pet_Category_ID And e.Pet_Category_name =%s Group by i.Insurance_company_ID Order by e.Pet_Category_name, Rank LIMIT 3 ",Search)
    names = []

    for row in result:
        name = {}
        name["Pet_Catefory"] = row[0]
        name["Insurance_company_Name"] = row[1]
        name["Company_Link"] = row[2]
        name["Rank_of_Insurance"] = row[3]
        name["max_cost_per_year"] = row[4]
        name["min_cost_per_year"] = row[5]
        names.append(name)
    return render_template('show_c.html',customers=names)
    

@app.route("/In/<string:name>/")
def getMember(name):
   return render_template(
   'show_c.html',customer=name)
 

##########################Jing#################################

@app.route("/breedingpartner")
def breedingpartner():
  search0 = request.args.get('search0')
  search1 = request.args.get('search1')
  search2 = request.args.get('search2')
  search3 = request.args.get('search3')
  search4 = request.args.get('search4')

  resulta = db.engine.execute("SELECT Users.User_first_name, Users.User_last_name, Users.Street, Users.City, Pet.Pet_F_Name, Pet.Gender, TIMESTAMPDIFF(YEAR, Data_of_birth, CURDATE()) as Age From Pet, Users, Breed where Pet.User_ID = Users.User_ID AND Breed.Breed_ID = Pet.Breed_ID And Gender = %s And City = %s And Breed_name = %s And TIMESTAMPDIFF(YEAR, Data_of_birth, CURDATE()) BETWEEN %s AND %s", search0,search1,search2,search3,search4)
  names  = []    
  for row in resulta:
        name = {}
        name["User_first_name"] = row[0]
        name["User_last_name"] = row[1]
        name["City"] = row[3]
        name["Pet_F_Name"] = row[4]
        name["Gender"] = row[5]
        name["Age"] = row[6]
        names.append(name)
  return render_template('show_breedingpartner.html',breedingpartner=names)


if __name__ == "__main__":
   app.run(host="0.0.0.0", debug=True)




