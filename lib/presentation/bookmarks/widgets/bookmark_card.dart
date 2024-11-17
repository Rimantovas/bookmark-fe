import 'package:app/domain/models/bookmark.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/tappable.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookmarkCard extends StatelessWidget {
  const BookmarkCard({
    super.key,
    required this.bookmark,
    this.onTap,
  });

  final Bookmark bookmark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    print(bookmark.imageUrl);
    return Tappable.animated(
      onTap: onTap,
      child: FCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bookmark.imageUrl != null) ...[
              Skeleton.leaf(
                child: Image.network(
                  bookmark.imageUrl!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              12.heightBox,
            ],
            Text(
              bookmark.title ?? bookmark.link,
              style: context.styles.h6,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (bookmark.description != null) ...[
              8.heightBox,
              Text(
                bookmark.description!,
                style: context.styles.body2.copyWith(
                  color: context.colors.dark.withOpacity(0.6),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (bookmark.tags.isNotEmpty) ...[
              12.heightBox,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: bookmark.tags.map((tag) {
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
