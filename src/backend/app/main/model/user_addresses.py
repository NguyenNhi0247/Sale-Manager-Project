import datetime
from .. import db
from sqlalchemy.dialects import postgresql


class UserAddresses(db.Model):
    """ UserAddresses model for storing user addresses details """

    __tablename__ = "user_addresses"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer)
    receiver_name = db.Column(db.String(1500))
    address = db.Column(db.String(250))
    is_default = db.Column(db.Boolean())
    zip_code = db.Column(db.String(10))
    phone_number = db.Column(db.String(20))
    created_at = db.Column(db.DateTime())
    updated_at = db.Column(db.DateTime())
    is_deleted = db.Column(db.Boolean())
    deleted_at = db.Column(db.DateTime())
