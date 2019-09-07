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

    # [{"type":"txt","file_path":"_data/txt/OL16574453M.txt","file_size":577420}
    list_book_selected = api.model(
        "list_book_selected",
        {
            "id": fields.Integer(description="book identifier"),
            "title": fields.String(required=True, description="user username"),
            "thumbnails": fields.List(fields.String),
            "price": fields.Decimal(),
        },
    )