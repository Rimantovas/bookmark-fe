import 'package:app/domain/models/bookmark.dart';
import 'package:app/presentation/bookmarks/widgets/bookmark_card.dart';
import 'package:app/presentation/common/utils/extensions.dart';
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
  });

  final String title;
  final List<Bookmark> bookmarks;
  final bool isLoading;

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
        title: Text(title),
      ),
      content: Builder(builder: (context) {
        final bookmarks = isLoading
            ? List.generate(10, (_) => Bookmark.mock())
            : this.bookmarks;

        if (bookmarks.isEmpty) {
          return Center(
            child: Text(
              'No bookmarks yet',
              style: context.styles.body1,
            ),
          );
        }
        return AppLoader(
          isLoading: isLoading,
          child: ListView.separated(
            padding: EdgeInsets.zero,
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
              );
            },
          ),
        );
      }),
    );
  }
}
