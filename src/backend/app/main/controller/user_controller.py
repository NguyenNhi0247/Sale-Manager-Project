import logging
import os
import datetime
import flask
from flask import request
from flask_restplus import Resource

from ..util.dto.user import UserDto
from ..service.user_service import (
    create_user,
    list_users_by_status,
    get_user_by_username,
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
    )
    @api.marshal_list_with(UserDto.list_user_response)
    def get(self):
        """List all users based on status (all/active/deleted)"""
        status = flask.request.args.get("status")
        if status is None:
            status = "active"
        log.error(status)
        return list_users_by_status(status)

    # POST /api/v1/users
    @api.doc(
        "Create a new user",
        responses={
            201: "User created",
            400: "Invalid user",
            500: "Internal Server Error",
        },
    )
    @api.expect(UserDto.create_user_request, validate=True)
    def post(self):
        """Creates a new user """
        try:
            data = request.json
            log.debug(data)
            return create_user(data=data)
        except Exception as e:
            log.exception("failed to create user")


@api.route("/<string:uid>")
@api.param("uid", "Username")
class User(Resource):
    # GET /api/v1/users/:uid
    @api.doc(
        "Get user details by username",
        responses={200: "Success", 404: "User not found", 500: "Internal Server Error"},
        params={"uid": "Username"},
    )
    @api.marshal_with(UserDto.list_user_response)
    def get(self, uid):
        """Get user details by its username"""
        try:
            user = get_user_by_username(uid)
            if user is None:
                return "", 404
            return user
        except Exception as e:
            log.exception("failed to get user")
