import 'package:clean_starter/_shared/data/models/result_page_model.dart';
import 'package:clean_starter/modules/post/data/models/post_list_item_model.dart';
import 'package:clean_starter/modules/post/data/models/post_model.dart';

import '../../../_core/error/exceptions.dart';
import '../../../_shared/domain/cqrs.dart';
import '../../../_core/error/failures.dart';
import '../../../_core/network_info.dart';
import '../domain/post.dart';
import '../domain/post_list_item.dart';
import '../domain/post_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

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
  Future<Either<Failure, String>> createPost(String title, String content) async {
    if (await networkInfo.isConnected()) {
      try {
        String path = "/posts";
        final res = await dio.post(path, data: {
          "title": title,
          "content": content,
        });
        String postId = res.data['data'];
        return Right(postId);
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
  Future<Either<Failure, QueryResult<List<PostListItem>>>> fetchPosts(
      Pagination params) async {
    if (await networkInfo.isConnected()) {
      try {
        String path = "/posts";
        final res = await dio.get(path);
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
  Future<Either<Failure, void>> publishPost(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        String path = "/posts/publish/$id";
        await dio.get(path);
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
  Future<Either<Failure, String>> updatePost(
      String id, String title, String content) async {
    if (await networkInfo.isConnected()) {
      try {
        String path = "/posts/$id";
        final res = await dio.patch(path, data: {
          "title": title,
          "content": content,
        });
        String postId = res.data['data'];
        return Right(postId);
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
