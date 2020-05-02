from flask import Flask,render_template, request, redirect
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:mypass@mariadb-diveshop.db-network/Diveshop'

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:mypass@mariadb-diveshop.db-network/PetHappyWeHappy'

db = SQLAlchemy(app) 

@app.route("/database")
def datab():
   result = db.engine.execute("SELECT DATABASE()")
   names = [row[0] for row in result]
   return names[0] 


@app.route("/")
def index():
   result = db.engine.execute("select DISTINCT(City) from Users")
   accs = []

   for row in result:
       name = {}
       name["City"] = row[0]
       accs.append(name)

   return render_template("index.html", data=accs)

@app.route("/destinations", methods=["POST", "GET"])
@app.route("/customers", methods=["POST", "GET"])


@app.route("/destinations")
def dest():
    # result = db.engine.execute("select * from DEST")
    if request.method == "GET":
      # search = request.args.get('accomodations')
      search = request.args.get('accomodations')

      # result = db.engine.execute("select * from Groomer where City=%s", search)
      # result = db.engine.execute("SELECT G.Groomer_name, AVG(Service_time) AS AVG_TIME_SPENT, AVG(Price) AS AVG_COST_SPENT, dense_rank () over (order by count(*) desc) AS rank FROM Grooming_Record GR, Groomer G, Pet P, User U WHERE GR.Groomer_ID=G.Groomer_ID AND GR.Pet_ID = P.Pet_ID AND P.User_ID = U.User_ID AND G.City = %s group by Groomer_name order by 4 ASC LIMIT 3", search)
      result = db.engine.execute("select * from Groomer where City=%s", search)

    else:
      result = db.engine.execute("select * from Groomer")
    
    names = []
    
    for row in result:
        name = {}
        name["Groomer_ID"] = row[0]
        name["Groomer_name"] = row[1]
        names.append(name)
    return render_template('show_c.html',dest=names)



# @app.route("/customers")
# def customers():
#     result = db.engine.execute("select * from Groomer where city = 'Berkeley' ")
#     names = []
    
#     for row in result:
#         name = {}
#         name["Groomer_ID"] = row[1]
#         name["Groomer_name"] = row[2]

#         names.append(name)

#     return render_template('show_c.html',customers=names)
    

@app.route("/customers/<string:name>/")
def getMember(name):
   return name
 
if __name__ == "__main__":
   app.run(host="0.0.0.0", debug=True)
   
