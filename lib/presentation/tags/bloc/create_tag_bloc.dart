import 'package:app/data/dto/create_tag_dto.dart';
import 'package:app/data/repositories/tag_repository.dart';
import 'package:app/domain/enums/tag_icon.dart';
import 'package:app/presentation/tags/bloc/tags_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';

class CreateTagBloc extends Cubit<CreateTagState> {
  CreateTagBloc() : super(CreateTagState.initial()) {
    state.nameController.addListener(() {
      emit(state.copyWith(name: state.nameController.text));
    });

    state.colorController.addListener(() {
      if (state.colorController.values.isNotEmpty) {
        emit(state.copyWith(color: state.colorController.values.first));
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

  @override
  Future<void> close() {
    state.nameController.dispose();
    state.colorController.dispose();
    state.iconController.dispose();
    return super.close();
  }

  Future<void> createTag() async {
    if (state.name.isEmpty || state.color == null) return;

    emit(state.copyWith(isLoading: true));

    try {
      final dto = CreateTagDto(
        name: state.name,
        color: state.color!,
        icon: state.icon,
      );

      final tag = await _tagRepository.createTag(dto);
      _tagsBloc.addTag(tag);
      // Handle success (close modal, show success message, etc.)
    } catch (e) {
      // Handle error
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}

class CreateTagState {
  final bool isLoading;
  final String name;
  final Color? color;
  final TagIcon? icon;
  final TextEditingController nameController;
  final FRadioSelectGroupController<Color> colorController;
  final FRadioSelectGroupController<TagIcon> iconController;

  CreateTagState({
    required this.isLoading,
    required this.name,
    required this.color,
    required this.icon,
    required this.nameController,
    required this.colorController,
    required this.iconController,
  });

  CreateTagState.initial()
      : this(
          isLoading: false,
          name: '',
          color: null,
          icon: null,
          nameController: TextEditingController(),
          colorController: FRadioSelectGroupController<Color>(),
          iconController: FRadioSelectGroupController<TagIcon>(),
        );

  CreateTagState copyWith({
    bool? isLoading,
    String? name,
    Color? color,
    TagIcon? icon,
    TextEditingController? nameController,
    FRadioSelectGroupController<Color>? colorController,
    FRadioSelectGroupController<TagIcon>? iconController,
  }) {
    return CreateTagState(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      nameController: nameController ?? this.nameController,
      colorController: colorController ?? this.colorController,
      iconController: iconController ?? this.iconController,
    );
  }
}
