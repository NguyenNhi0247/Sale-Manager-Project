from datetime import datetime, timezone
from app.main import db

from app.main.model.cart import Cart
from app.main.model.book_carts import BookCarts
from app.main.service.book_service import get_book_by_id


def get_cart_by_user_id(user_id):
    return Cart.query.filter_by(user_id=user_id).first()

def insert_book_to_cart(user_id, book_id):
    cart = get_cart_by_user_id(user_id)
    book = get_book_by_id(book_id)
    new_bookcart = BookCarts(
        book_id = book_id,
        cart_id = cart.id,
        price = book.price,
        quality = book.quality,
        updated_at = now,
    )
    save_changes(new_bookcart)
    
def save_changes(data):
    db.session.add(data)
    db.session.commit()