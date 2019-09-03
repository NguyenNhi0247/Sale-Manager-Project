from datetime import datetime, timezone
from app.main import db

from app.main.model.cart import Cart
from app.main.model.book_carts import BookCarts
from app.main.model.book_carts import BookCarts


def get_cart_by_user_id(user_id):
    return Cart.query.filter_by(user_id=user_id).first()

def insert_book_to_cart(user_id, book_id)
    user_id = "2"
    book_id= "2"
    cart = get_cart_by_user_id(user_id)
    book = get
    new_cart = BookCarts(
        book_id = book_id
        cart_id = cart.id
        price = 
        quality = db.Column(db.Integer)
        updated_at = now,
    )
    save_changes(new_user)
    return get_user_by_username(data["username"])