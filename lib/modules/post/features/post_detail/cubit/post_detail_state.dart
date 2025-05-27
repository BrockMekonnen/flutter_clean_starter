part of 'post_detail_cubit.dart';

sealed class PostDetailState extends Equatable {
  const PostDetailState();

  @override
  List<Object> get props => [];
}

final class PostDetailInitial extends PostDetailState {}

final class PostDetailLoading extends PostDetailState {}

final class PostDetailSuccess extends PostDetailState {
  final Post post;

  const PostDetailSuccess(this.post);

  @override
  List<Object> get props => [post];
}

final class PostDetailFailure extends PostDetailState {
  final String message;

  const PostDetailFailure(this.message);

  @override
  List<Object> get props => [message];
}
