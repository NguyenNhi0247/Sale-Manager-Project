import datetime
from .. import db
from sqlalchemy.dialects import postgresql


class BookOrders(db.Model):
    """ BookOrders model for storing book ordered"""

    __tablename__ = "book_orders"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    book_id = db.Column(db.Integer)
    order_id = db.Column(db.Integer)
    price = db.Column(db.Numeric(), nullable=False)
    quantity= db.Column(db.Integer)
    updated_at = db.Column(db.DateTime())
