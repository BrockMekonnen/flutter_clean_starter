import 'package:bloc/bloc.dart';
import 'package:clean_starter/_shared/utils/utils.dart';
import '../../../../../_core/status.dart';
import '../../../../../_shared/domain/cqrs.dart';
import '../../../domain/post_list_item.dart';
import '../../../domain/post_usecases.dart';
import 'package:equatable/equatable.dart';

part 'post_listing_event.dart';
part 'post_listing_state.dart';

const int _limit = 10;

class PostListingBloc extends Bloc<PostListingEvent, PostListingState> {
  final PostUsecases _postUsecases;

  PostListingBloc({required PostUsecases postUsecases})
      : _postUsecases = postUsecases,
        super(PostListingState()) {
    on<FetchPostListingEvent>(
      _fetchPosts,
      transformer: GlobalUtils.throttleDroppable(),
    );
    on<RefreshPostListingEvent>(
      _refreshPosts,
    );
  }

  void _fetchPosts(
    FetchPostListingEvent event,
    Emitter<PostListingState> emit,
  ) async {
    if (state.last) return;
    emit(state.copyWith(status: Status.loading));
    final result = await _postUsecases.fetchPosts(Pagination(state.page + 1, _limit));
    emit(result.fold(
      (e) => state.copyWith(status: Status.failure, error: e.getMessage()),
      (data) => state.copyWith(
        status: Status.success,
        posts: List.of(state.posts)..addAll(data.data ?? []),
        page: data.page?.current,
        last: data.page?.last,
      ),
    ));
  }

  void _refreshPosts(
    RefreshPostListingEvent event,
    Emitter<PostListingState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _postUsecases.fetchPosts(Pagination(1, _limit));
    emit(result.fold(
      (e) => state.copyWith(status: Status.failure, error: e.getMessage()),
      (data) => state.copyWith(
        status: Status.success,
        posts: data.data ?? [],
        page: data.page?.current,
        last: data.page?.last,
      ),
    ));
  }
}
