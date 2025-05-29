import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';
import 'routes/auth.dart';
import 'routes/posts.dart';

void main() async {
  final router = Router();

  postsRoutes(router);
  authRoutes(router);

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router.call);

  final server = await serve(handler, '0.0.0.0', 8080);
  print('✅ Mock API Server running on http://${server.address.host}:${server.port}');
}
