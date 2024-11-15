import 'package:app/presentation/common/utils/colors.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:app/presentation/common/utils/styles.dart';
import 'package:app/presentation/common/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get mediaSize => MediaQuery.of(this).size;

  void goRoute(AppRoute route) =>
      goNamed(route.name, pathParameters: route.params, extra: route.extra);

  void pushRoute(AppRoute route) => pushNamed(
        route.name,
        pathParameters: route.params,
        extra: route.extra,
      );

  AppColors get colors => Theme.of(this).extension<AppThemeExtension>()!.colors;

  AppStyles get styles => Theme.of(this).extension<AppThemeExtension>()!.styles;
}

extension IntX on int {
  Widget get heightBox => SizedBox(height: toDouble());
  Widget get widthBox => SizedBox(width: toDouble());

  Widget get sliverHeightBox => SliverToBoxAdapter(
        child: heightBox,
      );

  Widget get sliverWidthBox => SliverToBoxAdapter(
        child: widthBox,
      );
}
