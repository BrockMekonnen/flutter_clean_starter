import 'package:bloc/bloc.dart';
import 'package:clean_starter/modules/post/domain/post.dart';
import 'package:clean_starter/modules/post/domain/post_usecases.dart';
import 'package:equatable/equatable.dart';

part 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  final PostUsecases _postUsecases;

  PostDetailCubit({required PostUsecases postUsecases})
      : _postUsecases = postUsecases,
        super(PostDetailInitial());

  void getPost(String postId) async {
    emit(PostDetailLoading());
    final result = await _postUsecases.getPost(postId);
    emit(result.fold(
      (error) => PostDetailFailure(error.getMessage()),
      (post) => PostDetailSuccess(post),
    ));
  }
}
