from flask import Flask,render_template, flash, redirect, session, url_for,request, jsonify
from app import application, db, models
import flask.ext.restless

application = Flask(__name__)
application.debug=True

application.secret_key = 'paradoksu' 

@application.route("/")
def index():
	return 'Welcome to the Geocash API page.'

@application.route("/api/getUsers")
def api_getUsers():
    return jsonify({'users': models.User.query.all()})

if __name__ == "__main__":
	application.run()