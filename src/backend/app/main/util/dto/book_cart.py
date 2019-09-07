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
            "price": fields.Decimal(),
            "quality": fields.Integer(),
            "updated_at": fields.DateTime()
        },
    )

    list_book_response = api.model(
        "list_book_response",
        {
            "id": fields.Integer(description="book identifier"),
            "title": fields.String(required=True, description="user username"),
            "thumbnails": fields.List(fields.String),
            "price": fields.Float(),
        },
    )
