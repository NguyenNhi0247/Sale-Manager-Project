import datetime
from .. import db
from sqlalchemy.dialects import postgresql


class BookCarts(db.Model):
    """ BookCarts model for storing book details selected"""

    __tablename__ = "book_carts"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    book_id = db.Column(db.Integer)
    cart_id = db.Column(db.Integer)
    price = db.Column(db.Numeric(), nullable=False)
    quantity = db.Column(db.Integer)
    updated_at = db.Column(db.DateTime())
