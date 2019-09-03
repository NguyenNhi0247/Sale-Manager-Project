import logging
import os
import flask
from flask import request
from flask_restplus import Resource

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
    @api.expect(BookCartDto.book_cart, validate=True)
    @api.marshal_with(CartDto.list_user_response)
    def post(self):
        """Insert book to Cart"""
        try:
            user_id = flask.request.args.get("user_id")
            book_id = flask.request.args.get("book_id")
            insert_book_to_cart(user_id, book_id)
            return {}
        except Exception as exception:
            log.exception("failed to insert book to cart {}".format(exception))