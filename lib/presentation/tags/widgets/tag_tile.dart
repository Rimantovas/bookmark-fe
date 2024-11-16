import 'package:app/domain/models/tag.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/tappable.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hugeicons/hugeicons.dart';

class TagTile extends StatelessWidget {
  const TagTile({
    super.key,
    required this.tag,
    this.onEdit,
    this.onDelete,
  });

  final Tag tag;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: Row(
        children: [
          if (tag.icon != null)
            Icon(
              tag.icon!.icon,
              size: 20,
            )
          else
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tag.color,
              ),
            ),
          12.widthBox,
          Expanded(child: Text(tag.name)),
          if (onEdit != null)
            Tappable.animated(
              onTap: onEdit,
              child: const Icon(HugeIcons.strokeRoundedEdit01, size: 20),
            ),
          8.widthBox,
          if (onDelete != null)
            Tappable.animated(
              onTap: onDelete,
              child: Icon(
                HugeIcons.strokeRoundedDelete01,
                size: 20,
                color: context.colors.red,
              ),
            ),
        ],
      ),
    );
  }
}
