import 'package:app/presentation/common/utils/colors.dart';
import 'package:app/presentation/common/utils/styles.dart';
import 'package:flutter/material.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  AppThemeExtension({
    required this.colors,
    required this.styles,
  });

  final AppColors colors;
  final AppStyles styles;

  @override
  AppThemeExtension copyWith({
    AppColors? colors,
    AppStyles? styles,
  }) {
    return AppThemeExtension(
      colors: colors ?? this.colors,
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
