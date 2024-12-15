import 'package:app/presentation/common/utils/styles.dart';
import 'package:flutter/material.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  AppThemeExtension({
    required this.styles,
  });

  final AppStyles styles;

  @override
  AppThemeExtension copyWith({
    AppStyles? styles,
  }) {
    return AppThemeExtension(
      styles: styles ?? this.styles,
    );
  }

  @override
  AppThemeExtension lerp(
    ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    return this;
  }
}
