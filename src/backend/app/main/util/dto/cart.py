from flask_restplus import Namespace, fields

# from ..response import JsonEncodedDict


class CartDto:
    api = Namespace("carts", description="Cart related operations")
    cart = api.model(
        "cart",
        {
            "id": fields.Integer(description="cart identifier"),
            "user_id": fields.Integer(),
            "created_at": fields.DateTime(),
            "updated_at": fields.DateTime(),
            "is_deleted": fields.Boolean(),
            "deleted_at": fields.DateTime(),
        },
    )
