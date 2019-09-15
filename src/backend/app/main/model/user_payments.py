import datetime
from .. import db
from sqlalchemy.dialects import postgresql


class UserPayments(db.Model):
    """ UserPayments model for storing payment information"""

    __tablename__ = "user_payments"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    uid = db.Column(db.Integer)
    type = db.Column(db.String(100))
    is_default = db.Column(db.Boolean())
    card_number = db.Column(db.String(100))
    card_holder = db.Column(db.String(100))
    valid_date = db.Column(db.DateTime())
    created_at = db.Column(db.DateTime())
    updated_at = db.Column(db.DateTime())
    is_deleted = db.Column(db.Boolean())
    deleted_at = db.Column(db.DateTime())
