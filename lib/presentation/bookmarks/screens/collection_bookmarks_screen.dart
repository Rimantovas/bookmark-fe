import 'package:app/main.dart';
import 'package:app/presentation/bookmarks/bloc/collection_bookmarks_bloc.dart';
import 'package:app/presentation/bookmarks/screens/bookmarks_list_screen.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBookmarksScreen extends StatelessWidget {
  const CollectionBookmarksScreen({
    super.key,
    required this.collectionId,
  });

  final String collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionBookmarksBloc(collectionId),
      child: BlocBuilder<CollectionBookmarksBloc, CollectionBookmarksState>(
        builder: (context, state) {
          if (state.collection == null && !state.isLoading) {
            return Container(); // Will be replaced with error screen
          }

          return BookmarksListScreen(
            title: state.collection?.title ?? '',
            bookmarks: state.bookmarks,
            isLoading: state.isLoading,
            onEditBookmark: (bookmark) {
              router.push(UpdateBookmarkRoute(
                bookmark: bookmark,
                onUpdated: (updatedBookmark) {
                  context
                      .read<CollectionBookmarksBloc>()
                      .updateBookmark(updatedBookmark);
                },
              ));
            },
            onDeleteBookmark: (bookmark) {
              context
                  .read<CollectionBookmarksBloc>()
                  .deleteBookmark(bookmark.id);
            },
          );
        },
      ),
    );
  }
}
