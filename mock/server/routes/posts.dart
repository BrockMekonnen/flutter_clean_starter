import 'dart:convert';
import 'dart:math';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

String generateRandomId([int length = 8]) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rand = Random.secure();
  return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
}

void postsRoutes(Router router) {
  router.get('/api/posts', (Request request) async {
    final res = {
      "data": [
        {
          "id": "nqPkAgxX",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "PUBLISHED",
          "postedAt": "2025-05-26T10:37:11.638134Z",
          "createdAt": "2025-05-26T10:06:53.457345Z"
        },
        {
          "id": "kePXrgn5",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "PUBLISHED",
          "postedAt": "2025-05-26T10:39:07.857392Z",
          "createdAt": "2025-05-24T07:01:54.671985Z"
        }
      ],
      "page": {
        "current": 1,
        "pageSize": 10,
        "totalPages": 1,
        "totalElements": 2,
        "first": true,
        "last": true
      }
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });
  router.get('/api/users/me/posts', (Request request) async {
    final res = {
      "data": [
        {
          "id": "nqPkAgxX",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "PUBLISHED",
          "postedAt": "2025-05-26T10:37:11.638134Z",
          "createdAt": "2025-05-26T10:06:53.457345Z"
        },
        {
          "id": "eRPpzgdW",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:53.14358Z"
        },
        {
          "id": "bEgoR79d",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:52.810325Z"
        },
        {
          "id": "jmPz14Ao",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:52.486966Z"
        },
        {
          "id": "967dr4Zx",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:52.156281Z"
        },
        {
          "id": "pl7ADPGk",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:51.627836Z"
        },
        {
          "id": "zXPQV7Bk",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:50.625214Z"
        },
        {
          "id": "8a4avPQW",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:50.307928Z"
        },
        {
          "id": "jQPGwP0d",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:49.882034Z"
        },
        {
          "id": "nmgvjgaW",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:49.356496Z"
        },
        {
          "id": "RXg3r7Wb",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:48.865485Z"
        },
        {
          "id": "MJ49Q4mb",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:47.826002Z"
        },
        {
          "id": "2ag1l7Bo",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:47.570936Z"
        },
        {
          "id": "2y7Ybgw8",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T10:06:47.317006Z"
        },
        {
          "id": "qM7JqP2n",
          "title": "Understanding the Go Clean Architecture",
          "content":
              "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
          "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
          "state": "DRAFT",
          "postedAt": null,
          "createdAt": "2025-05-26T09:45:23.372273Z"
        }
      ],
      "page": {
        "current": 1,
        "pageSize": 15,
        "totalPages": 2,
        "totalElements": 25,
        "first": true,
        "last": true
      }
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });

  router.post('/api/posts', (Request request) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);
    final title = data['title'];
    final content = data['content'];
    final newId = generateRandomId();
    final now = DateTime.now().toUtc().toIso8601String();
    final res = {
      "data": {
        "id": newId,
        "title": title,
        "content": content,
        "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
        "state": "DRAFT",
        "postedAt": null,
        "createdAt": now,
        "updatedAt": now,
        "comments": []
      }
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });

  router.patch('/api/posts/<id>', (Request request) async {
    final id = request.params['id'];
    final body = await request.readAsString();
    final data = jsonDecode(body);
    final title = data['title'];
    final content = data['content'];
    final now = DateTime.now().toUtc().toIso8601String();

    final res = {
      "data": {
        "id": id,
        "title": title,
        "content": content,
        "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
        "state": "DRAFT",
        "postedAt": null,
        "createdAt": "2025-05-29T13:28:06.026725Z",
        "updatedAt": now,
        "comments": []
      }
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });

  router.get('/api/posts/<id>', (Request request) async {
    final id = request.params['id'];

    final res = {
      "data": {
        "id": id,
        "title": "Quick Tips for Better Productivity!!",
        "content":
            "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
        "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
        "state": "DRAFT",
        "postedAt": null,
        "createdAt": "2025-05-26T10:06:47.317006Z",
        "updatedAt": "2025-05-29T13:30:50.316761Z",
        "comments": []
      }
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });

  router.patch('/api/posts/<id>/publish', (Request request) async {
    final id = request.params['id'];
    final now = DateTime.now().toUtc().toIso8601String();

    final res = {
      "data": {
        "id": id,
        "title": "Quick Tips for Better Productivity!!",
        "content":
            "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
        "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
        "state": "PUBLISHED",
        "postedAt": now,
        "createdAt": "2025-05-26T10:06:47.317006Z",
        "updatedAt": now,
        "comments": []
      }
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });

  router.patch('/api/posts/<id>', (Request request) async {
    final id = request.params['id'];
    final now = DateTime.now().toUtc().toIso8601String();

    final res = {
      "data": {
        "id": id,
        "title": "Quick Tips for Better Productivity!!",
        "content":
            "In this post, we explore how to implement clean architecture principles in a Go web application using layered structure, dependency inversion, and modular boundaries.",
        "user": {"id": "kePXrgn5", "firstName": "Jane", "lastName": "Doe"},
        "state": "PUBLISHED",
        "postedAt": now,
        "createdAt": "2025-05-26T10:06:47.317006Z",
        "updatedAt": now,
        "comments": []
      }
    };
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });

  router.patch('/api/posts/<id>', (Request request) async {
    final res = {};
    return Response.ok(jsonEncode(res), headers: {
      'Content-Type': 'application/json',
    });
  });
}
