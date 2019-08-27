from .. import db
import datetime
import logging

log = logging.getLogger("user.model")
log.setLevel(logging.DEBUG)

# User role
# 1. Admin
# 2. Merchant
# 3. User
# 4. Anonymous


class User(db.Model):
    """ User Model for storing user related details """

    __tablename__ = "users"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    email = db.Column(db.String(500), unique=True, nullable=False)
    password = db.Column(db.String(100), nullable=False)
    avatar = db.Column(db.String(1000))
    role = db.Column(db.Integer(), nullable=False)
    display_name = db.Column(db.String(500))
    date_of_birth = db.Column(db.DateTime())
    created_at = db.Column(db.DateTime())
    updated_at = db.Column(db.DateTime())
    is_deleted = db.Column(db.Boolean())
    deleted_at = db.Column(db.DateTime())

    def __repr__(self):
        return "<User '{}'>".format(self.username)
