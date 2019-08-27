import logging
from flask import request
from flask_restplus import Resource

from ..service.user_service import login_user, register_user, get_user_by_username
from ..util.dto.public import PublicDto
from ..util.dto.user import UserDto
from ..util.jwt import decode_auth_token
from ..util.error import (
    BadRequest,
    Unauthorized,
    NotFound,
    Conflict,
    InternalServerError,
    raiseIfExcept,
)


api = PublicDto.api

log = logging.getLogger("public.controller")
log.setLevel(logging.DEBUG)


@api.route("/register")
class UserRegister(Resource):
    # POST /api/v1/register
    @api.doc(
        "Create a new user",
        responses={
            201: "User created",
            409: "User already existed",
            500: "Internal Server Error",
        },
    )
    @api.expect(PublicDto.register_request, validate=True)
    @api.marshal_with(UserDto.list_user_response)
    def post(self):
        """Creates a new user """
        data = request.json
        ret = register_user(data=data)
        raiseIfExcept(ret)
        return ret


@api.route("/login")
class UserLogin(Resource):
    # POST /api/v1/login
    @api.doc(
        "User login",
        responses={
            200: "Success",
            400: "Invalid account/credential",
            500: "Internal Server Error",
        },
    )
    @api.expect(PublicDto.login_request, validate=True)
    def post(self):
        """User login """
        data = request.json
        ret = login_user(data=data)
        raiseIfExcept(ret)
        return {"status": "success", "token": ret}, 200


@api.errorhandler(NotFound)
@api.errorhandler(Unauthorized)
@api.errorhandler(BadRequest)
def handle_error(error):
    return error.to_dict(), getattr(error, "code")


@api.errorhandler
def default_error_handler(error):
    """Returns Internal server error"""
    error = InternalServerError()
    return error.to_dict(), getattr(error, "code", 500)
