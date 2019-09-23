import uuid
from datetime import datetime, timezone
import logging
from flask import abort, jsonify

from app.main import db
from app.main.model.user import User
from app.main.model.user_addresses import UserAddresses
from app.main.model.user_payments import UserPayments
from app.main.model.user_books import UserBooks
from ..util.password import PasswordCrypt
from ..util.jwt import encode_auth_token
from ..util.error import BadRequest, Unauthorized, InternalServerError, raiseIfExcept


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

    return BadRequest("User already existed")


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


def get_user_by_id(uid):
    return User.query.filter_by(id=uid).first()


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


def get_user_address_by_user_id(user_id):
    return UserAddresses.query.filter_by(user_id=user_id).first()


def get_user_payment_by_user_id(user_id):
    return UserPayments.query.filter_by(user_id=user_id).first()


def get_user_purchased_books(user_id):
    return UserBooks.query.filter_by(user_id=user_id).all()


def edit_user_address(user_id, data):
    now = datetime.now()
    user_address = get_user_address_by_user_id(user_id)
    if user_address:
        user_address.receiver_name = (data["receiver_name"],)
        user_address.address = (data["address"],)
        user_address.city = (data["city"],)
        user_address.country = (data["country"],)
        user_address.zip_code = (data["zip_code"],)
        user_address.email = (data["email"],)
        user_address.phone_number = (data["phone_number"],)
        user_address.updated_at = (now,)
        db.session.commit()
    else:
        new_user_address = UserAddresses(
            user_id=user_id,
            receiver_name=data["receiver_name"],
            address=data["address"],
            city=data["city"],
            country=data["country"],
            email=data["email"],
            is_default=True,
            zip_code=data["zip_code"],
            phone_number=data["phone_number"],
            created_at=now,
            updated_at=now,
            is_deleted=False,
            deleted_at=now,
        )
        save_changes(new_user_address)


def edit_user_payment(user_id, data):
    now = datetime.now()
    user_payment = get_user_payment_by_user_id(user_id)
    if user_payment:
        user_payment.type = (data["type"],)
        user_payment.card_number = (data["card_number"],)
        user_payment.card_holder = (data["card_holder"],)
        user_payment.valid_date = (data["valid_date"],)
        user_payment.updated_at = (now,)
        db.session.commit()
    else:
        new_user_payment = UserPayments(
            user_id=data["user_id"],
            type=data["type"],
            is_default=True,
            card_number=data["card_number"],
            card_holder=data["card_holder"],
            valid_date=data["valid_date"],
            created_at=now,
            updated_at=now,
            deleted_at=now,
            is_deleted=False,
        )
        save_changes(new_user_payment)


def add_user_purchased_book(user_id, book_id):
    new_user_book = UserBooks(
        user_id=user_id, book_id=book_id, created_at=datetime.now()
    )
    save_changes(new_user_book)


def save_changes(data):
    db.session.add(data)
    db.session.commit()

