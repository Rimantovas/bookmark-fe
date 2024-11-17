import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/social_app.dart';
import 'package:app/domain/models/tag.dart';
import 'package:app/presentation/bookmarks/bloc/create_bookmark_bloc.dart';
import 'package:app/presentation/common/bloc/catalog_bloc.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/animated_border.dart';
import 'package:app/presentation/common/widgets/app_sheet.dart';
import 'package:app/presentation/common/widgets/cta_button.dart';
import 'package:app/presentation/home/widgets/social_app_grid.dart';
import 'package:app/presentation/tags/bloc/tags_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';

class CreateBookmarkScreen extends StatelessWidget {
  const CreateBookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateBookmarkBloc(),
      child: BlocBuilder<CreateBookmarkBloc, CreateBookmarkState>(
        builder: (context, state) {
          return AppModalSheet(
            title: 'Create Bookmark',
            actionTitle: state.step == CreateBookmarkStep.url ? null : 'Create',
            onAction: state.step == CreateBookmarkStep.url
                ? null
                : () {
                    context.read<CreateBookmarkBloc>().createBookmark();
                  },
            child: PageView(
              controller: state.controller,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _Step1Screen(),
                _Step2Screen(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Step1Screen extends StatelessWidget {
  const _Step1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CreateBookmarkBloc, CreateBookmarkState,
        TextEditingController>(
      selector: (state) {
        return state.urlController;
      },
      builder: (context, controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MagicInput(
              controller: controller,
            ),
            12.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CTAButton(
                text: 'Next',
                onPressed: () {
                  context.read<CreateBookmarkBloc>().fetchPreviewInfo();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Step2Screen extends StatelessWidget {
  const _Step2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBookmarkBloc, CreateBookmarkState>(
      builder: (context, state) {
        return FScaffold(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FTextField(
                hint: 'Title',
                label: const Text('Title'),
                controller: state.titleController,
              ),
              16.heightBox,
              FTextField(
                hint: 'Description (optional)',
                label: const Text('Description'),
                controller: state.descriptionController,
                minLines: 3,
                maxLines: 5,
              ),
              16.heightBox,
              BlocSelector<CatalogBloc, CatalogState, List<SocialApp>>(
                bloc: GetIt.I<CatalogBloc>(),
                selector: (state) => state.socialApps,
                builder: (context, socialApps) {
                  if (socialApps.isEmpty) return const SizedBox();

                  return FLabel(
                    axis: Axis.vertical,
                    label: const Text('Social App (optional)'),
                    child: SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: socialApps.length,
                        separatorBuilder: (_, __) => 8.widthBox,
                        itemBuilder: (context, index) {
                          final app = socialApps[index];
                          return SizedBox(
                            width: 80,
                            child: SocialAppCard(
                              socialApp: app,
                              selected: state.appId == app.id,
                              onTap: () {
                                context
                                    .read<CreateBookmarkBloc>()
                                    .updateAppId(app.id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              16.heightBox,
              FLabel(
                axis: Axis.vertical,
                label: const Text('Collection'),
                child: BlocSelector<UserBloc, UserState, List<Collection>>(
                  bloc: GetIt.I<UserBloc>(),
                  selector: (state) {
                    return state.collections;
                  },
                  builder: (context, collections) {
                    return FSelectMenuTile(
                      groupController: state.collectionController,
                      autoHide: true,
                      validator: (value) =>
                          value == null ? 'Select an item' : null,
                      // prefixIcon: Icon(
                      //   HugeIcons.strokeRoundedFolder01,
                      //   color: context.colors.dark,
                      // ),
                      title: const Text('Collection'),
                      details: ListenableBuilder(
                        listenable: state.collectionController,
                        builder: (context, _) => Text(
                          state.collectionController.values.firstOrNull
                                  ?.title ??
                              'None',
                        ),
                      ),
                      menu: collections
                          .map(
                            (c) => FSelectTile(
                              title: Text(c.title),
                              value: c,
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
              16.heightBox,
              BlocSelector<TagsBloc, TagsState, List<Tag>>(
                bloc: GetIt.I<TagsBloc>(),
                selector: (state) => state.tags,
                builder: (context, tags) {
                  return FLabel(
                    axis: Axis.vertical,
                    label: const Text('Tags'),
                    child: FSelectTileGroup<Tag>(
                      controller: state.tagsController,
                      description: const Text('Select tags for your bookmark'),
                      children: tags
                          .map(
                            (tag) => FSelectTile(
                              title: Text(tag.name),
                              suffixIcon: tag.icon != null
                                  ? Icon(tag.icon!.icon)
                                  : Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: tag.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                              // checkedIcon: tag.icon != null
                              //     ? Icon(tag.icon!.icon)
                              //     : Container(
                              //         width: 20,
                              //         height: 20,
                              //         decoration: BoxDecoration(
                              //           color: tag.color,
                              //           shape: BoxShape.circle,
                              //         ),
                              //       ),
                              value: tag,
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MagicInput extends StatelessWidget {
  const _MagicInput({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return ZoAnimatedGradientBorder(
        width: width - 32,
        height: 56,
        borderThickness: 1,
        glowOpacity: 0.5,
        shouldAnimate: true,
        gradientColor: const [
          Colors.purple,
          Colors.pink,
          Colors.blue,
          Colors.cyan,
          Colors.green,
          Colors.red
        ],
        duration: const Duration(seconds: 10),
        child: Container(
          height: 56,
          decoration: ShapeDecoration(
            color: context.colors.white,
            shape: StadiumBorder(
              side: BorderSide(
                color: context.colors.grey,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Center(
            child: TextField(
              controller: controller,
              decoration: InputDecoration.collapsed(
                hintText: 'Enter URL',
                hintStyle: context.styles.body1.copyWith(
                  color: context.colors.dark,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _CollectionSelector extends StatelessWidget {
  const _CollectionSelector({
    required this.selectedId,
    required this.onSelected,
  });

  final String selectedId;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    // TODO: Get collections from bloc/repository
    final collections = <Collection>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Collection'),
        8.heightBox,
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                actions: collections
                    .map(
                      (c) => CupertinoActionSheetAction(
                        onPressed: () {
                          onSelected(c.id);
                          Navigator.pop(context);
                        },
                        child: Text(c.title),
                      ),
                    )
                    .toList(),
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    collections
                            .firstWhereOrNull(
                              (c) => c.id == selectedId,
                            )
                            ?.title ??
                        'Select Collection',
                  ),
                ),
                const Icon(CupertinoIcons.chevron_down, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TagSelector extends StatelessWidget {
  const _TagSelector({
    required this.selectedTags,
    required this.onTagsSelected,
  });

  final List<Tag> selectedTags;
  final Function(List<Tag>) onTagsSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tags'),
        8.heightBox,
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            final result = await showDialog<List<Tag>>(
              context: context,
              builder: (context) => _TagSelectorDialog(
                selectedTags: selectedTags,
              ),
            );
            if (result != null) {
              onTagsSelected(result);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedTags.isEmpty
                        ? 'Select Tags'
                        : selectedTags.map((t) => t.name).join(', '),
                  ),
                ),
                const Icon(CupertinoIcons.chevron_down, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TagSelectorDialog extends StatefulWidget {
  const _TagSelectorDialog({
    required this.selectedTags,
  });

  final List<Tag> selectedTags;

  @override
  State<_TagSelectorDialog> createState() => _TagSelectorDialogState();
}

class _TagSelectorDialogState extends State<_TagSelectorDialog> {
  late List<Tag> selectedTags;

  @override
  void initState() {
    super.initState();
    selectedTags = [...widget.selectedTags];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Get tags from bloc/repository
    final tags = <Tag>[];

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select Tags'),
            16.heightBox,
            ...tags.map(
              (tag) => CheckboxListTile(
                value: selectedTags.contains(tag),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedTags.add(tag);
                    } else {
                      selectedTags.remove(tag);
                    }
                  });
                },
                title: Text(tag.name),
              ),
            ),
            16.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                CupertinoButton(
                  onPressed: () => Navigator.pop(context, selectedTags),
                  child: const Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
