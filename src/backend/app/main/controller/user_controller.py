import logging
import os
import datetime
import flask
from flask import request
from flask_restplus import Resource

from ..util.dto.user import UserDto
from ..service.user_service import (
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
