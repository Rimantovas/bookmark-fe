import 'package:app/presentation/bookmarks/bloc/create_bookmark_bloc.dart';
import 'package:app/presentation/bookmarks/widgets/bookmark_form.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/animated_border.dart';
import 'package:app/presentation/common/widgets/app_sheet.dart';
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
            actionTitle:
                state.step == CreateBookmarkStep.url ? 'Next' : 'Create',
            onAction: state.step == CreateBookmarkStep.url
                ? () => context.read<CreateBookmarkBloc>().fetchPreviewInfo()
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
        return BookmarkForm(
          titleController: state.titleController,
          descriptionController: state.descriptionController,
          collectionController: state.collectionController,
          tagsController: state.tagsController,
          selectedAppId: state.appId,
          onAppSelected: (id) =>
              context.read<CreateBookmarkBloc>().updateAppId(id),
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
