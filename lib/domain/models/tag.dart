import 'package:app/domain/enums/tag_icon.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'tag.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
  hook: ColorHook(),
)
class Tag with TagMappable {
  final String id;
  final String name;
  final Color color;
  final TagIcon? icon;

  Tag({
    required this.id,
    required this.name,
    required this.color,
    this.icon,
  });
}

class ColorHook extends MappingHook {
  const ColorHook();

  @override
  Object? beforeEncode(Object? value) {
    if (value is Color) {
      return '#${value.value.toRadixString(16).substring(2)}';
    }
    return value;
  }

  @override
  Object? beforeDecode(Object? value) {
    if (value is String && value.startsWith('#')) {
      return Color(int.parse(value.substring(1, 7), radix: 16) + 0xFF000000);
    }
    return value;
  }
}
