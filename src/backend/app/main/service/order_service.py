import logging
import json
from datetime import datetime, timezone
from app.main import db

from app.main.model.cart import Cart
from app.main.model.book_carts import BookCarts
from app.main.model.book_orders import BookOrders
from app.main.model.user_addresses import UserAddresses
from app.main.model.user_payments import UserPayments

from app.main.model.order import Order
from ..util.jwt import decode_auth_token
from app.main.service.book_service import get_book_by_id
from app.main.service.cart_service import get_cart_by_user_id, get_book_carts_by_card_id
from app.main.service.user_service import get_user_by_id, edit_user_address, edit_user_payment

log = logging.getLogger("cart.service")
log.setLevel(logging.DEBUG)


def get_order_by_user_id(user_id):
    return Order.query.filter_by(user_id=user_id).first()

# def get_or_insert_order_by_user_id(uid):
#     now = datetime.now()
#     order = get_order_by_user_id(uid)
#     if order:
#         return str(order.total_price), str(order.discount), str(order.final_price)
#     cart = get_cart_by_user_id(uid)
#     list_book_cart = get_book_carts_by_card_id(cart.id)
#     total_price = 0
#     discount = 0 
#     final_price = 0
#     user_payment = get_user_payment_by_user_id(uid)
#     if not user_payment:
#         new_user_payment = UserPayments(
#             uid = uid,
#             type = "",
#             is_default = False,
#             card_number = "",
#             card_holder = "",
#             valid_date = now,
#             created_at = now,
#             updated_at = now,
#             is_deleted = False,
#             deleted_at = now
#         )
#         save_changes(new_user_payment)
#         user_payment = get_user_payment_by_user_id(uid)
#     user_address = get_user_address_by_user_id(uid)
#     if not user_address:
#         new_user_address = UserAddresses(
#             uid = uid,
#             receiver_name = "",
#             address = "",
#             is_default = False,
#             zip_code = "",
#             phone_number = "",
#             created_at = now,
#             updated_at = now,
#             is_deleted = False,
#             deleted_at = now
#         )
#         save_changes(new_user_address)
#         user_address = get_user_address_by_user_id(uid)

#     for book_cart in list_book_cart:
#         total_price = total_price + book_cart.price*book_cart.quantity
#         final_price = final_price + (total_price - discount)
#     new_order = Order(
#         user_id = uid,
#         user_payment_id = user_payment.id,
#         user_address_id = user_address.id,
#         total_price = total_price,
#         discount = discount,
#         final_price = final_price,
#         created_at=now,
#         updated_at=now,
#         is_deleted=False,
#         deleted_at=now,
#     )
#     save_changes(new_order)
#     return str(total_price), str(discount), str(final_price)
    
def save_changes(data):
    db.session.add(data)
    db.session.commit()
