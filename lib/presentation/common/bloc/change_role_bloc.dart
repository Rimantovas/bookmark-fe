import 'package:app/data/repositories/user_repository.dart';
import 'package:app/domain/enums/user_role.dart';
import 'package:app/domain/models/user_role_dto.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ChangeRoleBloc extends Cubit<ChangeRoleState> {
  final UserRepository _userRepository = GetIt.I<UserRepository>();
  final UserBloc _userBloc = GetIt.I<UserBloc>();

  ChangeRoleBloc() : super(ChangeRoleInitial());

  Future<bool> changeRole(UserRole newRole) async {
    final previousState = _userBloc.state;
    try {
      toggleLoading();

      // Optimistically update the UI
      if (previousState is UserSuccess) {
        _userBloc.emit(UserSuccess(
          user: previousState.user.copyWith(role: newRole),
          collections: previousState.collections,
        ));
      }

      // Make API call
      await _userRepository.updateRole(UserRoleDto(role: newRole));

      toggleLoading();
      return true;
    } catch (e) {
      print(e);
      // Revert on error
      if (previousState is UserSuccess) {
        _userBloc.emit(previousState);
      }

      toggleLoading();
      return false;
    }
  }
}

abstract class ChangeRoleState {}

class ChangeRoleInitial extends ChangeRoleState {}
