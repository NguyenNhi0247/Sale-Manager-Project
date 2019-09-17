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

    api = Namespace("orders", description="Order related operations")
    order_response = api.model(
        "order_response",
        {
            "total_price": fields.Float(),
            "discount": fields.Float(),
            "final_price": fields.Float(),
        },
    )
