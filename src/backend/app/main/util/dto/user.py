from flask_restplus import Namespace, fields


class UserDto:
    api = Namespace("users", description="user related operations")
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

    register_request = api.model(
        "register_request",
        {
            "username": fields.String(required=True),
            "email": fields.String(required=True),
            "password": fields.String(required=True),
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

    login_request = api.model(
        "login_request",
        {
            "account": fields.String(required=True),
            "password": fields.String(required=True),
        },
    )
