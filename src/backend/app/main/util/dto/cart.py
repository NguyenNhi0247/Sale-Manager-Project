from flask_restplus import Namespace, fields

# from ..response import JsonEncodedDict


class CartDto:
    api = Namespace("carts", description="Cart related operations")
    add_book_request = api.model(
        "add_book_request",
        {
            "book_id": fields.Integer(),
            "price": fields.Float(),
            "quantity": fields.Integer(),
        },
    )