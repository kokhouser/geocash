from app import db
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

association_table = db.Table('association', db.Model.metadata,
    db.Column('user_id', db.Integer, db.ForeignKey('user.id')),
    db.Column('geocache_id', db.Integer, db.ForeignKey('geocache.id'))
)

class User(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	nickname = db.Column(db.String(64), index=True, unique=True)
	password = db.Column(db.String(64))
	email = db.Column(db.String(120), index=True, unique=True)
	#geocaches = db.relationship('Geocache', backref='addedBy', lazy='dynamic')
	loggedCaches = db.relationship("Geocache", secondary=association_table, backref="loggedUsers")

	def __repr__(self):
		return '<User %r>' % (self.nickname)

class Geocache(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	name = db.Column(db.String(64))
	description = db.Column(db.String(240))
	#user_id = db.Column(db.Integer, db.ForeignKey('user.id'))

	def __repr__(self):
		return '<Geocache %r>' % (self.name)

