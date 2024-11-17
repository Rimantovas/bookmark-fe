import 'package:app/domain/models/bookmark.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/tappable.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookmarkCard extends StatefulWidget {
  const BookmarkCard({
    super.key,
    required this.bookmark,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final Bookmark bookmark;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  State<BookmarkCard> createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard>
    with SingleTickerProviderStateMixin {
  late final controller = FPopoverController(vsync: this);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tappable.animated(
      onTap: widget.onTap,
      child: FCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.bookmark.title ?? widget.bookmark.link,
                    style: context.styles.h6,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.onEdit != null || widget.onDelete != null)
                  FPopoverMenu.tappable(
                    controller: controller,
                    menuAnchor: Alignment.bottomRight,
                    childAnchor: Alignment.topRight,
                    menu: [
                      FTileGroup(
                        children: [
                          if (widget.onEdit != null)
                            FTile(
                              prefixIcon: HugeIcon(
                                icon: HugeIcons.strokeRoundedEdit01,
                                color: context.colors.dark,
                              ),
                              title: const Text('Edit'),
                              onPress: () {
                                controller.hide();
                                widget.onEdit?.call();
                              },
                            ),
                          if (widget.onDelete != null)
                            FTile(
                              prefixIcon: FIcon(
                                FAssets.icons.delete,
                                color: context.colors.red,
                              ),
                              title: Text(
                                'Delete',
                                style: TextStyle(color: context.colors.red),
                              ),
                              onPress: () {
                                controller.hide();
                                context.showConfirmation(
                                  title: 'Delete Bookmark',
                                  description:
                                      'Are you sure you want to delete this bookmark? This action cannot be undone.',
                                  onConfirm: widget.onDelete!,
                                );
                              },
                            ),
                        ],
                      ),
                    ],
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedMoreVertical,
                      color: context.colors.dark,
                    ),
                  ),
              ],
            ),
            if (widget.bookmark.imageUrl != null) ...[
              12.heightBox,
              Skeleton.leaf(
                child: Image.network(
                  widget.bookmark.imageUrl!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            if (widget.bookmark.description != null) ...[
              8.heightBox,
              Text(
                widget.bookmark.description!,
                style: context.styles.body2.copyWith(
                  color: context.colors.dark.withOpacity(0.6),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (widget.bookmark.tags.isNotEmpty) ...[
              12.heightBox,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.bookmark.tags.map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: ShapeDecoration(
                      shape: const StadiumBorder(),
                      color: tag.color.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (tag.icon != null) ...[
                          Icon(tag.icon!.icon, size: 16, color: tag.color),
                          4.widthBox,
                        ],
                        Text(
                          tag.name,
                          style: TextStyle(color: tag.color),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
