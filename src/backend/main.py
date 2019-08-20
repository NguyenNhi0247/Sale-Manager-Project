import json
from flask import Flask, request, jsonify

app = Flask(__name__)


def get_data():
    with open('./data.json') as json_file:
        data = json.load(json_file)
        return data


@app.route("/api/v1/books", methods=["GET"])
def get_books():
    data = get_data()
    return jsonify(data)


@app.route("/api/v1/books/<id>", methods=["GET"])
def get_book_by_id(id):
    books = get_data()
    for b in books:
        if (str(id) == str(b['id'])):
            return jsonify(b), 200
    return jsonify(), 404


def get_book_by_category(category_selected):
    books = get_data()
    result = []
    for book in books:
        for category in book['categories']:
            if (category_selected == category):
                result.append(book)
    return jsonify(result)


@app.route("/api/v1/get-book-by-category", methods=["POST"])
def category():
    category_selected = "Love"
    result = get_book_by_category(category_selected)
    return jsonify(result)









@app.route("/api/v1/json")
def get_json():
    return jsonify({"username": "Quy", "email": "a@a.com", "id": 111})


@app.route("/api/v1/post", methods=["POST"])
def postAPI():
    # Have to ask for the request Content-Type header first before decoding JSON.
    if request.is_json:
        data = request.get_json()
        print(
            "Request data: {}".format(data), flush=True
        )  # Force Flask to flush log to stdout immediately instead of buffer it
    else:
        print("Unknown request data", flush=True)
    return "ok"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port="9090")
