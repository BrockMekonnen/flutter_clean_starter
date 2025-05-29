import 'package:bloc/bloc.dart';
import 'package:clean_starter/modules/post/domain/post.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/post_usecases.dart';

part 'post_edit_event.dart';
part 'post_edit_state.dart';

class PostEditBloc extends Bloc<PostEditEvent, PostEditState> {
  final PostUsecases _postUsecases;

  PostEditBloc({required PostUsecases postUsecases})
      : _postUsecases = postUsecases,
        super(PostEditInitial()) {
    on<SavePostEvent>(_savePost);
  }

  Future<void> _savePost(
    SavePostEvent event,
    Emitter<PostEditState> emit,
  ) async {
    emit(PostEditLoading());
    final result =
        await _postUsecases.storePost(event.title, event.content, id: event.id);
    emit(result.fold(
      (error) => PostEditFailure(error.getMessage()),
      (postId) => PostEditSuccess(postId),
    ));
  }
}
