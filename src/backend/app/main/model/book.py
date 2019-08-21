import datetime
from .. import db, flask_bcrypt
from sqlalchemy.dialects import postgresql


class Book(db.Model):
    """ Book model for storing user related details """

    __tablename__ = "books"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    title = db.Column(db.String(500), nullable=False)
    sub_title = db.Column(db.String(2000))
    thumbnails = db.Column(postgresql.ARRAY(postgresql.CHAR))
    description = db.Column(db.String(10000))
    long_description = db.Column(db.String(50000))
    price = db.Column(db.Numeric(), nullable=False)
    total_rating_point = db.Column(db.Numeric())
    total_rated = db.Column(db.Numeric())
    total_purchased = db.Column(db.Numeric())
    publisher = db.Column(db.String(500))
    published_at = db.Column(db.DateTime())
    published_place = db.Column(db.String(500))
    pagination = db.Column(db.String(100))
    ebook_formats = db.Column(db.JSON())
    authors = db.Column(postgresql.ARRAY(postgresql.CHAR))
    categories = db.Column(postgresql.ARRAY(postgresql.CHAR))
    created_at = db.Column(db.DateTime())
    updated_at = db.Column(db.DateTime())
    is_deleted = db.Column(db.Boolean())
    deleted_at = db.Column(db.DateTime())

    def __repr__(self):
        return "<Book #{}: {}>".format(self.id, self.title)
