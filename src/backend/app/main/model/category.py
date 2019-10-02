import datetime
from .. import db
from sqlalchemy.dialects import postgresql


class Category(db.Model):

    __tablename__ = "categories"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    name = db.Column(db.String(500), nullable=False)
   