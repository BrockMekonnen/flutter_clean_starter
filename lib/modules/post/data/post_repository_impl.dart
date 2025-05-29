import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../_core/error/exceptions.dart';
import '../../../_core/error/failures.dart';
import '../../../_core/network_info.dart';
import '../../../_shared/data/models/result_page_model.dart';
import '../../../_shared/domain/cqrs.dart';
import '../domain/post.dart';
import '../domain/post_list_item.dart';
import '../domain/post_repository.dart';
import 'models/post_list_item_model.dart';
import 'models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final Dio dio;
  final HiveInterface hive;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.dio,
    required this.hive,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Post>> storePost(String title, String content,
      {String? id}) async {
    if (await networkInfo.isConnected()) {
      try {
        var data = {"title": title, "content": content};
        late Response<dynamic> res;
        if (id != null) {
          res = await dio.patch("/posts/$id", data: data);
        } else {
          res = await dio.post("/posts", data: data);
        }

        return Right(PostModel.fromJson(res.data['data']));
      } catch (error) {
        if (error is DioException) {
          final message = DioExceptions.fromDioError(error).toString();
          return Left(ServerFailure(message));
        }
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        String path = "/posts/$id";
        await dio.delete(path);
        return Right(null);
      } catch (error) {
        if (error is DioException) {
          final message = DioExceptions.fromDioError(error).toString();
          return Left(ServerFailure(message));
        }
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> getPost(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        String path = "/posts/$id";
        final res = await dio.get(path);
        return Right(PostModel.fromJson(res.data['data']));
      } catch (error) {
        if (error is DioException) {
          final message = DioExceptions.fromDioError(error).toString();
          return Left(ServerFailure(message));
        }
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> publishPost(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        String path = "/posts/$id/publish";
        final res = await dio.patch(path);
        return Right(PostModel.fromJson(res.data['data']));
      } catch (error) {
        if (error is DioException) {
          final message = DioExceptions.fromDioError(error).toString();
          return Left(ServerFailure(message));
        }
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, QueryResult<List<PostListItem>>>> fetchPosts(
      Pagination params, bool fetchMine) async {
    if (await networkInfo.isConnected()) {
      try {
        String path = fetchMine ? "/users/me/posts" : "/posts";
        final res = await dio
            .get(path, queryParameters: {"page": params.page, "limit": params.pageSize});
        final posts = <PostListItem>[];
        res.data['data'].forEach((e) => posts.add(PostListItemModel.fromJson(e)));
        return Right(QueryResult(
          data: posts,
          page: ResultPageModel.fromJson(res.data['page']),
        ));
      } catch (error) {
        if (error is DioException) {
          final message = DioExceptions.fromDioError(error).toString();
          return Left(ServerFailure(message));
        }
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
