import logging
from flask import Flask, send_from_directory
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt

from .config import config_by_name
from .util.error import (
    BadRequest,
    Unauthorized,
    InternalServerError,
    raiseIfExcept,
)

db = SQLAlchemy()
flask_bcrypt = Bcrypt()

app = Flask(__name__)

# Get file: GET /api/v1/files/:path
@app.route("/api/v1/files/<path:filename>")
def serve_file(filename):
    """Get file"""
    return send_from_directory('../../_data/books', filename)


@app.errorhandler(BadRequest)
@app.errorhandler(Unauthorized)
def handle_error(error):
    return error.to_dict(), getattr(error, "code")


@app.errorhandler
def default_error_handler(error):
    """Returns Internal server error"""
    error = InternalServerError()
    return error.to_dict(), getattr(error, "code", 500)


def create_app(config_name):
    CORS(app)  # Allow APIs to be called from browser's frontend
    app.config.from_object(config_by_name[config_name])
    app.url_map.strict_slashes = False
    app.logger.setLevel(logging.DEBUG)

    db.init_app(app)
    flask_bcrypt.init_app(app)

    return app


@app.before_request
def clear_trailing():
    from flask import redirect, request

    rp = request.path
    if rp != "/" and rp.endswith("/"):
        return redirect(rp[:-1])
