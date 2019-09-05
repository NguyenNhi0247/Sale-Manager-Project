import logging
from datetime import datetime, timezone
from app.main import db

from app.main.model.cart import Cart
from app.main.model.book_carts import BookCarts
from ..util.jwt import decode_auth_token
from app.main.service.book_service import get_book_by_id
from app.main.service.user_service import get_user_by_id

log = logging.getLogger("cart.service")
log.setLevel(logging.DEBUG)

def get_cart_by_user_id(user_id):
    return Cart.query.filter_by(user_id=user_id).first()

def insert_book_to_cart(uid, book_id, price, quantity):
    now = datetime.now()
    log.info("++")
    log.info(uid)

    cart = get_cart_by_user_id(uid)
    if not cart: # Not found cart => Create new one
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
        quantity = quantity,
        updated_at = now,
    )
    save_changes(new_bookcart)
    
def save_changes(data):
    db.session.add(data)
    db.session.commit()
