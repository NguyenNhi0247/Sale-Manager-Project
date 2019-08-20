import os

# uncomment the line below for postgres database url from environment variable
# postgres_local_base = os.environ['DATABASE_URL']

basedir = os.path.abspath(os.path.dirname(__file__))
pgHost = os.getenv("POSTGRES_HOST", "postgres")
pgPort = os.getenv("POSTGRES_PORT", "5432")
pgUsername = os.getenv("POSTGRES_USERNAME", "postgres")
pgPassword = os.getenv("POSTGRES_PASSWORD", "")
pgDatabase = os.getenv("POSTGRES_DATABASE", "beanies")


class Config:
    SECRET_KEY = os.getenv('SECRET_KEY', 'my_precious_secret_key')
    DEBUG = False
    SQLALCHEMY_DATABASE_URI = "postgres://{}:{}@{}:{}/{}".format(
        pgUsername, pgPassword, pgHost, pgPort, pgDatabase
    )


class DevelopmentConfig(Config):
    DEBUG = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False


class TestingConfig(Config):
    DEBUG = True
    TESTING = True
    PRESERVE_CONTEXT_ON_EXCEPTION = False
    SQLALCHEMY_TRACK_MODIFICATIONS = False


class ProductionConfig(Config):
    DEBUG = False


config_by_name = dict(dev=DevelopmentConfig, test=TestingConfig, prod=ProductionConfig)

key = Config.SECRET_KEY
