from app.main import db
from app.main.model.book import Book


def get_book_by_id(bid):
    return Book.query.filter_by(id=bid).first()


def list_books(limit=10, offset=0):
    return Book.query.order_by(Book.id).limit(limit).offset(offset).all()


def update_book(bid, data):
    book = get_book_by_id(bid)
    if book:
        book.title = data["title"]
        book.sub_title = data["sub_title"]
        book.description = data["description"]
        book.long_description = data["long_description"]
        # TODO
        # book.authors = data["authors"].split(",")
        # book.categories = data["categories"].split(",")
        book.price = data["price"]
        book.publisher = data["publisher"]
        book.published_at = data["published_at"]
        book.published_place = data["published_place"]
        db.session.commit()
    else:
        new_book = Book(
            title=data["title"],
            sub_title=data["sub_title"],
            description=data["description"],
            long_description=data["long_description"],
            # TODO
            # authors=data["authors"].split(","),
            # categories=data["categories"].split(","),
            price=data["price"],
            publisher=data["publisher"],
            published_at=data["published_at"],
            published_place=data["published_place"],
        )
        save_changes(new_book)


def increase_purchased(book_id, quantity):
    book = get_book_by_id(book_id)
    book.total_purchased += quantity
    save_changes(book)


def delete_book(bid):
    book = get_book_by_id(bid)
    book.is_deleted=True
    book.deleted_at= datetime.now()
    save_changes(book)


def save_changes(data):
    db.session.add(data)
    db.session.commit() 
