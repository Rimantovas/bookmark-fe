import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

enum PlaceholderType {
  empty,
  error,
}

extension CustomPlaceholderAssets on PlaceholderType {
  SvgAsset get asset => switch (this) {
        PlaceholderType.empty => FAssets.icons.searchX,
        PlaceholderType.error => FAssets.icons.cross,
      };
}

class CustomPlaceholder extends StatelessWidget {
  const CustomPlaceholder({
    super.key,
    required this.title,
    this.subtitle,
    this.type = PlaceholderType.empty,
  });

  final String title;
  final String? subtitle;
  final PlaceholderType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        type.asset.call(
          width: 50,
          height: 50,
          colorFilter: ColorFilter.mode(context.colors.dark, BlendMode.srcIn),
        ),
        12.heightBox,
        Text(
          title,
          style: context.styles.button2.copyWith(color: context.colors.dark),
        ),
        if (subtitle != null) ...[
          4.heightBox,
          Text(
            subtitle!,
            style: context.styles.body2.copyWith(
              color: context.colors.dark,
            ),
          ),
        ]
      ],
    );
  }
}
