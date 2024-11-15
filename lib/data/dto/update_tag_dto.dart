import 'package:app/domain/enums/tag_icon.dart';
import 'package:app/domain/models/tag.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'update_tag_dto.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
  hook: ColorHook(),
)
class UpdateTagDto with UpdateTagDtoMappable {
  final String? name;
  final Color? color;
  final TagIcon? icon;

  UpdateTagDto({
    this.name,
    this.color,
    this.icon,
  });
}
