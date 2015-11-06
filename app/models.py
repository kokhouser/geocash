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

	@property
	def __repr__(self):
		return '<User %r>' % (self.nickname)

	@property
	def serialize(self):
		return {
			'id':self.id,
			'nickname':self.nickname,
			'password':self.password,
			'email':self.email,
			'loggedCaches':self.serialize_many2many
		}

	@property
	def serialize2(self):
		return {
			'id':self.id,
			'nickname':self.nickname,
			'password':self.password,
			'email':self.email,
		}

	@property
	def serialize_many2many(self):
		return [ item.serialize2 for item in self.loggedCaches]

class Geocache(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	name = db.Column(db.String(64))
	description = db.Column(db.String(240))
	latitude = db.Column(db.Float)
	longitude = db.Column(db.Float)
	#user_id = db.Column(db.Integer, db.ForeignKey('user.id'))

	def __repr__(self):
		return '<Geocache %r>' % (self.name)

	@property
	def serialize(self):
		return {
			'id':self.id,
			'name':self.name,
			'description':self.description,
			'latitude':self.latitude,
			'longitude':self.longitude,
			'loggedUsers':self.serialize_many2many
		}

	@property
	def serialize2(self):
		return {
			'id':self.id,
			'name':self.name,
			'description':self.description,
			'latitude':self.latitude,
			'longitude':self.longitude
		}

	@property
	def serialize_many2many(self):
		return [ item.serialize2 for item in self.loggedUsers]

