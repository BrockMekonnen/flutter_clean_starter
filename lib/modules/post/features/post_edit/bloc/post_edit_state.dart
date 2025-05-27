part of 'post_edit_bloc.dart';

sealed class PostEditState extends Equatable {
  const PostEditState();

  @override
  List<Object> get props => [];
}

final class PostEditInitial extends PostEditState {}

final class PostEditLoading extends PostEditState {}

final class PostEditSuccess extends PostEditState {
  final Post post;

  const PostEditSuccess(this.post);
}

final class PostEditFailure extends PostEditState {
  final String message;

  const PostEditFailure(this.message);
}
