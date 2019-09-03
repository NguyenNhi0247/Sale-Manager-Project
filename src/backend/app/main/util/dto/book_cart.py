from flask_restplus import Namespace, fields

# from ..response import JsonEncodedDict


class BookCartDto:
    api = Namespace("bookcarts", description="BookCart related operations")
    book_cart = api.model(
        "book_cart",
        {
            "id": fields.Integer(description="cart identifier"),
            "book_id": fields.Integer(),
            "cart_id": fields.Integer(),
            "price": fields.Numeric(),
            "quality": fields.Integer(),
            "updated_at": fields.DateTime()
        },
    )
