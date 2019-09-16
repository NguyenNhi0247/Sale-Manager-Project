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
            "card_number": fields.String(),
            "card_holder": fields.String(),
            "valid_date": fields.DateTime(),
        },
    )

