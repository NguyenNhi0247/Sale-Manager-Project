import logging
import os
import flask
from flask import request
from flask_restplus import Resource

from ..util.jwt import get_user_id_by_token
from ..util.dto.cart import CartDto
from ..util.dto.book_cart import BookCartDto

from ..service.cart_service import insert_book_to_cart
from ..util.error import raiseIfExcept


api = BookCartDto.api


log = logging.getLogger("cart.controller")
log.setLevel(logging.DEBUG)


@api.route("/insert-book")
class Cart(Resource):
    @api.doc(
        "Insert book to Cart",
        responses={
            200: "Insert successfully",
            500: "Internal Server Error",
        },
    )
    @api.expect(CartDto.add_book_request, validate=True) # Request
    def post(self):
        """Insert book to Cart"""
        try:
            token = request.headers.get("Authorization")
            user_id = get_user_id_by_token(token)

            data = request.get_json()
            book_id = data.get("book_id", None)
            price = data.get("price", None)
            quantity = data.get("quantity", None)
            print("=========")
            print(type(data))
            print(book_id)
            if book_id:
                insert_book_to_cart(user_id, book_id, price, quantity)
            return {}
        except Exception as exception:
            log.exception("failed to insert book to cart {}".format(exception))
