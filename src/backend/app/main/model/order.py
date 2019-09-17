import datetime
from .. import db
from sqlalchemy.dialects import postgresql


class Order(db.Model):
    """ Order model for storing Order details"""

    __tablename__ = "orders"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer())
    user_payment_id = db.Column(db.Integer())
    user_address_id = db.Column(db.Integer())
    total = db.Column(db.Numeric(), nullable=False)
    discount = db.Column(db.Numeric(), nullable=False)
    shipping_fee = db.Column(db.Numeric(), nullable=False)
    created_at = db.Column(db.DateTime())
    updated_at = db.Column(db.DateTime())
    is_deleted = db.Column(db.Boolean())
    deleted_at = db.Column(db.DateTime())
