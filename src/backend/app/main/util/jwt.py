import jwt
from datetime import datetime, timedelta
from ..config import key
from .error import Unauthorized, InternalServerError


def encode_auth_token(data):
    """
    Generates the Auth Token
    :return: string
    """
    try:
        payload = {
            "exp": datetime.utcnow() + timedelta(days=7),
            "iat": datetime.utcnow(),
            "data": data,
        }
        return jwt.encode(payload, key, algorithm="HS256")
    except Exception as e:
        return InternalServerError("Failed to encode JWT token")


def decode_auth_token(auth_token):
    """
    Decodes the auth token
    :param auth_token:
    :return: integer|string
    """
    try:
        payload = jwt.decode(auth_token, key)
        # is_blacklisted_token = BlacklistToken.check_blacklist(auth_token)
        # if is_blacklisted_token:
        #     return 'Token blacklisted. Please log in again.'
        # else:
        return payload["data"]
    except jwt.ExpiredSignatureError:
        return Unauthorized("Token expired")
    except jwt.InvalidTokenError:
        return Unauthorized("Invalid token")

def get_user_id_by_token(token):
    if token is None or token == "":
        raise Unauthorized("Token must be provided in Authorization header")
    if token.startswith("Bearer "):
        token = token[len("Bearer ") :]
    data = decode_auth_token(token)
    return data["id"]

def get_username_by_token(token):
    if token is None or token == "":
        raise Unauthorized("Token must be provided in Authorization header")
    if token.startswith("Bearer "):
        token = token[len("Bearer ") :]
    data = decode_auth_token(token)
    return data["username"]

def get_user_role_by_token(token):
    if token is None or token == "":
        raise Unauthorized("Token must be provided in Authorization header")
    if token.startswith("Bearer "):
        token = token[len("Bearer ") :]
    data = decode_auth_token(token)
    return data["role"]
