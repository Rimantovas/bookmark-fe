import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/tag.dart';
import 'package:app/presentation/bookmarks/bloc/create_bookmark_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/animated_border.dart';
import 'package:app/presentation/common/widgets/app_sheet.dart';
import 'package:app/presentation/common/widgets/cta_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoTextField(
              placeholder: 'Title',
              onChanged: (value) =>
                  context.read<CreateBookmarkBloc>().updateTitle(value),
            ),
            12.heightBox,
            CupertinoTextField(
              placeholder: 'Description (optional)',
              onChanged: (value) =>
                  context.read<CreateBookmarkBloc>().updateDescription(value),
              minLines: 3,
              maxLines: 5,
            ),
            16.heightBox,
            _CollectionSelector(
              selectedId: state.collectionId,
              onSelected: (id) =>
                  context.read<CreateBookmarkBloc>().updateCollectionId(id),
            ),
            16.heightBox,
            _TagSelector(
              selectedTags: state.tags,
              onTagsSelected: (tags) =>
                  context.read<CreateBookmarkBloc>().updateTags(tags),
            ),
            const Spacer(),
            CTAButton(
              text: 'Create',
              isLoading: state.isLoading,
              onPressed: () {
                context.read<CreateBookmarkBloc>().createBookmark();
              },
            ),
          ],
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
                            .firstWhere(
                              (c) => c.id == selectedId,
                              orElse: () => Collection(
                                id: '',
                                title: 'Select Collection',
                                private: false,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                                userId: '',
                              ),
                            )
                            .title ??
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
