from flask import Flask,render_template, flash, redirect, session, url_for,request, jsonify
from app import application, db, models
import flask.ext.restless

application = Flask(__name__)
application.debug=True

application.secret_key = 'paradoksu' 

@application.route("/")
def index():
	return 'Welcome to the Geocash API page.'

if __name__ == "__main__":
	manager = flask.ext.restless.APIManager(application, flask_sqlalchemy_db=db)
	manager.create_api(models.User, methods=['GET', 'POST', 'DELETE'])
	application.run()