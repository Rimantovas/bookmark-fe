import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class AppModalSheet extends StatelessWidget {
  const AppModalSheet({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;

  final String title;

  @override
  Widget build(BuildContext context) {
    return ScrollableSheet(
      physics: const BouncingSheetPhysics(
        parent: SnappingSheetPhysics(),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SheetContentScaffold(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          appBar: CupertinoAppBar(
            title: Text(title),
            leading: CupertinoButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            trailing: CupertinoButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Save'),
            ),
          ),
          body: SizedBox.expand(
            child: child,
          ),
        ),
      ),
    );
  }
}

class CupertinoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CupertinoAppBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  final Widget title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemGroupedBackground,
        border: Border(bottom: BorderSide(color: CupertinoColors.systemGrey5)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (leading case final leading?)
            Positioned(
              left: 1,
              child: leading,
            ),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.titleMedium!,
            child: title,
          ),
          if (trailing case final trailing?)
            Positioned(
              right: 1,
              child: trailing,
            ),
        ],
      ),
    );
  }
}
