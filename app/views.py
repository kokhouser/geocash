from flask import render_template, flash, redirect, session, url_for, request
from app import app

@app.route("/")
def index():
	return 'Hello World!'