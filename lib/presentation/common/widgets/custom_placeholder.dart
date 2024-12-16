import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum PlaceholderType {
  search,
  documents,
  images,
  tags,
}

extension CustomPlaceholderAssets on PlaceholderType {
  String get asset => switch (this) {
        PlaceholderType.search => 'assets/images/NoSearchResults.svg',
        PlaceholderType.documents => 'assets/images/NoDocuments.png',
        PlaceholderType.images => 'assets/images/NoImages.png',
        PlaceholderType.tags => 'assets/images/NoTags.svg',
      };
}

class CustomPlaceholder extends StatelessWidget {
  const CustomPlaceholder({
    super.key,
    required this.title,
    this.subtitle,
    this.type = PlaceholderType.search,
    this.action,
  });

  final String title;
  final String? subtitle;
  final PlaceholderType type;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          type.asset,
          width: 160,
          height: 160,
        ),
        8.heightBox,
        Text(
          title,
          style: context.styles.button1.copyWith(color: context.colors.primary),
        ),
        if (subtitle != null) ...[
          4.heightBox,
          Text(
            subtitle!,
            style: context.styles.body2.copyWith(
              color: context.colors.primary,
            ),
          ),
        ],
        if (action != null) ...[
          16.heightBox,
          action!,
        ]
      ],
    );
  }
}
