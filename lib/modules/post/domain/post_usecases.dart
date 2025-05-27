import '../../../_core/error/failures.dart';
import '../../../_shared/domain/cqrs.dart';
import 'post.dart';
import 'post_list_item.dart';
import 'post_repository.dart';
import 'package:dartz/dartz.dart';

class PostUsecases {
  final PostRepository _postRepository;

  PostUsecases(this._postRepository);

  Future<Either<Failure, Post>> getPost(String id) {
    return _postRepository.getPost(id);
  }

  Future<Either<Failure, void>> deletePost(String id) {
    return _postRepository.deletePost(id);
  }

  Future<Either<Failure, Post>> publishPost(String id) {
    return _postRepository.publishPost(id);
  }

  Future<Either<Failure, Post>> storePost(String title, String content, {String? id}) {
    return _postRepository.storePost(title, content, id: id);
  }

  Future<Either<Failure, QueryResult<List<PostListItem>>>> fetchPosts(
      Pagination params, bool fetchMine) {
    return _postRepository.fetchPosts(params, fetchMine);
  }
}
