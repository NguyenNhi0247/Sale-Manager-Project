import uuid
from datetime import datetime, timezone
import logging

from app.main import db
from app.main.model.user import User
from ..util.password import PasswordCrypt

log = logging.getLogger("user.service")
log.setLevel(logging.DEBUG)


def create_user(data):
    user = get_user_by_username(data["username"])
    if not user:
        now = datetime.now()
        new_user = User(
            email=data["email"],
            username=data["username"],
            password=PasswordCrypt.hash(data["password"]),
            avatar="/img/default_avatar.png",
            role=3,  # User role always default as normal user
            display_name=data["username"],
            date_of_birth=datetime(
                2001, 1, 1, 0, 0, 0, tzinfo=timezone.utc
            ),  # Default over 18 year old
            created_at=now,
            updated_at=now,
            is_deleted=False,
            deleted_at=now,
        )
        save_changes(new_user)
        return generate_token(new_user)
    else:
        response_object = {
            "status": "fail",
            "message": "User already exists. Please login.",
        }
        return response_object, 409


def list_users_by_status(status="active"):
    status = str(status).lower()
    if status == "active" or status == "":
        return User.query.filter_by(is_deleted=False).all()
    if status == "all":
        return User.query.all()
    return User.query.filter_by(is_deleted=True).all()


def get_user_by_username(username):
    return User.query.filter_by(username=username).first()


def generate_token(user):
    try:
        # generate the auth token
        auth_token = User.encode_auth_token(user.id)
        response_object = {
            "status": "success",
            "message": "Successfully registered.",
            "Authorization": auth_token.decode(),
        }
        return response_object, 201
    except Exception as e:
        response_object = {
            "status": "fail",
            "message": "Some error occurred. Please try again.",
        }
        return response_object, 401


def save_changes(data):
    db.session.add(data)
    db.session.commit()

