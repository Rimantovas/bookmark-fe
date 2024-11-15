import 'package:app/domain/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CreateBookmarkStep {
  url,
  other,
}

class CreateBookmarkBloc extends Cubit<CreateBookmarkState> {
  CreateBookmarkBloc() : super(CreateBookmarkState.initial());

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }

  Future<void> fetchPreviewInfo() async {
    // TODO: validate url and fetch preview info

    emit(state.copyWith(step: CreateBookmarkStep.other));
  }

  void updateUrl(String url) {
    // TODO: validate title

    emit(state.copyWith(url: url));
  }
}

class CreateBookmarkState {
  final bool isLoading;
  final String url;
  final String title;
  final String description;
  final String collectionId;
  final List<Tag> tags;
  final CreateBookmarkStep step;
  final PageController controller;
  CreateBookmarkState({
    required this.isLoading,
    required this.url,
    required this.title,
    required this.description,
    required this.tags,
    required this.collectionId,
    required this.step,
    required this.controller,
  });

  CreateBookmarkState.initial()
      : this(
          isLoading: false,
          url: '',
          title: '',
          description: '',
          tags: [],
          collectionId: '',
          step: CreateBookmarkStep.url,
          controller: PageController(),
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
    );
  }
}
