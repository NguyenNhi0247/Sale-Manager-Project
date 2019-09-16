import logging
import os
import datetime
import flask
from flask import request
from flask_restplus import Resource

from ..util.dto.user import UserDto
from ..util.jwt import decode_auth_token, get_user_id_by_token
from ..service.order_service import (
    insert_order_by_user_id
)
from ..util.error import raiseIfExcept


api = UserDto.api

log = logging.getLogger("order.controller")
log.setLevel(logging.DEBUG)


@api.route("/")
class Order(Resource):
    @api.doc(
        responses={200: "Success", 500: "Internal Server Error"},
        security="apikey",
    )
    @api.marshal_list_with(UserDto.list_user_response)
    def post(self):   
        try:
            token = request.headers.get("Authorization")
            user_id = get_user_id_by_token(token)
            insert_order_by_user_id(user_id)
            return {"status": "Success"}
        except Exception as e:
            log.exception("failed to insert order")

