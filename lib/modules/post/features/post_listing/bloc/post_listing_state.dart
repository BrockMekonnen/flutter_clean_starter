// part of 'post_listing_bloc.dart';

// class PostListingState extends Equatable {
//   final Status status;
//   // final List<PostListItem> posts;
//   final bool last;
//   // final int page;
//   final String error;
//   final PagingState<int, PostListItem> paging;

//   const PostListingState({
//     required this.paging,
//     this.status = Status.initial,
//     this.last = false,
//     this.error = "",
//   });

//   PostListingState copyWith({
//     PagingState<int, PostListItem>? paging,
//     Status? status,
//     bool? last,
//     String? error,
//   }) =>
//       PostListingState(
//         status: status ?? this.status,
//         paging: paging ?? this.paging,
//         // posts: posts ?? this.posts,
//         // page: page ?? this.page,
//         last: last ?? this.last,
//         error: error ?? this.error,
//       );

//   @override
//   List<Object> get props => [status, last, error];
// }
