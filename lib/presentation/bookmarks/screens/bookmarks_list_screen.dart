import 'package:app/domain/models/bookmark.dart';
import 'package:app/presentation/bookmarks/widgets/bookmark_card.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/custom_placeholder.dart';
import 'package:app/presentation/common/widgets/loader.dart';
import 'package:app/presentation/common/widgets/tappable.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';

class BookmarksListScreen extends StatelessWidget {
  const BookmarksListScreen({
    super.key,
    required this.title,
    required this.bookmarks,
    this.isLoading = false,
    this.onEditBookmark,
    this.onDeleteBookmark,
    this.subtitle,
    required this.image,
  });

  final String title;
  final String? subtitle;
  final Widget image;
  final List<Bookmark> bookmarks;
  final bool isLoading;
  final Function(Bookmark)? onEditBookmark;
  final Function(Bookmark)? onDeleteBookmark;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixActions: [
          if (Navigator.canPop(context))
            Tappable.animated(
              onTap: () => Navigator.pop(context),
              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft02,
                color: Colors.black,
                size: 24.0,
              ),
            ),
        ],
        title: const Text(''),
      ),
      style: context.theme.scaffoldStyle
          .copyWith(contentPadding: const EdgeInsets.symmetric(horizontal: 16)),
      content: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image,
          ),
          12.heightBox,
          Text(title, style: context.styles.button1),
          if (subtitle != null) ...[
            4.heightBox,
            Text(subtitle!, style: context.styles.body2),
          ],
          24.heightBox,
          Expanded(
            child: Builder(builder: (context) {
              final bookmarks = isLoading
                  ? List.generate(10, (_) => Bookmark.mock())
                  : this.bookmarks;

              if (bookmarks.isEmpty) {
                return const Center(
                  child: CustomPlaceholder(
                    title: 'No bookmarks yet',
                  ),
                );
              }
              return AppLoader(
                isLoading: isLoading,
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 56),
                  itemCount: bookmarks.length,
                  separatorBuilder: (_, __) => 12.heightBox,
                  itemBuilder: (context, index) {
                    return BookmarkCard(
                      bookmark: bookmarks[index],
                      onTap: () {
                        launchUrl(
                          Uri.parse(bookmarks[index].link),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      onEdit: onEditBookmark != null
                          ? () => onEditBookmark!(bookmarks[index])
                          : null,
                      onDelete: onDeleteBookmark != null
                          ? () => onDeleteBookmark!(bookmarks[index])
                          : null,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
