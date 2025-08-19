from flask import Blueprint, jsonify, abort, request
from ..models import User, db, Tweet, likes_table
import hashlib
import secrets

def scramble(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()

bp = Blueprint('users', __name__, url_prefix='/users')

@bp.route('', methods=['GET']) # decorator takes path and list of HTTP verbs
def index():
    users = User.query.all() # ORM performs SELECT query
    result = []
    for u in users:
        result.append(u.serialize()) # build list of Users as dictionaries
    return jsonify(result)  # return JSON response

@bp.route('/<int:id>', methods=['GET'])
def show(id: int): # get user by id
    u = User.query.get_or_404(id)
    return jsonify(u.serialize())

@bp.route('', methods=['POST'])
def create():
    # req body must contain username and password
    if 'username' not in request.json or 'password' not in request.json:
        return abort(400)
    
    # if the username value is not at least 3 characters long, or the password value is not at least 8 characters long, return with an abort of 400 as well
    if len(request.json['username']) < 3 or len(request.json['password']) < 8:
        return abort(400)

    # construct User
    u = User(
        username=request.json['username'],
        password=scramble(request.json['password'])
    )

    db.session.add(u)  # prepare CREATE statement
    db.session.commit()  # execute CREATE statement

    return jsonify(u.serialize())

# Task 5: Implement Delete User endpoint
@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    u = User.query.get_or_404(id)
    try:
        db.session.delete(u)  # prepare DELETE statement
        db.session.commit()  # execute DELETE statement
        return jsonify(True)
    except:
        # something went wrong :(
        return jsonify(False)

# Task 6: Implement Update User endpoint
# In this task, you will write code to handle a PUT or PATCH request made to http://localhost:3000/users/:id.
@bp.route('/<int:id>', methods=['PUT', 'PATCH'])
def update(id: int):
    # check if user with id exists
    # if not, return with an abort of 404
    u = User.query.get_or_404(id)

    # req body must contain at least one of username or password
    # if neither username nor password is provided, return with an abort of 400
    if 'username' not in request.json and 'password' not in request.json:
        return abort(400)
    
    # if the request body contains a username field, update the user's username to that value
    # the username must be at least 3 characters long
    if 'username' in request.json:
        if len(request.json['username']) < 3:
            return abort(400)
        u.username = request.json['username']

    # if the request body contains a password field, update the user's password to that value
    # the password must be at least 8 characters long, if not, return with an
    if 'password' in request.json:
        if len(request.json['password']) < 8:
            return abort(400)
        u.password = scramble(request.json['password'])

    try:
        db.session.commit()  # execute UPDATE statement
        return jsonify(u.serialize())
    except:
        # something went wrong :(
        return jsonify(False)
    
# Task 8: Implement Liked Tweets endpoint
@bp.route('/<int:id>/liked_tweets', methods=['GET'])
def liked_tweets(id: int):
    u = User.query.get_or_404(id)
    result = []
    for t in u.liked_tweets:
        result.append(t.serialize())
    return jsonify(result)