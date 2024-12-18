import 'package:app/main.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:app/presentation/common/utils/styles.dart';
import 'package:app/presentation/common/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

// Global overlay entry for loading
OverlayEntry? _loadingOverlay;

extension ContextExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get mediaSize => MediaQuery.of(this).size;

  void goRoute(AppRoute route) =>
      goNamed(route.name, pathParameters: route.params, extra: route.extra);

  void pushRoute(AppRoute route) => pushNamed(
        route.name,
        pathParameters: route.params,
        extra: route.extra,
      );

  FColorScheme get colors => theme.colorScheme;

  AppStyles get styles => AppStyles();
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

extension CubitX<State> on Cubit<State> {
  void toggleLoading() {
    if (_loadingOverlay != null) {
      _loadingOverlay?.remove();
      _loadingOverlay = null;
      return;
    }

    final context = router.router.routerDelegate.navigatorKey.currentContext;
    if (context == null) return;

    _loadingOverlay = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: CircularProgressIndicator(
            color: context.colors.foreground,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_loadingOverlay!);
  }
}

extension BuildContextX on BuildContext {
  Future<void> showConfirmation({
    required String title,
    String? description,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      context: this,
      builder: (context) => ConfirmationDialog(
        title: title,
        description: description,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }
}
