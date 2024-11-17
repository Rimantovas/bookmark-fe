import 'package:app/domain/models/bookmark.dart';
import 'package:app/presentation/bookmarks/bloc/update_bookmark_bloc.dart';
import 'package:app/presentation/bookmarks/widgets/bookmark_form.dart';
import 'package:app/presentation/common/widgets/app_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBookmarkScreen extends StatelessWidget {
  const UpdateBookmarkScreen({
    super.key,
    required this.bookmark,
    this.onUpdated,
  });

  final Bookmark bookmark;
  final Function(Bookmark)? onUpdated;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBookmarkBloc(
        bookmark: bookmark,
        onUpdated: onUpdated,
      ),
      child: BlocBuilder<UpdateBookmarkBloc, UpdateBookmarkState>(
        builder: (context, state) {
          return AppModalSheet(
            title: 'Update Bookmark',
            actionTitle: 'Update',
            onAction: () => context.read<UpdateBookmarkBloc>().updateBookmark(),
            child: BookmarkForm(
              titleController: state.titleController,
              descriptionController: state.descriptionController,
              collectionController: state.collectionController,
              tagsController: state.tagsController,
              selectedAppId: state.appId,
              onAppSelected: (id) =>
                  context.read<UpdateBookmarkBloc>().updateAppId(id),
            ),
          );
        },
      ),
    );
  }
}
