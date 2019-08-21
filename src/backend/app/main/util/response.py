from flask import make_response, jsonify

def custom_error(message, status_code): 
    return make_response(jsonify(message), status_code)

def omit_empty(d):
    """
    Delete keys with the value ``None`` in a dictionary, recursively.

    This alters the input so you may wish to ``copy`` the dict first.
    """
    for key, value in list(d.items()):
        if value is None:
            del d[key]
        elif isinstance(value, dict):
            del_none(value)
    return d 
