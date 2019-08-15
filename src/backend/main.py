from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/")
def hello_world():
    return "Hello, World!"


@app.route("/api/v1/ping")
def ping():
    return "pong"


@app.route("/api/v1/json")
def json():
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
