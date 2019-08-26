from http import HTTPStatus


class BaseError(Exception):
    """Base Error Class"""

    def __init__(self, message="", code=400, payload=None):
        Exception.__init__(self)
        self.code = code
        self.message = message
        self.payload = payload

    def to_dict(self):
        rv = dict(self.payload or ())
        rv["message"] = self.message
        # rv["status_code"] = self.code
        # rv["status"] = HTTPStatus(self.code).phrase
        return rv


class BadRequest(BaseError):
    def __init__(self, message="Bad request", payload=None):
        BaseError.__init__(self)
        self.code = 400
        self.message = message
        self.payload = payload


class Unauthorized(BaseError):
    def __init__(self, message="Unauthorized", payload=None):
        BaseError.__init__(self)
        self.code = 401
        self.message = message
        self.payload = payload


class NotFound(BaseError):
    def __init__(self, message="Not found", payload=None):
        BaseError.__init__(self)
        self.code = 404
        self.message = message
        self.payload = payload


class Conflict(BaseError):
    def __init__(self, message="Conflict", payload=None):
        BaseError.__init__(self)
        self.code = 409
        self.message = message
        self.payload = payload


class InternalServerError(BaseError):
    def __init__(self, message="Internal server error", payload=None):
        BaseError.__init__(self)
        self.code = 500
        self.message = message
        self.payload = payload


def raiseIfExcept(e):
    if isinstance(e, BaseError):
        raise e
