import os                                                                                             
# SQLAlchemy database configuration. Here we are using a local sqlite3
# database
basedir = os.path.abspath(os.path.dirname(__file__))
WTF_CSRF_ENABLED = True
SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'app.db')
SQLALCHEMY_MIGRATE_REPO = os.path.join(basedir, 'db_repository')                                                                      
# Generate a random secret key
SECRET_KEY = os.urandom(24)
# Disable debugging
DEBUG = True  