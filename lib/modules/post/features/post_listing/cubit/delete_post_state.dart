part of 'delete_post_cubit.dart';

sealed class DeletePostState extends Equatable {
  const DeletePostState();

  @override
  List<Object> get props => [];
}

final class DeletePostInitial extends DeletePostState {}

final class DeletePostLoading extends DeletePostState {}

final class DeletePostSuccess extends DeletePostState {
  final String postId;

  const DeletePostSuccess(this.postId);
}

final class DeletePostFailure extends DeletePostState {
  final String message;

  const DeletePostFailure(this.message);
}
