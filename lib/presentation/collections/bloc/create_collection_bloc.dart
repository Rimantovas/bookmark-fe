import 'package:app/data/dto/create_collection_dto.dart';
import 'package:app/data/repositories/collections_repository.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CreateCollectionBloc extends Cubit<CreateCollectionState> {
  CreateCollectionBloc() : super(CreateCollectionState.initial());

  final _collectionsRepository = GetIt.I<CollectionsRepository>();
  final _userBloc = GetIt.I<UserBloc>();

  @override
  Future<void> close() {
    state.titleController.dispose();
    return super.close();
  }

  void updatePrivate(bool value) {
    emit(state.copyWith(private: value));
  }

  Future<void> createCollection() async {
    if (state.title.isEmpty) return;

    try {
      final dto = CreateCollectionDto(
        title: state.title,
        private: state.private,
      );

      toggleLoading();
      final collection = await _collectionsRepository.createCollection(dto);
      _userBloc.addCollection(collection);
      router.pop();
    } catch (e) {
      // Handle error
    } finally {
      toggleLoading();
    }
  }
}

class CreateCollectionState {
  final String title;
  final bool private;
  final TextEditingController titleController;

  CreateCollectionState({
    required this.title,
    required this.private,
    required this.titleController,
  });

  CreateCollectionState.initial()
      : this(
          title: '',
          private: false,
          titleController: TextEditingController(),
        );

  CreateCollectionState copyWith({
    String? title,
    bool? private,
    TextEditingController? titleController,
  }) {
    return CreateCollectionState(
      title: title ?? this.title,
      private: private ?? this.private,
      titleController: titleController ?? this.titleController,
    );
  }
}
