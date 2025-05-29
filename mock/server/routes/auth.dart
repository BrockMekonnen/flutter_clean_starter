import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

void authRoutes(Router router) {
  router.post('/api/users/login', (Request request) async {
    final res = {
      "data": {"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"}
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });

  router.post('/api/users', (Request request) async {
    final res = {"data": "wJgx143n"};
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });

  router.get('/api/users/me', (Request request) async {
    final res = {
      "data": {
        "id": "kePXrgn5",
        "firstName": "Jane",
        "lastName": "Doe",
        "phone": "+1 123 456 7890",
        "email": "janedoe@test.com",
        "roles": ["user"],
        "createdAt": "2025-04-03T08:05:56.180246Z",
        "updatedAt": "2025-04-03T08:05:56.180247Z"
      }
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });

  router.get('/api/users', (Request request) async {
    final res = {
      "data": [
        {
          "id": "kePXrgn5",
          "firstName": "Jane",
          "lastName": "Doe",
          "phone": "+1 123 456 7890",
          "email": "janedoe@test.com",
          "roles": ["user"],
          "createdAt": "2025-04-03T08:05:56.180246Z",
          "updatedAt": "2025-04-03T08:05:56.180247Z"
        },
        {
          "id": "1VgMD7XY",
          "firstName": "Jary",
          "lastName": "Doe",
          "phone": "+11234567899",
          "email": "jarydoe@test.com",
          "roles": ["user"],
          "createdAt": "2025-05-26T15:04:38.423933Z",
          "updatedAt": "2025-05-26T15:04:38.423934Z"
        },
        {
          "id": "wJgx143n",
          "firstName": "Jane",
          "lastName": "Doe",
          "phone": "+1 123 456 7895",
          "email": "janedoe5@test.com",
          "roles": ["user"],
          "createdAt": "2025-05-29T12:52:20.243668Z",
          "updatedAt": "2025-05-29T12:52:20.243668Z"
        }
      ],
      "page": {
        "current": 1,
        "pageSize": 10,
        "totalPages": 1,
        "totalElements": 3,
        "first": true,
        "last": true
      }
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });

  router.get('/api/users/<id>', (Request request) async {
    final id = request.params['id'];
    final res = {
      "data": {
        "id": id,
        "firstName": "Jane",
        "lastName": "Doe",
        "phone": "+1 123 456 7890",
        "email": "janedoe@test.com",
        "roles": ["user"],
        "createdAt": "2025-04-03T08:05:56.180246Z",
        "updatedAt": "2025-04-03T08:05:56.180247Z"
      }
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });
}
