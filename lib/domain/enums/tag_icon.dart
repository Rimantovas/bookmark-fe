import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'tag_icon.mapper.dart';

@MappableEnum()
enum TagIcon {
  home,
  work,
  shopping,
  travel,
  health,
  entertainment;

  IconData get icon {
    switch (this) {
      case TagIcon.home:
        return Icons.home;
      case TagIcon.work:
        return Icons.work;
      case TagIcon.shopping:
        return Icons.shopping_bag;
      case TagIcon.travel:
        return Icons.flight;
      case TagIcon.health:
        return Icons.health_and_safety;
      case TagIcon.entertainment:
        return Icons.movie;
    }
  }
}
