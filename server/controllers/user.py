import jwt
from flask import request, jsonify, make_response

from .. import db
from .. import sk
from ..models.user import User


class UserController:

    def __init__(self, app):
        pass

    @staticmethod
    def list_all_users():
        users = User.query.all()
        response = []
        for user in users: response.append(user.toDict())
        return jsonify(response)

    @staticmethod
    def create_user():
        # Check if request is JSON
        if not request.is_json:
            return jsonify({'error': 'Request must be in JSON format'}), 400
        try:
            user_data = request.get_json()
            uname = user_data['username']
            email = user_data['email']
        except KeyError:
            return jsonify({'error': 'Missing required fields in JSON data'}), 400

        try:
            # Check if username or email already exists
            if User.query.filter_by(username=uname).first() or User.query.filter_by(email=email).first():
                return jsonify({'error': 'Username or email already exists'}), 409

            new_user = User(
                username=user_data['username'],
                email=user_data['email'],
                password=user_data['password'],
                role=user_data['role'],
                mdeta=user_data['metadata'],
            )

            db.session.add(new_user)
            db.session.commit()
        except Exception as e:  # Catch any validation errors
            # Raise a custom BadRequest exception with the user-friendly error message
            return jsonify({'error': ''}), 400

        token = jwt.encode({'user_id': new_user.id}, sk, algorithm="HS256")
        response = make_response(jsonify({'error': 'Success', 'user_id': new_user.id,'token': token}))

        return response, 200

    @staticmethod
    def retrieve_users(username):
        response = User.query.filter_by(username=username).first()
        if response:
            return jsonify(response.toDict())
        return jsonify({'error':'Invalid user'})

    @staticmethod
    def update_user(username):
        if not request.is_json:
            return jsonify({'error': 'Request must be in JSON format'}), 400
        try:
            user_data = request.get_json()
        except KeyError:
            return jsonify({'error': 'Missing required fields in JSON data'}), 400

        try:
            user = User.query.filter_by(username=username).first()

            user.email = user_data['email']
            user.username = user_data['username']
            user.role = user_data['role']
            user.password = user_data['password']
            user.mdeta = user_data['metadata']
            db.session.commit()
        except Exception as e:
            print(str(e))
            return jsonify({'error': ''}), 200

        return jsonify({'error': 'new user added'}), 200

    @staticmethod
    def delete_user(username):
        User.query.filter_by(username=username).delete()
        db.session.commit()

        return ('User "{}" deleted successfully!').format(username)

    @staticmethod
    def login():
        if (request.headers['Content-Type'] != 'application/json; charset=utf-8') and (request.headers['Content-Type'] != 'application/json'):
            return jsonify({'error': 'Unsupported Media Type', 'code': 2}), 415

        uname = request.json.get('username')
        password = request.json.get('password')

        user = User.query.filter_by(username=uname).first()
        response = make_response(jsonify({'message': 'Login failed', 'code': 2}))

        if user:
            if user.toDict()['username'] == uname and user.toDict()['password'] == password:
                token = jwt.encode(
                    {'user_id': user.toDict()['id']}, sk, algorithm="HS256")
                response = make_response(
                    jsonify({'message': 'Login successful', 'code': 1, 'token': token}))

        return response, 200
