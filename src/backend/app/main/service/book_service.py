from app.main.model.book import Book


def get_book_by_id(bid):
    return Book.query.filter_by(id=bid).first()


def get_book(limit=10, offset=0):
    return Book.query.limit(limit).offset(offset).all()
