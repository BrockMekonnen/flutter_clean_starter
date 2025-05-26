part of 'post_listing_bloc.dart';

class PostListingState extends Equatable {
  final Status status;
  final List<PostListItem> posts;
  final bool last;
  final int page;
  final String error;

  const PostListingState({
    this.status = Status.initial,
    this.posts = const <PostListItem>[],
    this.last = false,
    this.page = 0,
    this.error = "",
  });

  PostListingState copyWith({
    Status? status,
    List<PostListItem>? posts,
    bool? last,
    int? page,
    String? error,
  }) =>
      PostListingState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        page: page ?? this.page,
        last: last ?? this.last,
        error: error ?? this.error,
      );

  @override
  List<Object> get props => [status, posts, page, last, error];
}
