part of 'publish_post_cubit.dart';

sealed class PublishPostState extends Equatable {
  const PublishPostState();

  @override
  List<Object> get props => [];
}

final class PublishPostInitial extends PublishPostState {}

final class PublishPostLoading extends PublishPostState {}

final class PublishPostSuccess extends PublishPostState {
  final Post post;

  const PublishPostSuccess(this.post);
}

final class PublishPostFailure extends PublishPostState {
  final String message;

  const PublishPostFailure(this.message);
}
