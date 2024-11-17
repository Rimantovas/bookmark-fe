import 'package:app/data/dto/create_tag_dto.dart';
import 'package:app/domain/enums/tag_icon.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'update_tag_dto.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
)
class UpdateTagDto with UpdateTagDtoMappable {
  final String? name;
  @MappableField(hook: ColorHook())
  final Color? color;
  final TagIcon? icon;

  UpdateTagDto({
    this.name,
    this.color,
    this.icon,
  });
}
