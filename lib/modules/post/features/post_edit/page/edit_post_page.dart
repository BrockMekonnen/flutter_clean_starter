import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di.dart';
import '../../../../../_core/layout/page_layout.dart';
import '../../../post_routes.dart';
import '../../post_detail/cubit/post_detail_cubit.dart';
import '../bloc/post_edit_bloc.dart';
import '../widgets/post_form.dart';

class EditPostPage extends StatelessWidget {
  const EditPostPage({
    super.key,
    required this.postId,
    this.parentContext,
  });

  final String postId;
  final BuildContext? parentContext;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di<PostEditBloc>()),
        BlocProvider(create: (context) => di<PostDetailCubit>()..getPost(postId)),
      ],
      child: PageLayout(
        title: context.tr('postPage.editPost'),
        navTab: PostNavTab.myPosts,
        hideNavBarOnMobile: true,
        page: BlocBuilder<PostDetailCubit, PostDetailState>(
          builder: (context, state) {
            if (state is PostDetailFailure) {
              return Center(child: Text(state.message));
            } else if (state is PostDetailSuccess) {
              return PostForm(
                id: state.post.id,
                title: state.post.title,
                content: state.post.content,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
