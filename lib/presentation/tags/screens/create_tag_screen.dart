import 'package:app/presentation/common/widgets/app_sheet.dart';
import 'package:app/presentation/tags/bloc/create_tag_bloc.dart';
import 'package:app/presentation/tags/widgets/tag_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTagScreen extends StatelessWidget {
  const CreateTagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTagBloc(),
      child: BlocBuilder<CreateTagBloc, CreateTagState>(
        builder: (context, state) {
          return AppModalSheet(
            title: 'Create Tag',
            actionTitle: 'Create',
            onAction: () => context.read<CreateTagBloc>().createTag(),
            child: TagForm(
              nameController: state.nameController,
              colorController: state.colorController,
              iconController: state.iconController,
              nameError: state.nameError,
              colorError: state.colorError,
            ),
          );
        },
      ),
    );
  }
}
