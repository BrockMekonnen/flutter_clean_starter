import 'package:bloc/bloc.dart';
import 'package:clean_flutter/_core/ui/bloc/auth/auth_bloc.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/user/domain/usecase/get_user.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUseCase _getUser;

  ProfileBloc({required GetUserUseCase getUser})
      : _getUser = getUser,
        super(ProfileInitial()) {
    on<GetProfileEvent>(_getUserProfile);
  }

  void _getUserProfile(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _getUser(NoParams());
    emit(
      result.fold(
          (failure) =>
              const ErrorLoadingProfile(message: "Error Loading Profile"),
          (user) => ProfileLoaded(user: user)),
    );
  }
}
