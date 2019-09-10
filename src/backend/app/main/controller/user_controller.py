import logging
import os
import datetime
import flask
from flask import request
from flask_restplus import Resource

from ..util.dto.user import UserDto
from ..util.jwt import decode_auth_token, get_username_by_token
from ..service.user_service import list_users_by_status, get_user_by_username
from ..util.error import raiseIfExcept, Forbidden


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
        token = request.headers.get("Authorization")
        tu = get_username_by_token(token)
        if tu != username:
            raise Forbidden("Not allow to read other user info")

        user = get_user_by_username(username)
        if user is None:
            return "", 404
        return user


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
        username = get_username_by_token(token)
        ret = get_user_by_username(username)
        raiseIfExcept(ret)
        return ret
