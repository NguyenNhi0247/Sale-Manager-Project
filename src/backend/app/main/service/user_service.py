import uuid
from datetime import datetime, timezone
import logging
from flask import abort, jsonify

from app.main import db
from app.main.model.user import User
from ..util.password import PasswordCrypt
from ..util.jwt import encode_auth_token

from ..util.error import NotFound, InternalServerError, BadRequest

log = logging.getLogger("user.service")
log.setLevel(logging.DEBUG)


def register_user(data):
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
        return get_user_by_username(data["username"])

    return Conflict("User already existed")


def login_user(data):
    user = get_user_by_account(data["account"])
    if not user:
        return BadRequest("User not found")
    if not PasswordCrypt.check(user.password, data["password"]):
        return BadRequest("Invalid credentials")
    return generate_token(user)


def list_users_by_status(status="active"):
    status = str(status).lower()
    if status == "active" or status == "":
        return User.query.filter_by(is_deleted=False).all()
    if status == "all":
        return User.query.all()
    return User.query.filter_by(is_deleted=True).all()


def get_user_by_username(username):
    return User.query.filter_by(username=username).first()


def get_user_by_account(account):
    return (
        User.query.filter_by(is_deleted=False)
        .filter((User.username == account) | (User.email == account))
        .first()
    )


def generate_token(user):
    try:
        # generate the auth token
        auth_token = encode_auth_token(
            {"id": user.id, "username": user.username, "role": user.role}
        )
        return auth_token.decode()
    except Exception as e:
        log.error(e)
        return InternalServerError("Failed to generate JWT Wtoken")


def save_changes(data):
    db.session.add(data)
    db.session.commit()

