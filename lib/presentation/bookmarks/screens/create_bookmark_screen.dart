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
      child:
          BlocSelector<CreateBookmarkBloc, CreateBookmarkState, PageController>(
              selector: (state) => state.controller,
              builder: (context, controller) {
                return AppModalSheet(
                  title: 'Create Bookmark',
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PageView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        _Step1Screen(),
                        _Step2Screen(),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}

class _Step1Screen extends StatelessWidget {
  const _Step1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _MagicInput(
          onChanged: (value) =>
              context.read<CreateBookmarkBloc>().updateUrl(value),
        ),
        12.heightBox,
        CTAButton(
          text: 'Next',
          onPressed: () {
            context.read<CreateBookmarkBloc>().fetchPreviewInfo();
          },
        ),
      ],
    );
  }
}

class _Step2Screen extends StatelessWidget {
  const _Step2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _MagicInput extends StatelessWidget {
  const _MagicInput({
    super.key,
    required this.onChanged,
  });

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return ZoAnimatedGradientBorder(
      width: double.infinity,
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
          child: CupertinoTextField(
            onChanged: onChanged,
            placeholder: 'Enter URL',
            decoration: const BoxDecoration(),
          ),
        ),
      ),
    );
  }
}
