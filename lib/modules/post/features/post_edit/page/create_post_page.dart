import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di.dart';
import '../../../../../_core/layout/page_layout.dart';
import '../../../post_routes.dart';
import '../bloc/post_edit_bloc.dart';
import '../widgets/post_form.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key, this.parentContext});

  final BuildContext? parentContext;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<PostEditBloc>(),
      child: PageLayout(
        title: context.tr('postPage.createPost'),
        navTab: PostNavTab.myPosts,
        hideNavBarOnMobile: true,
        page: PostForm(),
      ),
    );
  }
}
