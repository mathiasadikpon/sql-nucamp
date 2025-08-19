from flask import Blueprint, jsonify, abort, request
from ..models import User, db, Tweet, likes_table

bp = Blueprint('users', __name__, url_prefix='/users')