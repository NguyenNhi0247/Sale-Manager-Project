import logging
import os
from flask import request
from flask_restplus import Resource

from ..util.dto import BookDto
from ..util.response import omit_empty
from ..service.book_service import get_book_by_id

api = BookDto.api
_book = BookDto.book

log = logging.getLogger("book.controller")
log.setLevel(logging.DEBUG)


# GET/POST /api/v1/books
# @api.route("/")
# class UserList(Resource):
#     @api.doc("list_of_registered_users")
#     @api.marshal_list_with(_book, envelope="data")
#     def get(self):
#         """List all registered users"""
#         return get_all_users()

#     @api.expect(_user, validate=True)
#     @api.response(201, "User successfully created.")
#     @api.doc("create a new user")
#     def post(self):
#         """Creates a new User """
#         try:
#             data = request.json
#             return save_new_user(data=data)
#         except Exception as e:
#             log.exception("failed to save user")


# GET /api/v1/books/:uid
@api.route("/<int:bid>")
@api.param("bid", "Book identifier")
@api.response(404, "Book not found.")
class Book(Resource):
    @api.doc("Get book by ID")
    @api.marshal_with(_book)
    def get(self, bid):
        """get a user given its identifier"""
        try:
            book = get_book_by_id(bid)
            if book is None:
                return '', 404
            else:
                return book
        except Exception as e:
            log.exception("failed to get book")
