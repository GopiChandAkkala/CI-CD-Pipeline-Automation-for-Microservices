# Import the Flask module
from flask import Flask

# Create a Flask web application
app = Flask(__name__)

# Define a route and a view function
@app.route('/')
def hello():
    return 'Hello, World!'

# Run the application if this script is the main program
if __name__ == '__main__':
    app.run(debug=True)

