import 'package:clean_starter/modules/post/domain/post.dart';
import 'package:dartz/dartz.dart';

import '../../../_shared/domain/cqrs.dart';
import '../../../_core/error/failures.dart';
import 'post_list_item.dart';

abstract class PostRepository {
  Future<Either<Failure, Post>> getPost(String id);
  Future<Either<Failure, void>> deletePost(String id);
  Future<Either<Failure, void>> publishPost(String id);
  Future<Either<Failure, String>> createPost(String title, String content);
  Future<Either<Failure, String>> updatePost(String id, String title, String content);
  Future<Either<Failure, QueryResult<List<PostListItem>>>> fetchPosts(Pagination params);
}
