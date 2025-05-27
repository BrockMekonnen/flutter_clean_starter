import 'package:clean_starter/modules/post/features/post_edit/bloc/post_edit_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../_core/constants.dart';
import '../../_core/di.dart';
import '../../_core/layout/adaptive_layout/adaptive_destination.dart';
import 'data/post_repository_impl.dart';
import 'domain/post_repository.dart';
import 'domain/post_usecases.dart';
import 'features/post_detail/cubit/post_detail_cubit.dart';
import 'features/post_listing/bloc/post_listing_bloc.dart';
import 'features/post_listing/cubit/delete_post_cubit.dart';
import 'features/post_listing/cubit/publish_post_cubit.dart';
import 'post_routes.dart';

Future<void> registerPostModule() async {
  //* inject repositories
  di.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(dio: di(), hive: di(), networkInfo: di()));

  //* inject usecases
  di.registerLazySingleton<PostUsecases>(() => PostUsecases(di()));

  //* inject blocs & cubits
  di.registerFactory(() => PostListingBloc(postUsecases: di()));
  di.registerFactory(() => PostEditBloc(postUsecases: di()));
  di.registerFactory(() => PostDetailCubit(postUsecases: di()));
  di.registerFactory(() => DeletePostCubit(postUsecases: di()));
  di.registerFactory(() => PublishPostCubit(postUsecases: di()));

  //* register routes
  di<List<RouteBase>>(instanceName: Constants.mainRouesDiKey).addAll(postRoutes());
}

void registerPostModuleWithContext(BuildContext context) {
  //* Add all post module navigation tabs
  var navTabs = di<List<AdaptiveDestination>>(instanceName: Constants.navTabsDiKey);
  navTabs.addAll(getPostNavTabs(context));
}
