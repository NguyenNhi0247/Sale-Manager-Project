from flask_restplus import Namespace, fields


class PublicDto:
    api = Namespace("public", description="Public APIs")

    register_request = api.model(
        "register_request",
        {
            "username": fields.String(required=True),
            "email": fields.String(required=True),
            "password": fields.String(required=True),
        },
    )

    login_request = api.model(
        "login_request",
        {
            "account": fields.String(required=True),
            "password": fields.String(required=True),
        },
    )
