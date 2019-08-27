import logging
import os
import datetime
import flask
from flask import request
from flask_restplus import Resource

from ..util.dto.user import UserDto
from ..util.jwt import decode_auth_token
from ..service.user_service import list_users_by_status, get_user_by_username
from ..util.error import (
    BadRequest,
    Unauthorized,
    InternalServerError,
    raiseIfExcept,
)


api = UserDto.api

log = logging.getLogger("user.controller")
log.setLevel(logging.DEBUG)


@api.route("/")
class UserList(Resource):
    # GET /api/v1/users?status=[all/active/deleted]
    @api.doc(
        "List all users based on status (all/active/deleted)",
        responses={200: "Success", 500: "Internal Server Error"},
        security="apikey",
    )
    @api.marshal_list_with(UserDto.list_user_response)
    def get(self):
        """List all users based on status (all/active/deleted)"""
        log.error("HIT")
        status = flask.request.args.get("status")
        if status is None:
            status = "active"
        log.error(status)
        return list_users_by_status(status)


@api.route("/<string:username>")
@api.param("username", "Username")
class User(Resource):
    # GET /api/v1/users/:username
    @api.doc(
        "Get user details by username",
        responses={200: "Success", 404: "User not found", 500: "Internal Server Error"},
        params={"uid": "Username"},
        security="apikey",
    )
    @api.marshal_with(UserDto.list_user_response)
    def get(self, username):
        """Get user details by its username"""
        try:
            user = get_user_by_username(username)
            if user is None:
                return "", 404
            return user
        except Exception as e:
            log.exception("failed to get user")


@api.route("/whoami")
class Whoami(Resource):
    # POST /api/v1/login
    @api.doc(
        "Return current user information from authentication token",
        responses={200: "Success", 400: "Invalid token", 500: "Internal Server Error"},
        security="apikey",
    )
    @api.marshal_with(UserDto.list_user_response)
    def get(self):
        """Decode JWT authentication token and retrieve user info"""
        token = request.headers.get("Authorization")
        if token is None or token == "":
            raise Unauthorized("Token must be provided in Authorization header")
        if token.startswith("Bearer "):
            token = token[len("Bearer ") :]

        ret = decode_auth_token(token)
        raiseIfExcept(ret)
        log.error(ret)
        ret = get_user_by_username(ret["username"])
        raiseIfExcept(ret)
        return ret


@api.errorhandler(Unauthorized)
@api.errorhandler(BadRequest)
def handle_error(error):
    return error.to_dict(), getattr(error, "code")


@api.errorhandler
def default_error_handler(error):
    """Returns Internal server error"""
    error = InternalServerError()
    return error.to_dict(), getattr(error, "code", 500)
