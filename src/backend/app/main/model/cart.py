import datetime
from .. import db
from sqlalchemy.dialects import postgresql


class Cart(db.Model):
    """ Cart model for storing bookk selected"""

    __tablename__ = "carts"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id(db.Integer)
    created_at = db.Column(db.DateTime())
    updated_at = db.Column(db.DateTime())
    is_deleted = db.Column(db.Boolean())
    deleted_at = db.Column(db.DateTime())