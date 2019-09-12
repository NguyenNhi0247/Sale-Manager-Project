import logging
from flask import request
from flask_restplus import Resource

from ..service.user_service import edit_user_payment, get_user_payment_by_user_id
from ..util.jwt import get_user_id_by_token
from ..util.dto.public import PublicDto
from ..util.dto.user import UserDto
from ..util.jwt import decode_auth_token
from ..util.error import raiseIfExcept


api = UserDto.api

log = logging.getLogger("user_payment.controller")
log.setLevel(logging.DEBUG)


@api.route("/")
class UserPayment(Resource):
    @api.doc(
        "Get user payment",
        responses={
            200: "Successfully",
            500: "Internal Server Error",
        },
    )
    @api.marshal_with(UserDto.user_payment_request)
    def get(self):
        token = request.headers.get("Authorization")
        user_id = get_user_id_by_token(token)
        user_payment = get_user_payment_by_user_id(user_id)
        
        return user_payment


    @api.doc(
        "Add user payment",
        responses={
            200: "Successfully",
            500: "Internal Server Error",
        },
    )
    @api.expect(UserDto.user_payment_request, validate=True)
    # @api.marshal_with(UserDto.list_user_response)
    def post(self):
        token = request.headers.get("Authorization")
        user_id = get_user_id_by_token(token)
        data = request.json
        type = data.get("type", "")
        card_number = data.get("card_number", "")
        card_holder = data.get("card_holder", "")
        valid_date = data.get("valid_date", "")
        user_payment = edit_user_payment(user_id, type, card_number, card_holder, valid_date)
        return {}