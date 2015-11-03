from flask import Flask,render_template, flash, redirect, session, url_for,request
from server import application, db, models
from sqlalchemy.sql import exists

application = Flask(__name__)
application.debug=True

application.secret_key = 'geocash' 

if __name__ == '__main__':
    application.run()