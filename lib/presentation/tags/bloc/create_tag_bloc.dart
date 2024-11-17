import 'package:app/data/dto/create_tag_dto.dart';
import 'package:app/data/repositories/tag_repository.dart';
import 'package:app/domain/enums/tag_icon.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/tags/bloc/tags_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';

class CreateTagBloc extends Cubit<CreateTagState> {
  CreateTagBloc() : super(CreateTagState.initial()) {
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

  static const predefinedColors = <String, Color>{
    'Red': Colors.red,
    'Pink': Colors.pink,
    'Purple': Colors.purple,
    'Deep Purple': Colors.deepPurple,
    'Indigo': Colors.indigo,
    'Blue': Colors.blue,
    'Green': Colors.green,
    'Yellow': Colors.yellow,
    'Deep Orange': Colors.deepOrange,
    'Grey': Colors.grey,
  };

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

  Future<void> createTag() async {
    print('createTag');
    if (!validate()) return;

    print('validate');

    try {
      final dto = CreateTagDto(
        name: state.name,
        color: state.color!,
        icon: state.icon,
      );
      print('call function');
      toggleLoading();
      final tag = await _tagRepository.createTag(dto);
      _tagsBloc.addTag(tag);
      router.pop();
    } catch (e) {
      print('error: $e');
      // Handle error
    } finally {
      toggleLoading();
    }
  }
}

class CreateTagState {
  final String name;
  final String? nameError;
  final Color? color;
  final String? colorError;
  final TagIcon? icon;
  final TextEditingController nameController;
  final FRadioSelectGroupController<Color> colorController;
  final FRadioSelectGroupController<TagIcon> iconController;

  CreateTagState({
    required this.name,
    required this.nameError,
    required this.color,
    required this.colorError,
    required this.icon,
    required this.nameController,
    required this.colorController,
    required this.iconController,
  });

  CreateTagState.initial()
      : this(
          name: '',
          nameError: null,
          color: null,
          colorError: null,
          icon: null,
          nameController: TextEditingController(),
          colorController: FRadioSelectGroupController<Color>(),
          iconController: FRadioSelectGroupController<TagIcon>(),
        );

  CreateTagState copyWith({
    bool? isLoading,
    String? name,
    String? nameError,
    Color? color,
    String? colorError,
    TagIcon? icon,
    TextEditingController? nameController,
    FRadioSelectGroupController<Color>? colorController,
    FRadioSelectGroupController<TagIcon>? iconController,
  }) {
    return CreateTagState(
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
