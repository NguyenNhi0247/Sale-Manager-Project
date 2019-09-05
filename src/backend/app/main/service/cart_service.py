from datetime import datetime, timezone
from app.main import db

from app.main.model.cart import Cart
from app.main.model.book_carts import BookCarts
from ..util.jwt import decode_auth_token
from app.main.service.book_service import get_book_by_id
from app.main.service.user_service import get_user_by_id


def get_cart_by_user_id(user_id):
    return Cart.query.filter_by(user_id=user_id).first()

def get_user_id_by_token(token):
    if token is None or token == "":
        raise Unauthorized("Token must be provided in Authorization header")
    if token.startswith("Bearer "):
        token = token[len("Bearer ") :]
    data = decode_auth_token(token)
    return data["id"]

def insert_book_to_cart(uid, book_id, price, quatity):
    now = datetime.now()
    print("++")
    print(uid)
    cart = get_cart_by_user_id(uid)
    if not cart:
        new_cart = Cart(
            user_id = uid,
            created_at=now,
            updated_at=now,
            is_deleted=False,
            deleted_at=now,
        )
        save_changes(new_cart)
        cart = get_cart_by_user_id(uid)
    print("===")
    print(cart.id)

    new_bookcart = BookCarts(
        book_id = book_id,
        cart_id = cart.id,
        price = price,
        quatity = quatity,
        updated_at = now,
    )cart
    save_changes(new_bookcart)
    
def save_changes(data):
    db.session.add(data)
    db.session.commit()