import 'package:app/data/dto/create_bookmark_dto.dart';
import 'package:app/data/repositories/bookmark_repository.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/tag.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';

enum CreateBookmarkStep {
  url,
  other,
}

class CreateBookmarkBloc extends Cubit<CreateBookmarkState> {
  CreateBookmarkBloc() : super(CreateBookmarkState.initial()) {
    state.urlController.addListener(() {
      emit(state.copyWith(url: state.urlController.text));
    });
    state.titleController.addListener(() {
      emit(state.copyWith(title: state.titleController.text));
    });
    state.descriptionController.addListener(() {
      emit(state.copyWith(description: state.descriptionController.text));
    });

    state.collectionController.addListener(() {
      emit(state.copyWith(
          collectionId:
              state.collectionController.values.firstOrNull?.id ?? ''));
    });

    final collections = GetIt.I<UserBloc>().state.collections;
    if (collections.isNotEmpty) {
      state.collectionController
          .select(GetIt.I<UserBloc>().state.collections.first, true);
    }

    state.tagsController.addListener(() {
      emit(state.copyWith(tags: state.tagsController.values.toList()));
    });
  }

  late final bookmarkRepository = GetIt.I<BookmarkRepository>();

  @override
  Future<void> close() {
    state.controller.dispose();
    state.urlController.dispose();
    state.titleController.dispose();
    state.descriptionController.dispose();
    state.collectionController.dispose();
    state.tagsController.dispose();
    return super.close();
  }

  Future<void> fetchPreviewInfo() async {
    if (state.url.isEmpty) return;

    emit(state.copyWith(isLoading: true));

    try {
      // TODO: Replace with actual API call to fetch social graph info
      // Mocking the response for now
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        title: 'Sample Title',
        description: 'Sample Description',
        imageUrl: 'https://example.com/image.jpg',
        isLoading: false,
      ));

      state.controller.animateToPage(
        CreateBookmarkStep.other.index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      // Handle error
    }
  }

  void updateUrl(String url) {
    emit(state.copyWith(url: url));
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateCollectionId(String collectionId) {
    emit(state.copyWith(collectionId: collectionId));
  }

  void updateTags(List<Tag> tags) {
    emit(state.copyWith(tags: tags));
  }

  void updateAppId(String appId) {
    emit(state.copyWith(appId: appId));
  }

  Future<void> createBookmark() async {
    if (state.url.isEmpty ||
        state.title.isEmpty ||
        state.collectionId.isEmpty) {
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final dto = CreateBookmarkDto(
        link: state.url,
        title: state.title,
        description: state.description,
        imageUrl: state.imageUrl,
        appId: state.appId,
        collectionId: state.collectionId,
        tagIds: state.tags.map((t) => t.id).toList(),
        metadata: null, // Add if needed
      );

      await bookmarkRepository.createBookmark(dto);
      // Handle success (close modal, show success message, etc.)
    } catch (e) {
      // Handle error
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}

class CreateBookmarkState {
  final bool isLoading;
  final String url;
  final String title;
  final String? description;
  final String? imageUrl;
  final String? appId;
  final String collectionId;
  final List<Tag> tags;
  final CreateBookmarkStep step;
  final PageController controller;
  final TextEditingController urlController;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final FRadioSelectGroupController<Collection> collectionController;
  final FMultiSelectGroupController<Tag> tagsController;

  CreateBookmarkState({
    required this.isLoading,
    required this.url,
    required this.title,
    required this.description,
    required this.tags,
    required this.collectionId,
    required this.step,
    required this.controller,
    required this.imageUrl,
    required this.appId,
    required this.urlController,
    required this.titleController,
    required this.descriptionController,
    required this.collectionController,
    required this.tagsController,
  });

  CreateBookmarkState.initial()
      : this(
          isLoading: false,
          url: '',
          title: '',
          description: null,
          imageUrl: null,
          appId: null,
          tags: [],
          collectionId: '',
          step: CreateBookmarkStep.url,
          controller: PageController(),
          urlController: TextEditingController(),
          titleController: TextEditingController(),
          descriptionController: TextEditingController(),
          collectionController: FRadioSelectGroupController<Collection>(),
          tagsController: FMultiSelectGroupController<Tag>(),
        );

  CreateBookmarkState copyWith({
    bool? isLoading,
    String? url,
    String? title,
    String? description,
    List<Tag>? tags,
    String? collectionId,
    CreateBookmarkStep? step,
    PageController? controller,
    String? imageUrl,
    String? appId,
    TextEditingController? urlController,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    FRadioSelectGroupController<Collection>? collectionController,
    FMultiSelectGroupController<Tag>? tagsController,
  }) {
    return CreateBookmarkState(
      isLoading: isLoading ?? this.isLoading,
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      collectionId: collectionId ?? this.collectionId,
      step: step ?? this.step,
      controller: controller ?? this.controller,
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
