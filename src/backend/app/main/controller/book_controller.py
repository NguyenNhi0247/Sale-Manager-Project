import logging
import os
from flask import request
from flask_restplus import Resource

from ..util.dto import BookDto
from ..util.response import omit_empty
from ..service.book_service import get_book_by_id, get_book

api = BookDto.api
_book = BookDto.book

log = logging.getLogger("book.controller")
log.setLevel(logging.DEBUG)


# GET/POST /api/v1/books?limit=5&offset=10
@api.route("/")
class ListBook(Resource):
    @api.doc("list_of_book")
    @api.marshal_list_with(_book) # Serialize/Encode/Marshal JSON
    def get(self):
        """List all registered users"""
        limit = request.args.get("limit")
        if limit == None:
            limit = 10
        offset = request.args.get("offset")  
        books = get_book(limit, offset)
        return books

#     @api.expect(_user, validate=True)
#     @api.response(201, "User successfully created.")
#     @api.doc("create a new book")
#     def post(self):
#         """Creates a new Book """
#         try:
#             data = request.json
#             return save_new_boom(data=data)
#         except Exception as e:
#             log.exception("failed to save book")


# GET /api/v1/books/:uid?limit=10&offset=5
# uid: URL param
# limit/offset: query param
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
