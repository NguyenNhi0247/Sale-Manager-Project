from flask_restplus import Namespace, fields


class UserDto:
    api = Namespace("users", description="User related operations")
    list_user_response = api.model(
        "list_user_response",
        {
            "id": fields.String(description="user identifier"),
            "username": fields.String(required=True),
            "email": fields.String(required=True),
            "avatar": fields.String(),
            "role": fields.Integer(),
            "display_name": fields.String(),
            "date_of_birth": fields.DateTime(),
            "created_at": fields.DateTime(),
            "updated_at": fields.DateTime(),
            "is_deleted": fields.Boolean(),
            "deleted_at": fields.DateTime(),
        },
    )

    get_user_detail_response = api.model(
        "get_user_detail_response",
        {
            "id": fields.String(description="user identifier"),
            "username": fields.String(required=True),
            "email": fields.String(required=True),
            "avatar": fields.String(),
            "role": fields.Integer(),
            "display_name": fields.String(),
            "date_of_birth": fields.DateTime(),
            "created_at": fields.DateTime(),
            "updated_at": fields.DateTime(),
            "is_deleted": fields.Boolean(),
            "deleted_at": fields.DateTime(),
        },
    )

    user_address_request = api.model(
        "user_address_request",
        {
            "user_id": fields.Integer(),
            "receiver_name": fields.String(),
            "address": fields.String(),
            "email": fields.String(),
            "city": fields.String(),
            "country": fields.String(),
            "phone_number": fields.String(),
            "zip_code": fields.String(),
        },
    )

    user_address_response = api.model(
        "user_address_response",
        {
            "id": fields.Integer(),
            "user_id": fields.Integer(),
            "receiver_name": fields.String(),
            "address": fields.String(),
            "email": fields.String(),
            "city": fields.String(),
            "country": fields.String(),
            "phone_number": fields.String(),
            "zip_code": fields.String(),
            "is_default": fields.Boolean(),
            "created_at": fields.DateTime(),
            "updated_at": fields.DateTime(),
            "is_deleted": fields.Boolean(),
            "deleted_at": fields.DateTime(),
        },
    )

    user_payment_request = api.model(
        "user_payment_request",
        {
            "type": fields.String(),
            "user_id": fields.Integer(),
            "card_number": fields.String(),
            "card_holder": fields.String(),
            "valid_date": fields.String(),
        },
    )

    user_payment_response = api.model(
        "user_payment_response",
        {
            "id": fields.Integer(),
            "type": fields.String(),
            "user_id": fields.Integer(),
            "is_default": fields.Boolean(),
            "card_number": fields.String(),
            "card_holder": fields.String(),
            "valid_date": fields.String(),
            "created_at": fields.DateTime(),
            "updated_at": fields.DateTime(),
            "deleted_at": fields.DateTime(),
            "is_deleted": fields.Boolean(),
        },
    )

    user_order_info_response = api.model(
        "user_order_info_response",
        {
            "address": fields.Nested(
                {
                    "id": fields.Integer(),
                    "user_id": fields.Integer(),
                    "receiver_name": fields.String(),
                    "address": fields.String(),
                    "email": fields.String(),
                    "city": fields.String(),
                    "country": fields.String(),
                    "phone_number": fields.String(),
                    "zip_code": fields.String(),
                    "is_default": fields.Boolean(),
                    "created_at": fields.DateTime(),
                    "updated_at": fields.DateTime(),
                    "is_deleted": fields.Boolean(),
                    "deleted_at": fields.DateTime(),
                }
            ),
            "payment": fields.Nested(
                {
                    "id": fields.Integer(),
                    "type": fields.String(),
                    "user_id": fields.Integer(),
                    "is_default": fields.Boolean(),
                    "card_number": fields.String(),
                    "card_holder": fields.String(),
                    "valid_date": fields.String(),
                    "created_at": fields.DateTime(),
                    "updated_at": fields.DateTime(),
                    "deleted_at": fields.DateTime(),
                    "is_deleted": fields.Boolean(),
                }
            ),
        },
    )

    new_order_request = api.model(
        "new_order_request",
        {
            "user_id": fields.Integer(),
            "user_payment_id": fields.Integer(),
            "user_address_id": fields.Integer(),
            "total": fields.Float(),
            "discount": fields.Float(),
            "shipping_fee": fields.Float(),
        },
    )

    new_order_response = api.model(
        "new_order_request",
        {
            "id": fields.Integer(),
            "user_id": fields.Integer(),
            "user_payment_id": fields.Integer(),
            "user_address_id": fields.Integer(),
            "total": fields.Float(),
            "discount": fields.Float(),
            "shipping_fee": fields.Float(),
            "created_at": fields.DateTime(),
            "updated_at": fields.DateTime(),
            "deleted_at": fields.DateTime(),
            "is_deleted": fields.Boolean(),
        },
    )
