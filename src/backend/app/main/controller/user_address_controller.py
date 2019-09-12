import logging
from flask import request
from flask_restplus import Resource

from ..service.user_service import edit_user_address, get_user_address_by_user_id
from ..util.jwt import get_user_id_by_token
from ..util.dto.user import UserDto
from ..util.jwt import decode_auth_token
from ..util.error import raiseIfExcept


api = UserDto.api

log = logging.getLogger("user_address.controller")
log.setLevel(logging.DEBUG)


@api.route("/")
class UserAddress(Resource):
    @api.doc(
        "Get user address",
        responses={
            200: "Successfully",
            500: "Internal Server Error",
        },
    )
    @api.marshal_with(UserDto.user_address_request)
    def get(self):
        token = request.headers.get("Authorization")
        user_id = get_user_id_by_token(token)
        user_address = get_user_address_by_user_id(user_id)
        return user_address


    @api.doc(
        "Add user address",
        responses={
            200: "Successfully",
            500: "Internal Server Error",
        },
    )
    @api.expect(UserDto.user_address_request, validate=True)
    def post(self):
        token = request.headers.get("Authorization")
        user_id = get_user_id_by_token(token)
        data = request.json
        receive_name = data.get("receive_name", "")
        address = data.get("address", "")
        phone_number = data.get("phone_number", "")
        zip_code = data.get("zip_code", "")
        user_address = edit_user_address(user_id, receive_name, address, phone_number, zip_code)
        return {}