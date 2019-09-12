from flask_restplus import Api
from flask import Blueprint

from app.main.controller.public_controller import api as public_ns
from app.main.controller.book_controller import api as book_ns
from app.main.controller.user_controller import api as user_ns
from app.main.controller.cart_controller import api as cart_ns

blueprint = Blueprint("v1", __name__)

authorizations = {
    'apikey': {
        'type': 'apiKey',
        'in': 'header',
        'name': 'Authorization'
    }
}

api = Api(
    blueprint,
    title="BOOKSTORE PROJECT",
    description="an online E-book shopping site",
    version="1.0",
    doc="/api/v1/apidoc",
    authorizations=authorizations
)

api.add_namespace(public_ns, path="/api/v1")
api.add_namespace(user_ns, path="/api/v1/users")
api.add_namespace(book_ns, path="/api/v1/books")
api.add_namespace(cart_ns, path="/api/v1/carts")

