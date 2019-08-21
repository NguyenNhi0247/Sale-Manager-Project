from app.main.model.book import Book


def get_book_by_id(bid):
    return Book.query.filter_by(id=bid).first()
