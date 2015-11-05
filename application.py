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
	return jsonify(json_list=[i.serialize for i in qryresult], num_result=len([i.serialize for i in qryresult]))

if __name__ == "__main__":
    manager = flask.ext.restless.APIManager(application, flask_sqlalchemy_db=db)
    manager.create_api(models.User, methods=['GET', 'POST', 'DELETE'])
    manager.create_api(models.Geocache, methods=['GET', 'POST', 'DELETE'])
    application.run()

##search query: http://localhost:5000/api/user?q={%22filters%22:[{%22name%22:%22nickname%22,%22op%22:%22eq%22,%22val%22:%22kokhouser%22},{%22name%22:%22password%22,%22op%22:%22eq%22,%22val%22:%22test%22}]}