import logging
import os
import flask
from flask import request, jsonify
from flask_restplus import Resource

from ..util.jwt import get_user_id_by_token
from ..util.dto.cart import CartDto
from ..util.dto.book_cart import BookCartDto

# from ..util.dto.book import BookDto

from ..service.cart_service import (
    insert_book_to_cart,
    get_books_from_user_cart,
    remove_book_from_cart,
)

# from ..service.order_service import get_or_insert_order_by_user_id
from ..util.error import raiseIfExcept


api = BookCartDto.api

log = logging.getLogger("cart.controller")
log.setLevel(logging.DEBUG)


@api.route("/")
class BookSelected(Resource):
    @api.doc(
        "List book from carts", responses={200: "Success", 500: "Internal Server Error"}
    )
    @api.marshal_list_with(BookCartDto.list_book_response)
    def get(self):
        """List book selected"""
        try:
            token = request.headers.get("Authorization")
            user_id = get_user_id_by_token(token)
            books = get_books_from_user_cart(user_id)
            return books
        except Exception as ex:
            log.exception("failed to get book selected {}".format(ex))

    @api.doc(
        "Remove book from carts",
        responses={200: "Success", 500: "Internal Server Error"},
    )
    # @api.marshal_list_with(UserDto.list_user_response)
    def delete(self):
        try:
            token = request.headers.get("Authorization")
            user_id = get_user_id_by_token(token)
            book_id = request.args.get("book_id")
            print(book_id)
            remove_book_from_cart(user_id, int(book_id))
            return {}
        except Exception as ex:
            log.exception("failed to remove book{}".format(ex))


@api.route("/insert-book")
class BookCarts(Resource):
    @api.doc(
        "Insert book to Cart",
        responses={200: "Insert successfully", 500: "Internal Server Error"},
    )
    @api.expect(CartDto.add_book_request, validate=True)  # Request
    def post(self):
        """Insert book to Cart"""
        try:
            token = request.headers.get("Authorization")
            user_id = get_user_id_by_token(token)
            data = request.get_json()
            book_id = data.get("book_id", None)
            price = data.get("price", None)
            quantity = data.get("quantity", None)
            if book_id:
                insert_book_to_cart(user_id, book_id, price, quantity)
            return {}
        except Exception as exception:
            log.exception("failed to insert book to cart {}".format(exception))

# @api.route("/get-order")
# class Order(Resource):
#     @api.doc(
#         "Get order details", responses={200: "Success", 500: "Internal Server Error"}
#     )
#     @api.marshal_list_with(CartDto.order_response)
#     def get(self):
#         """List book selected"""
#         try:
#             token = request.headers.get("Authorization")
#             user_id = get_user_id_by_token(token)
#             order = get_or_insert_order_by_user_id(user_id)
            
#             return order
#         except Exception as ex:
#             log.exception("failed to get book selected {}".format(ex))
