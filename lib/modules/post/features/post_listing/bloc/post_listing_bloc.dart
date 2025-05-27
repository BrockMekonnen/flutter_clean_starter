import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../_shared/domain/cqrs.dart';
import '../../../domain/post.dart';
import '../../../domain/post_list_item.dart';
import '../../../domain/post_usecases.dart';

part 'post_listing_event.dart';

const int _limit = 15;

class PostListingBloc extends Bloc<PostListingEvent, PagingState<int, PostListItem>> {
  final PostUsecases _postUsecases;

  PostListingBloc({required PostUsecases postUsecases})
      : _postUsecases = postUsecases,
        super(PagingState()) {
    on<FetchPostListingEvent>(_fetchPosts);
    on<RefreshPostListingEvent>(_refreshPosts);
    on<UpdatePostInListingEvent>(_updatePost);
    on<DeletePostFromListingEvent>(_deletePost);
  }

  void _fetchPosts(
    FetchPostListingEvent event,
    Emitter<PagingState> emit,
  ) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, error: null));
    final newKey = (state.keys?.last ?? 0) + 1;
    final result =
        await _postUsecases.fetchPosts(Pagination(newKey, _limit), event.isMyPosts);
    emit(result.fold(
      (e) => state.copyWith(
        error: e.getMessage(),
        isLoading: false,
      ),
      (data) => state.copyWith(
        pages: [...?state.pages, (data.data ?? [])],
        keys: [...?state.keys, newKey],
        hasNextPage: !(data.page?.last ?? false),
        isLoading: false,
      ),
    ));
  }

  void _refreshPosts(
    RefreshPostListingEvent event,
    Emitter<PagingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _postUsecases.fetchPosts(Pagination(1, _limit), event.isMyPosts);
    emit(result.fold(
      (e) => state.copyWith(
        error: e.getMessage(),
        isLoading: false,
      ),
      (data) => state.copyWith(
        pages: [(data.data ?? [])],
        keys: [1],
        hasNextPage: !(data.page?.last ?? false),
        isLoading: false,
      ),
    ));
  }

  void _updatePost(
    UpdatePostInListingEvent event,
    Emitter<PagingState> emit,
  ) async {
    var post = event.post;
    final newPostListItem = PostListItem(
        post.id, post.title, post.content, post.state, post.postedAt, post.user);
    List<List<PostListItem>> updatedPages = List.from(state.pages ?? []);

    if (event.isCreate) {
      // If no pages exist, create a new first page
      if (updatedPages.isEmpty) {
        updatedPages = [
          [newPostListItem]
        ];
      } else {
        updatedPages[0] = [newPostListItem, ...updatedPages[0]];
      }
    } else {
      updatedPages = updatedPages
          .map((page) => page.map((p) => p.id == post.id ? newPostListItem : p).toList())
          .toList();
    }

    emit(state.copyWith(pages: updatedPages));
  }

  void _deletePost(
    DeletePostFromListingEvent event,
    Emitter<PagingState> emit,
  ) {
    final updatedPages = state.pages
        ?.map((page) => page.where((post) => post.id != event.postId).toList())
        .where((page) => page.isNotEmpty)
        .toList();

    emit(state.copyWith(pages: updatedPages));
  }
}
