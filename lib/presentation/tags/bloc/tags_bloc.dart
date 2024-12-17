import 'package:app/data/dto/create_tag_dto.dart';
import 'package:app/data/dto/update_tag_dto.dart';
import 'package:app/data/repositories/tag_repository.dart';
import 'package:app/domain/enums/user_role.dart';
import 'package:app/domain/models/tag.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TagsBloc extends Cubit<TagsState> {
  TagsBloc() : super(const TagsState());

  final _tagRepository = GetIt.I<TagRepository>();

  Future<void> getTags() async {
    final user = GetIt.I<UserBloc>().state.user;
    if (user.role == UserRole.regular) {
      emit(state.copyWith(tags: [], isLoading: false));
      return;
    }
    print('getTags');
    emit(state.copyWith(isLoading: true));

    try {
      final tags = await _tagRepository.getTags();
      print('tags: ${tags.length}');
      emit(state.copyWith(tags: tags, isLoading: false));
    } catch (e) {
      print('error: $e');
      emit(state.copyWith(isLoading: false));
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

  void addTag(Tag tag) {
    emit(state.copyWith(tags: [...state.tags, tag]));
  }
}

class TagsState {
  final List<Tag> tags;
  final bool isLoading;

  const TagsState({
    this.tags = const [],
    this.isLoading = false,
  });

  TagsState copyWith({
    List<Tag>? tags,
    bool? isLoading,
  }) {
    return TagsState(
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
