import 'package:app/data/dto/update_collection_dto.dart';
import 'package:app/data/repositories/collections_repository.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UpdateCollectionBloc extends Cubit<UpdateCollectionState> {
  UpdateCollectionBloc({
    required Collection collection,
    this.onUpdated,
  }) : super(UpdateCollectionState.fromCollection(collection));

  final Function(Collection)? onUpdated;
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

  Future<void> updateCollection() async {
    if (state.title.isEmpty) return;

    try {
      final dto = UpdateCollectionDto(
        title: state.title,
        private: state.private,
      );

      toggleLoading();
      final collection =
          await _collectionsRepository.updateCollection(state.id, dto);
      _userBloc.updateCollection(collection);
      onUpdated?.call(collection);
      router.pop();
    } catch (e) {
      // Handle error
    } finally {
      toggleLoading();
    }
  }
}

class UpdateCollectionState {
  final String id;
  final String title;
  final bool private;
  final TextEditingController titleController;

  UpdateCollectionState({
    required this.id,
    required this.title,
    required this.private,
    required this.titleController,
  });

  UpdateCollectionState.fromCollection(Collection collection)
      : id = collection.id,
        title = collection.title,
        private = collection.private,
        titleController = TextEditingController(text: collection.title);

  UpdateCollectionState copyWith({
    String? title,
    bool? private,
    TextEditingController? titleController,
  }) {
    return UpdateCollectionState(
      id: id,
      title: title ?? this.title,
      private: private ?? this.private,
      titleController: titleController ?? this.titleController,
    );
  }
}
