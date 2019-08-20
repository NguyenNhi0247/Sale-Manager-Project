from flask_restplus import Namespace, fields


class UserDto:
    api = Namespace("users", description="user related operations")
    user = api.model(
        "user",
        {
            "id": fields.String(description="user identifier"),
            "username": fields.String(required=True, description="user username"),
            "email": fields.String(required=True, description="user email address"),
            "password": fields.String(required=True, description="user password"),
        },
    )
