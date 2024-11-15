// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'tag_icon.dart';

class TagIconMapper extends EnumMapper<TagIcon> {
  TagIconMapper._();

  static TagIconMapper? _instance;
  static TagIconMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TagIconMapper._());
    }
    return _instance!;
  }

  static TagIcon fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TagIcon decode(dynamic value) {
    switch (value) {
      case 'home':
        return TagIcon.home;
      case 'work':
        return TagIcon.work;
      case 'shopping':
        return TagIcon.shopping;
      case 'travel':
        return TagIcon.travel;
      case 'health':
        return TagIcon.health;
      case 'entertainment':
        return TagIcon.entertainment;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TagIcon self) {
    switch (self) {
      case TagIcon.home:
        return 'home';
      case TagIcon.work:
        return 'work';
      case TagIcon.shopping:
        return 'shopping';
      case TagIcon.travel:
        return 'travel';
      case TagIcon.health:
        return 'health';
      case TagIcon.entertainment:
        return 'entertainment';
    }
  }
}

extension TagIconMapperExtension on TagIcon {
  String toValue() {
    TagIconMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TagIcon>(this) as String;
  }
}
