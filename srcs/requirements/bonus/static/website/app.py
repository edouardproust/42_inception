from flask import Flask, render_template

# Create Flask application
app = Flask(__name__)

# Set main route to return templates/index.html
@app.route("/")
def index():
    return render_template("index.html")

# Run app on port 5000
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

