import 'package:app/presentation/common/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, required this.isLoading, required this.child});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      effect: AppTheme.skeletonizerEffect(context),
      switchAnimationConfig: AppTheme.skeletonizerAnimationConfig,
      child: child,
    );
  }
}
