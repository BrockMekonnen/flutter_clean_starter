part of 'post_listing_bloc.dart';

sealed class PostListingEvent extends Equatable {
  const PostListingEvent();

  @override
  List<Object> get props => [];
}

class RefreshPostListingEvent extends PostListingEvent {
  const RefreshPostListingEvent();

  @override
  List<Object> get props => [];
}

class FetchPostListingEvent extends PostListingEvent {
  const FetchPostListingEvent();

  @override
  List<Object> get props => [];
}
