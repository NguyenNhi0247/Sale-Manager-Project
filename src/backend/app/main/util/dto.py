from flask_restplus import Namespace, fields


class UserDto:
    api = Namespace("users", description="user related operations")
    user = api.model(
        "user",
        {
            "id": fields.String(description="user identifier"),
            "username": fields.String(required=True, description="user username"),
            "email": fields.String(required=True, description="user email address"),
            "password": fields.String(required=True, description="user password"),
        },
    )


class BookDto:
    api = Namespace("books", description="Book related operations")
    book = api.model(
        "book",
        {
            "id": fields.Integer(description="book identifier"),
            "title": fields.String(required=True, description="user username"),
            "sub_title": fields.String(description="user email address"),
            "thumbnails": fields.List(fields.String),
            "description": fields.String(description="user password"),
            "long_description": fields.String(description="long description"),
            "price": fields.Float(),
            "total_rating_point": fields.Integer(),
            "total_rated": fields.Integer(),
            "total_purchased": fields.Integer(),
            "total_purchased": fields.Integer(),
            "publisher": fields.String(),
            "published_at": fields.DateTime(),
            "published_place": fields.String(),
            "pagination": fields.String(),
            "ebooks_formats": fields.List(fields.String),
            "authors": fields.List(fields.String),
            "categories": fields.List(fields.String),
            "created_at": fields.DateTime(),
            "updated_at": fields.DateTime(),
            "is_deleted": fields.Boolean(),
            "deleted_at": fields.DateTime(),
        },
    )

# price = db.Column(db.Numeric(), nullable=False)
# total_rating_point = db.Column(db.Numeric())
# total_rated = db.Column(db.Numeric())
# total_purchased = db.Column(db.Numeric())
# publisher = db.Column(db.String(500))
# published_at = db.Column(db.DateTime())
# published_place = db.Column(db.String(500))
# pagination = db.Column(db.String(100))
# ebook_formats = db.Column(db.JSON())
# authors = db.Column(postgresql.ARRAY(postgresql.CHAR))
# categories = db.Column(postgresql.ARRAY(postgresql.CHAR))
# created_at = db.Column(db.DateTime())
# updated_at = db.Column(db.DateTime())
# is_deleted = db.Column(db.Boolean())
# deleted_at = db.Column(db.DateTime())
