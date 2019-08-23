from app.main.model.book import Book


def get_book_by_id(bid):
    return Book.query.filter_by(id=bid).first()


def list_books(limit=10, offset=0):
    return Book.query.order_by(Book.id).limit(limit).offset(offset).all()
