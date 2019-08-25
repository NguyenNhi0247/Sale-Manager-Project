import uuid
import datetime
import logging

from app.main import db
from app.main.model.user import User

log = logging.getLogger("user.service")
log.setLevel(logging.DEBUG)


def save_new_user(data):
    user = get_a_user(data['username'])
    if not user:
        now = datetime.datetime.now()
        new_user = User(
            email=data["email"],
            username=data["username"],
            password=data["password"],
            avatar=data["avatar"],
            role=data["role"],
            display_name=data["display_name"],
            date_of_birth=data["date_of_birth"],
            created_at=now,
            updated_at=now,
            is_deleted=False,
        )
        save_changes(new_user)
        return generate_token(new_user)
    else:
        response_object = {
            "status": "fail",
            "message": "User already exists. Please Log in.",
        }
        return response_object, 409


def get_all_users():
    return User.query.all()


def get_a_user(uid):
    return User.query.filter_by(username=uid).first()


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

