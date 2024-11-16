import 'package:app/domain/models/tag.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:app/presentation/common/widgets/loader.dart';
import 'package:app/presentation/common/widgets/tappable.dart';
import 'package:app/presentation/tags/bloc/tags_bloc.dart';
import 'package:app/presentation/tags/widgets/tag_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagsBloc, TagsState>(
      bloc: GetIt.I<TagsBloc>(),
      builder: (context, state) {
        final tags =
            state.isLoading ? List.generate(10, (_) => Tag.mock()) : state.tags;

        return AppLoader(
          isLoading: state.isLoading,
          child: FScaffold(
            header: const FHeader(
              title: Text('Tags'),
            ),
            content: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  const _CreateTagTile(),
                  if (tags.isNotEmpty) ...[
                    16.heightBox,
                    ...tags.map((tag) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TagTile(
                            tag: tag,
                            onEdit: () {
                              // TODO: Implement edit dialog
                            },
                            onDelete: () {
                              GetIt.I<TagsBloc>().deleteTag(tag.id);
                            },
                          ),
                        )),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CreateTagTile extends StatelessWidget {
  const _CreateTagTile();

  @override
  Widget build(BuildContext context) {
    return Tappable.animated(
      onTap: () {
        router.go(CreateTagRoute());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: context.colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              HugeIcons.strokeRoundedPlusSign,
              size: 20,
              color: context.colors.dark,
            ),
            12.widthBox,
            const Expanded(child: Text('Create new tag')),
          ],
        ),
      ),
    );
  }
}
