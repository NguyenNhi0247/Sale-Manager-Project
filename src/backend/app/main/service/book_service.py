from app.main import db
from app.main.model.book import Book
from app.main.model.category import Category



def list_categories(limit=10, offset=0):
    return Category.query.order_by(Category.id).limit(limit).offset(offset).all()


def get_book_id_by_name(book_name):
    book = Book.query.filter_by(title=book_name).first()
    return book.id


def get_book_by_category(category):
    result = []
    list_book = list_books(100, 0)
    for book in list_book:
        if category in book.categories:
            result.append(book)
    return result[:10]


def get_book_by_prefixStr(prefixStr):
    result = []
    if prefixStr == None:
        return result
    list_book = list_books(100, 0)
    for book in list_book:
        if book.title.startswith(prefixStr):
            result.append({"id":book.id,"title":book.title})
    return result[:10]


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

def create_book(bid, data):
    list_author = []
    list_category=[]
    list_author += list_author.append(data["authors"].split(","))
    list_category += list_category.append(data["authors"].split(","))
    new_book = Book(
            title=data["title"],
            sub_title=data["sub_title"],
            description=data["description"],
            long_description=data["long_description"],
            authors=list_author,
            categories=list_category,
            price=data["price"],
            publisher=data["publisher"],
            published_at=data["published_at"],
            published_place=data["published_place"],
        )
    save_changes(new_book)


def delete_book(bid):
    print(bid)
    db.session.query(Book).filter_by(id=bid).update(
        {
            "is_deleted": True 
        }
    )
    db.session.commit()


def save_changes(data):
    db.session.add(data)
    db.session.commit()