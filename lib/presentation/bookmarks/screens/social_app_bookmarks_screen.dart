import 'package:app/main.dart';
import 'package:app/presentation/bookmarks/bloc/social_app_bookmarks_bloc.dart';
import 'package:app/presentation/bookmarks/screens/bookmarks_list_screen.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:app/presentation/home/widgets/social_app_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialAppBookmarksScreen extends StatelessWidget {
  const SocialAppBookmarksScreen({
    super.key,
    required this.socialAppId,
  });

  final String socialAppId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAppBookmarksBloc(socialAppId),
      child: BlocBuilder<SocialAppBookmarksBloc, SocialAppBookmarksState>(
        builder: (context, state) {
          if (state.socialApp == null && !state.isLoading) {
            return Container(); // Will be replaced with error screen
          }

          return BookmarksListScreen(
            title: state.socialApp?.title ?? '',
            image: state.socialApp != null
                ? SocialAppCard(socialApp: state.socialApp!)
                : const SizedBox.shrink(),
            subtitle: state.socialApp?.website,
            bookmarks: state.bookmarks,
            isLoading: state.isLoading,
            onEditBookmark: (bookmark) {
              router.push(UpdateBookmarkRoute(
                bookmark: bookmark,
                onUpdated: (updatedBookmark) {
                  context
                      .read<SocialAppBookmarksBloc>()
                      .updateBookmark(updatedBookmark);
                },
              ));
            },
            onDeleteBookmark: (bookmark) {
              context
                  .read<SocialAppBookmarksBloc>()
                  .deleteBookmark(bookmark.id);
            },
          );
        },
      ),
    );
  }
}
