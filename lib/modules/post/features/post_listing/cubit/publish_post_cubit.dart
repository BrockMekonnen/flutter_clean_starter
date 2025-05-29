import 'package:bloc/bloc.dart';
import 'package:clean_starter/modules/post/domain/post.dart';
import 'package:clean_starter/modules/post/domain/post_usecases.dart';
import 'package:equatable/equatable.dart';

part 'publish_post_state.dart';

class PublishPostCubit extends Cubit<PublishPostState> {
  final PostUsecases _postUsecases;

  PublishPostCubit({required PostUsecases postUsecases})
      : _postUsecases = postUsecases,
        super(PublishPostInitial());

  void publish(String id) async {
    emit(PublishPostLoading());
    final result = await _postUsecases.publishPost(id);
    emit(result.fold(
      (error) => PublishPostFailure(error.getMessage()),
      (post) => PublishPostSuccess(post),
    ));
  }
}
