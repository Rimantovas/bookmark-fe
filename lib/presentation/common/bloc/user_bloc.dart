import 'package:app/data/repositories/collections_repository.dart';
import 'package:app/data/repositories/user_repository.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UserBloc extends Cubit<UserState> {
  UserBloc() : super(UserInitial());

  late final UserRepository _userRepository = GetIt.I<UserRepository>();
  late final CollectionsRepository _collectionsRepository =
      GetIt.I<CollectionsRepository>();

  Future<bool> initUser() async {
    try {
      emit(UserLoading());
      final user = await _userRepository.login();

      final collections = await _collectionsRepository.getCollections();

      emit(
        UserSuccess(
          user: user,
          collections: collections,
        ),
      );
      return true;
    } catch (e) {
      print('error: $e');
      emit(UserError(message: e.toString()));
      return false;
    }
  }

  void continueWithGuest() {
    emit(UserGuest(
        collections: List.generate(10, (index) => Collection.mock())));
  }

  void deleteCollection(String id) {
    if (state is! UserSuccess) return;

    final currentState = state as UserSuccess;
    final oldCollections = [...currentState.collections];

    // Optimistically update UI
    emit(UserSuccess(
      user: currentState.user,
      collections: currentState.collections.where((c) => c.id != id).toList(),
    ));

    // Make API call
    _collectionsRepository.deleteCollection(id).catchError((_) {
      // Revert on error
      emit(UserSuccess(
        user: currentState.user,
        collections: oldCollections,
      ));
    });
  }

  void addCollection(Collection collection) {
    if (state is! UserSuccess) return;

    final currentState = state as UserSuccess;
    emit(UserSuccess(
      user: currentState.user,
      collections: [...currentState.collections, collection],
    ));
  }

  void updateCollection(Collection collection) {
    if (state is! UserSuccess) return;

    final currentState = state as UserSuccess;
    final collections = [...currentState.collections];
    final index = collections.indexWhere((c) => c.id == collection.id);

    if (index != -1) {
      collections[index] = collection;
      emit(UserSuccess(
        user: currentState.user,
        collections: collections,
      ));
    }
  }
}

abstract class UserState {
  List<Collection> get collections;
  User get user;
}

class UserInitial extends UserState {
  @override
  List<Collection> get collections => [];

  @override
  User get user => User.mock();
}

class UserLoading extends UserState {
  @override
  List<Collection> get collections => [];

  @override
  User get user => User.mock();
}

class UserSuccess extends UserState {
  @override
  final User user;

  @override
  final List<Collection> collections;

  UserSuccess({required this.user, required this.collections});
}

class UserGuest extends UserState {
  @override
  final List<Collection> collections;

  @override
  User get user => User.guest();

  UserGuest({required this.collections});
}

class UserError extends UserState {
  final String message;

  @override
  User get user => User.mock();
  @override
  List<Collection> get collections => [];

  UserError({required this.message});
}

extension UserStateExtension on UserState {
  bool get isLoggedIn => this is UserSuccess || this is UserGuest;
}
