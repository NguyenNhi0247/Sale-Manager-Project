import logging
import json
from datetime import datetime, timezone
from app.main import db

from app.main.model.cart import Cart
from app.main.model.book import Book
from app.main.model.book_carts import BookCarts
from app.main.model.book_orders import BookOrders
from app.main.model.user_addresses import UserAddresses
from app.main.model.user_payments import UserPayments

from app.main.model.order import Order
from ..util.jwt import decode_auth_token
from app.main.service.book_service import get_book_by_id, increase_purchased
from app.main.service.cart_service import get_cart_by_user_id, get_book_carts_by_card_id
from app.main.service.user_service import (
    get_user_by_id,
    edit_user_address,
    edit_user_payment,
)
from .cart_service import get_book_carts_by_card_id, delete_item_in_cart

log = logging.getLogger("cart.service")
log.setLevel(logging.DEBUG)


def get_order_by_user_id(user_id):
    return Order.query.filter_by(user_id=user_id).first()


def process_order(user_id, data):
    # Create new oder
    now = datetime.now()
    order = Order(
        user_id=data["user_id"],
        user_payment_id=data["user_payment_id"],
        user_address_id=data["user_address_id"],
        total=data["total"],
        discount=data["discount"],
        shipping_fee=data["shipping_fee"],
        created_at=now,
        updated_at=now,
        is_deleted=False,
        deleted_at=now,
    )
    save_changes(order)

    # Move all items from book_carts to book_orders
    cart = get_cart_by_user_id(user_id)
    items = get_book_carts_by_card_id(cart.id)
    for item in items:
        bo = BookOrders(
            order_id=order.id,
            book_id=item.book_id,
            price=item.price,
            quantity=item.quantity,
            updated_at=now,
        )
        save_changes(bo)
        delete_item_in_cart(item.cart_id, item.book_id)
        # Increase the number of times this book has been purchased
        increase_purchased(item.book_id, item.quantity)

    return order


def save_changes(data):
    db.session.add(data)
    db.session.commit()


def list_all_orders(user_id):
    return Order.query.filter_by(user_id=user_id).order_by(Order.created_at).all()


def get_book_orders_by_order_id(order_id):
    return db.session.query(BookOrders).filter_by(order_id=order_id).all()


def list_all_purchased_books(user_id):
    orders = list_all_orders(user_id)
    bookIDs = []
    for order in orders:
        items = get_book_orders_by_order_id(order.id)
        for item in items:
            if item.id not in bookIDs:
                bookIDs.append(item.book_id)

    # Find all books in list of bookIDs
    return db.session.query(Book).filter(Book.id.in_(bookIDs)).all()
