import logging
import json
from datetime import datetime, timezone
from app.main import db

from app.main.model.cart import Cart
from app.main.model.book_carts import BookCarts
from app.main.model.user_addresses import UserAddresses
from app.main.model.user_payments import UserPayments

from ..util.jwt import decode_auth_token
from app.main.service.book_service import get_book_by_id

from app.main.service.user_service import get_user_by_id

log = logging.getLogger("cart.service")
log.setLevel(logging.DEBUG)


def get_cart_by_user_id(user_id):
    return Cart.query.filter_by(user_id=user_id).first()


def get_book_carts_by_card_id(cart_id):
    return BookCarts.query.filter_by(cart_id=cart_id).all()


def get_book_carts_by_book_id(book_id):
    return BookCarts.query.filter_by(book_id=book_id).all()


def remove_book_in_book_carts(book_id):
    deleted = BookCarts.query.filter_by(book_id=book_id).delete()
    db.session.commit()
    return deleted


def insert_book_to_cart(uid, book_id, price, quantity):
    now = datetime.now()
    cart = get_cart_by_user_id(uid)
    if not cart:  # Not found cart => Create new one
        new_cart = Cart(
            user_id=uid,
            created_at=now,
            updated_at=now,
            is_deleted=False,
            deleted_at=now,
        )
        save_changes(new_cart)
        cart = get_cart_by_user_id(uid)
    book_carts = get_book_carts_by_card_id(cart.id)
    book_cart = get_book_carts_by_book_id(book_id)
    if book_cart:
        book_carts.quantity = book_cart.quantity + quantity
        db.session.commit()
    else:
        new_bookcart = BookCarts(
            book_id=book_id,
            cart_id=cart.id,
            price=price,
            quantity=quantity,
            updated_at=now,
        )
        save_changes(new_bookcart)


def get_books_from_user_cart(uid):
    cart = get_cart_by_user_id(uid)
    result = []
    if cart:
        list_book_cart = get_book_carts_by_card_id(cart.id)
        for book_cart in list_book_cart:
            book = get_book_by_id(book_cart.book_id)
            result.append(book)
        return result
    return result


def remove_book_from_cart(user_id, book_id):
    cart = get_cart_by_user_id(user_id)
    list_book_cart = get_book_carts_by_card_id(cart.id)
    for book_cart in list_book_cart:
        if book_cart.book_id == book_id:
            print(book_cart)
            remove_book_in_book_carts(book_id)


def list_items_in_cart(uid):
    cart = get_cart_by_user_id(uid)
    return db.session.query(BookCarts).filter_by(cart_id=cart.id).all()


def save_changes(data):
    db.session.add(data)
    db.session.commit()

