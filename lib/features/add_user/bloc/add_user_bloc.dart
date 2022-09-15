import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../modules/user/domain/user_repository.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final UserRepository _userRepository;

  AddUserBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(AddUserInitial()) {
    on<AddUserRequested>(_addUserRequested);
  }

  void _addUserRequested(
    AddUserRequested event,
    Emitter<AddUserState> emit,
  ) async {
    emit(AddUserLoading());
    try {
      await _userRepository.register(
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        email: event.email,
        password: 'test@test',
        isTermAndConditionAgreed: true,
      );
      emit(AddUserSuccess());
    } catch (error) {
      emit(const AddUserFailure(error: 'Failed To Add User'));
    }
  }
}
