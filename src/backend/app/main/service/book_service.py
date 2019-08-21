from app.main.model.book import Book


def get_book_by_id(bid):
    return Book.query.filter_by(id=bid).first()


def get_book():
    return Book.query.all()
