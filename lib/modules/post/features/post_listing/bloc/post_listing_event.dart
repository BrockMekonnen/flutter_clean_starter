part of 'post_listing_bloc.dart';

sealed class PostListingEvent extends Equatable {
  const PostListingEvent();

  @override
  List<Object> get props => [];
}

class RefreshPostListingEvent extends PostListingEvent {
  const RefreshPostListingEvent({required this.isMyPosts});

  final bool isMyPosts;

  @override
  List<Object> get props => [];
}

class FetchPostListingEvent extends PostListingEvent {
  const FetchPostListingEvent({required this.isMyPosts});

  final bool isMyPosts;

  @override
  List<Object> get props => [];
}

class UpdatePostInListingEvent extends PostListingEvent {
  final Post post;
  final bool isCreate;
  const UpdatePostInListingEvent(this.post, {this.isCreate = false});

  @override
  List<Object> get props => [post];
}

class DeletePostFromListingEvent extends PostListingEvent {
  final String postId;
  const DeletePostFromListingEvent(this.postId);

  @override
  List<Object> get props => [postId];
}
