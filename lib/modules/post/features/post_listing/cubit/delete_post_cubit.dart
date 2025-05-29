import 'package:bloc/bloc.dart';
import 'package:clean_starter/modules/post/domain/post_usecases.dart';
import 'package:equatable/equatable.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  final PostUsecases _postUsecases;

  DeletePostCubit({required PostUsecases postUsecases})
      : _postUsecases = postUsecases,
        super(DeletePostInitial());

  void onDelete(String id) async {
    emit(DeletePostLoading());
    final result = await _postUsecases.deletePost(id);
    emit(result.fold(
      (error) => DeletePostFailure(error.getMessage()),
      (_) => DeletePostSuccess(id),
    ));
  }
}
