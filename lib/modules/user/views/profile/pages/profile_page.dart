import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di/get_It.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/profile_display.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: buildBody(context),
    );
  }

  BlocProvider<ProfileBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => container<ProfileBloc>(),
      child: Center(
        child: SizedBox(
          width: 500,
          height: 500,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                    builder: ((context, state) {
                  print(state);
                  if (state is ProfileInitial || state is ProfileLoading) {
                    var _profileBloc = BlocProvider.of<ProfileBloc>(context);
                    _profileBloc.add(GetProfileEvent());
                    return const LoadingWidget();
                  } else if (state is ProfileLoaded) {
                    return ProfileDisplay(user: state.user);
                  } else if (state is ErrorLoadingProfile) {
                    return MessageDisplay(message: state.message);
                  }

                  return Container();
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
