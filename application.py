from flask import Flask,render_template, flash, redirect, session, url_for,request, jsonify
from app import application, db, models
import flask.ext.restless

application = Flask(__name__)
application.debug=True

application.secret_key = 'paradoksu' 

@application.route("/")
def index():
	return 'Welcome to the Geocash API page.'

@application.route("/users")
def allUsers():
	qryresult = models.User.query.all()
	return jsonify(num_results=len([i.serialize for i in qryresult]), objects=[i.serialize for i in qryresult])

@application.route("/login", methods=['POST'])
def login():
	if request.method == 'POST':
		email = request.json['email']
		password = request.json['password']
		l = db.session.query(models.User).\
			filter(models.User.email==email)
		for j in l:
		 	if (j.password == password):
		 		return "Logged in!"
		return "Error logging in."

@application.route("/users/add", methods=['POST'])
def addUser():
	if request.method == 'POST':
		nickname = request.json['nickname']
		password = request.json['password']
		email = request.json['email']
		newUser = models.User(nickname=nickname, password = password, email=email)
		try:
			db.session.add(newUser)
			db.session.commit()
			return "Added " + newUser.nickname + "!\n"
		except:
			return "Error adding user."


@application.route("/geocaches")
def allCaches():
	qryresult = models.Geocache.query.all()
	return jsonify( num_results=len([i.serialize for i in qryresult]), objects=[i.serialize for i in qryresult])

@application.route("/geocaches/add", methods=['POST'])
def addCache():
	if request.method == 'POST':
		name = request.json['name']
		description = request.json['description']
		latitude = request.json['latitude']
		longitude = request.json['longitude']
		newCache = models.Geocache(name=name, description = description, latitude=latitude, longitude=longitude)
		try:
			db.session.add(newCache)
			db.session.commit()
			return "Added " + newCache.name + "!\n"
		except:
			return "Error adding cache."

@application.route("/log/add", methods=['POST'])
def addLog():
	if request.method == 'POST':
		userID = request.json['userID']
		cacheID = request.json['cacheID']
		k = db.session.query(models.Geocache).\
			filter(models.Geocache.id==cacheID)
		c = 0
		for i in k:
			c = i
		l = db.session.query(models.User).\
			filter(models.User.id==userID)
		u = 0
		for j in l:
			u = j
		c.loggedUsers.append(u)
		try:
			db.session.commit()
			return "Added log!"
		except:
			return "Error adding log!"


if __name__ == "__main__":
    manager = flask.ext.restless.APIManager(application, flask_sqlalchemy_db=db)
    manager.create_api(models.User, methods=['GET', 'POST', 'DELETE'])
    manager.create_api(models.Geocache, methods=['GET', 'POST', 'DELETE'])
    application.run()

##search query: http://localhost:5000/api/user?q={%22filters%22:[{%22name%22:%22nickname%22,%22op%22:%22eq%22,%22val%22:%22kokhouser%22},{%22name%22:%22password%22,%22op%22:%22eq%22,%22val%22:%22test%22}]}