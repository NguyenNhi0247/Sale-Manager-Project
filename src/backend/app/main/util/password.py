from .. import flask_bcrypt

class PasswordCrypt():
    def hash(passwd):
        return flask_bcrypt.generate_password_hash(passwd).decode("utf-8")

    def check(password, hash):
        return flask_bcrypt.check_password_hash(password, hash)
