import 'package:app/domain/enums/tag_icon.dart';
import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:mock_data/mock_data.dart';

part 'tag.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
)
class Tag with TagMappable {
  final String id;
  final String name;
  @MappableField(hook: ColorHook())
  final Color color;
  @MappableField(hook: SafeEnumHook<TagIcon>(TagIcon.values))
  final TagIcon? icon;

  Tag({
    required this.id,
    required this.name,
    required this.color,
    this.icon,
  });

  Tag.mock() : this(id: mockUUID(), name: mockName(), color: Colors.red);
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

class SafeEnumHook<T extends Enum> extends MappingHook {
  const SafeEnumHook(this.values);

  final List<T> values;

  @override
  Object? beforeDecode(Object? value) {
    if (value == null) return null;

    try {
      return values.firstWhereOrNull(
        (e) => e.name == value.toString(),
      );
    } catch (_) {
      return null;
    }
  }
}
