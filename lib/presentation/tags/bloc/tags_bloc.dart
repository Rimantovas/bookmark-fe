import 'package:app/data/dto/create_tag_dto.dart';
import 'package:app/data/dto/update_tag_dto.dart';
import 'package:app/data/repositories/tag_repository.dart';
import 'package:app/domain/models/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TagsBloc extends Cubit<TagsState> {
  TagsBloc() : super(const TagsState());

  final _tagRepository = GetIt.I<TagRepository>();

  Future<void> getTags() async {
    emit(state.copyWith(isLoading: true));
    try {
      final tags = await _tagRepository.getTags();
      emit(
        state.copyWith(
          tags: tags,
          isLoading: false,
          isInitialized: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isInitialized: true,
        ),
      );
    }
  }

  Future<void> createTag(CreateTagDto dto) async {
    try {
      final tag = await _tagRepository.createTag(dto);
      emit(state.copyWith(tags: [...state.tags, tag]));
    } catch (e) {
      // Handle error (show snackbar, etc.)
    }
  }

  Future<void> updateTag(String id, UpdateTagDto dto) async {
    final oldTags = [...state.tags];
    final tagIndex = state.tags.indexWhere((t) => t.id == id);

    if (tagIndex == -1) return;

    final updatedTag = Tag(
      id: id,
      name: dto.name ?? state.tags[tagIndex].name,
      color: dto.color ?? state.tags[tagIndex].color,
      icon: dto.icon ?? state.tags[tagIndex].icon,
    );

    final updatedTags = [...state.tags];
    updatedTags[tagIndex] = updatedTag;
    emit(state.copyWith(tags: updatedTags));

    try {
      final tag = await _tagRepository.updateTag(id, dto);
      final tags = [...state.tags];
      tags[tagIndex] = tag;
      emit(state.copyWith(tags: tags));
    } catch (e) {
      // Revert to old state if update fails
      emit(state.copyWith(tags: oldTags));
      // Handle error (show snackbar, etc.)
    }
  }

  Future<void> deleteTag(String id) async {
    final oldTags = [...state.tags];
    final updatedTags = state.tags.where((t) => t.id != id).toList();

    emit(state.copyWith(tags: updatedTags));

    try {
      await _tagRepository.deleteTag(id);
    } catch (e) {
      // Revert to old state if delete fails
      emit(state.copyWith(tags: oldTags));
      // Handle error (show snackbar, etc.)
    }
  }
}

class TagsState {
  final List<Tag> tags;
  final bool isLoading;
  final bool isInitialized;

  const TagsState({
    this.tags = const [],
    this.isLoading = false,
    this.isInitialized = false,
  });

  TagsState copyWith({
    List<Tag>? tags,
    bool? isLoading,
    bool? isInitialized,
  }) {
    return TagsState(
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}
