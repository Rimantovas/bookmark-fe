import 'package:app/data/dto/update_tag_dto.dart';
import 'package:app/data/repositories/tag_repository.dart';
import 'package:app/domain/enums/tag_icon.dart';
import 'package:app/domain/models/tag.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/tags/bloc/tags_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';

class UpdateTagBloc extends Cubit<UpdateTagState> {
  UpdateTagBloc(Tag tag) : super(UpdateTagState.fromTag(tag)) {
    state.nameController.addListener(() {
      emit(state.copyWith(
        name: state.nameController.text,
        nameError: _validateName(state.nameController.text),
      ));
    });

    state.colorController.addListener(() {
      if (state.colorController.values.isNotEmpty) {
        emit(state.copyWith(
          color: state.colorController.values.first,
          colorError: null,
        ));
      }
    });

    state.iconController.addListener(() {
      if (state.iconController.values.isNotEmpty) {
        emit(state.copyWith(icon: state.iconController.values.first));
      }
    });
  }

  final _tagRepository = GetIt.I<TagRepository>();
  final _tagsBloc = GetIt.I<TagsBloc>();

  String? _validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  bool validate() {
    final nameError = _validateName(state.name);
    final colorError = state.color == null ? 'Color is required' : null;

    emit(state.copyWith(
      nameError: nameError,
      colorError: colorError,
    ));

    return nameError == null && colorError == null;
  }

  @override
  Future<void> close() {
    state.nameController.dispose();
    state.colorController.dispose();
    state.iconController.dispose();
    return super.close();
  }

  Future<void> updateTag() async {
    if (!validate()) return;

    try {
      final dto = UpdateTagDto(
        name: state.name,
        color: state.color,
        icon: state.icon,
      );

      toggleLoading();
      await _tagsBloc.updateTag(state.id, dto);
      router.pop();
    } catch (e) {
      print('ERROR: $e');
      // Handle error
    } finally {
      toggleLoading();
    }
  }
}

class UpdateTagState {
  final String id;
  final String name;
  final String? nameError;
  final Color? color;
  final String? colorError;
  final TagIcon? icon;
  final TextEditingController nameController;
  final FRadioSelectGroupController<Color> colorController;
  final FRadioSelectGroupController<TagIcon> iconController;

  UpdateTagState({
    required this.id,
    required this.name,
    required this.nameError,
    required this.color,
    required this.colorError,
    required this.icon,
    required this.nameController,
    required this.colorController,
    required this.iconController,
  });

  UpdateTagState.fromTag(Tag tag)
      : id = tag.id,
        name = tag.name,
        nameError = null,
        color = tag.color,
        colorError = null,
        icon = tag.icon,
        nameController = TextEditingController(text: tag.name),
        colorController = FRadioSelectGroupController<Color>()
          ..select(tag.color, true),
        iconController = FRadioSelectGroupController<TagIcon>() {
    if (tag.icon != null) {
      iconController.select(tag.icon!, true);
    }
  }

  UpdateTagState copyWith({
    String? name,
    String? nameError,
    Color? color,
    String? colorError,
    TagIcon? icon,
    TextEditingController? nameController,
    FRadioSelectGroupController<Color>? colorController,
    FRadioSelectGroupController<TagIcon>? iconController,
  }) {
    return UpdateTagState(
      id: id,
      name: name ?? this.name,
      nameError: nameError ?? this.nameError,
      color: color ?? this.color,
      colorError: colorError ?? this.colorError,
      icon: icon ?? this.icon,
      nameController: nameController ?? this.nameController,
      colorController: colorController ?? this.colorController,
      iconController: iconController ?? this.iconController,
    );
  }
}
