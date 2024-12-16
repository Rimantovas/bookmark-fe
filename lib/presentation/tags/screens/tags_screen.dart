import 'package:app/domain/enums/user_role.dart';
import 'package:app/domain/models/tag.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:app/presentation/common/utils/sheet_utils.dart';
import 'package:app/presentation/common/widgets/custom_placeholder.dart';
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
            resizeToAvoidBottomInset: false,
            header: FHeader(
              title: const Text('Tags'),
              actions: [
                FHeaderAction(
                    icon: const Icon(Icons.add),
                    onPress: () {
                      final isGuest = GetIt.I<UserBloc>().state.isGuest;
                      final isPremium =
                          GetIt.I<UserBloc>().state is UserSuccess &&
                              (GetIt.I<UserBloc>().state.user as UserSuccess)
                                      .user
                                      .role ==
                                  UserRole.premium;

                      if (isGuest) {
                        showAuthSheet(context, feature: 'create tags');
                      } else if (!isPremium) {
                        showPremiumSheet(context);
                      } else {
                        router.go(CreateTagRoute());
                      }
                    }),
              ],
            ),
            content: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  if (tags.isNotEmpty) ...[
                    ...tags.map((tag) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TagTile(
                            tag: tag,
                            onEdit: () {
                              router.push(UpdateTagRoute(tag: tag));
                            },
                            onDelete: () {
                              GetIt.I<TagsBloc>().deleteTag(tag.id);
                            },
                          ),
                        )),
                  ] else
                    CustomPlaceholder(
                      title: 'No tags yet',
                      type: PlaceholderType.tags,
                      action: SizedBox(
                        width: 180,
                        child: FButton(
                          onPress: () {
                            router.go(CreateTagRoute());
                          },
                          label: const Text('Create new tag'),
                        ),
                      ),
                    ),
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
          color: context.colors.border,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              HugeIcons.strokeRoundedPlusSign,
              size: 20,
              color: context.colors.primary,
            ),
            12.widthBox,
            const Expanded(child: Text('Create new tag')),
          ],
        ),
      ),
    );
  }
}
