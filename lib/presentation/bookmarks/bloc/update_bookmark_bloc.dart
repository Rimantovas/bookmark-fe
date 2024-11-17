import 'package:app/data/dto/update_bookmark_dto.dart';
import 'package:app/data/repositories/bookmark_repository.dart';
import 'package:app/domain/models/bookmark.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/tag.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';

class UpdateBookmarkBloc extends Cubit<UpdateBookmarkState> {
  UpdateBookmarkBloc({
    required Bookmark bookmark,
    this.onUpdated,
  }) : super(UpdateBookmarkState.fromBookmark(bookmark));

  final Function(Bookmark)? onUpdated;
  final _bookmarkRepository = GetIt.I<BookmarkRepository>();

  @override
  Future<void> close() {
    state.urlController.dispose();
    state.titleController.dispose();
    state.descriptionController.dispose();
    state.collectionController.dispose();
    state.tagsController.dispose();
    return super.close();
  }

  Future<void> updateBookmark() async {
    if (state.url.isEmpty ||
        state.title.isEmpty ||
        state.collectionId.isEmpty) {
      return;
    }

    try {
      final dto = UpdateBookmarkDto(
        link: state.url,
        title: state.title,
        description: state.description,
        imageUrl: state.imageUrl,
        appId: state.appId,
        collectionId: state.collectionId,
        tagIds: state.tags.map((t) => t.id).toList(),
        metadata: null,
      );

      toggleLoading();
      final updatedBookmark =
          await _bookmarkRepository.updateBookmark(state.id, dto);
      onUpdated?.call(updatedBookmark);
      router.pop();
    } catch (e) {
      // Handle error
    } finally {
      toggleLoading();
    }
  }

  void updateAppId(String appId) {
    emit(state.copyWith(appId: appId));
  }
}

class UpdateBookmarkState {
  final String id;
  final String url;
  final String title;
  final String? description;
  final String? imageUrl;
  final String? appId;
  final String collectionId;
  final List<Tag> tags;
  final TextEditingController urlController;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final FRadioSelectGroupController<Collection> collectionController;
  final FMultiSelectGroupController<Tag> tagsController;

  UpdateBookmarkState({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.tags,
    required this.collectionId,
    required this.imageUrl,
    required this.appId,
    required this.urlController,
    required this.titleController,
    required this.descriptionController,
    required this.collectionController,
    required this.tagsController,
  });

  UpdateBookmarkState.fromBookmark(Bookmark bookmark)
      : id = bookmark.id,
        url = bookmark.link,
        title = bookmark.title ?? '',
        description = bookmark.description,
        imageUrl = bookmark.imageUrl,
        appId = bookmark.appId,
        tags = bookmark.tags,
        collectionId = bookmark.collectionId,
        urlController = TextEditingController(text: bookmark.link),
        titleController = TextEditingController(text: bookmark.title ?? ''),
        descriptionController =
            TextEditingController(text: bookmark.description ?? ''),
        collectionController = FRadioSelectGroupController<Collection>(),
        tagsController = FMultiSelectGroupController<Tag>() {
    if (bookmark.tags.isNotEmpty) {
      for (final tag in bookmark.tags) {
        tagsController.select(tag, true);
      }
    }
  }

  UpdateBookmarkState copyWith({
    String? url,
    String? title,
    String? description,
    List<Tag>? tags,
    String? collectionId,
    String? imageUrl,
    String? appId,
    TextEditingController? urlController,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    FRadioSelectGroupController<Collection>? collectionController,
    FMultiSelectGroupController<Tag>? tagsController,
  }) {
    return UpdateBookmarkState(
      id: id,
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      collectionId: collectionId ?? this.collectionId,
      imageUrl: imageUrl ?? this.imageUrl,
      appId: appId ?? this.appId,
      urlController: urlController ?? this.urlController,
      titleController: titleController ?? this.titleController,
      descriptionController:
          descriptionController ?? this.descriptionController,
      collectionController: collectionController ?? this.collectionController,
      tagsController: tagsController ?? this.tagsController,
    );
  }
}
