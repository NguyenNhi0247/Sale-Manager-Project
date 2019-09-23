import datetime
from .. import db
from sqlalchemy.dialects import postgresql


class UserBooks(db.Model):
    """ UserBooks model for storing user's purchased books"""

    __tablename__ = "user_books"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer)
    book_id = db.Column(db.Integer)
    created_at = db.Column(db.DateTime())
