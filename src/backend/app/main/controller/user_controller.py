import logging
import os
from flask import request
from flask_restplus import Resource

from ..util.dto import UserDto
from ..util.response import omit_empty
from ..service.user_service import save_new_user, get_all_users, get_a_user

api = UserDto.api
_user = UserDto.user

log = logging.getLogger("user.controller")
log.setLevel(logging.DEBUG)


# GET/POST /api/v1/users
@api.route("/")
class UserList(Resource):
    @api.doc("list_of_registered_users")
    @api.marshal_list_with(_user)
    def get(self):
        """List all registered users"""
        return get_all_users()

    @api.expect(_user, validate=True)
    @api.response(201, "User successfully created.")
    @api.doc("create a new user")
    def post(self):
        """Creates a new User """
        try:
            data = request.json
            return save_new_user(data=data)
        except Exception as e:
            log.exception("failed to save user")


# GET /api/v1/users/:uid
@api.route("/<string:uid>")
@api.param("uid", "Username")
@api.response(404, "User not found.")
class User(Resource):
    @api.doc("get a user")
    @api.marshal_with(_user)
    def get(self, uid):
        """get a user given its identifier"""
        try:
            user = get_a_user(uid)
            if user is None:
                return '', 404
            else:
                return user
        except Exception as e:
            log.exception("failed to get user")
