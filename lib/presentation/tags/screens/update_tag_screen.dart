import 'package:app/domain/models/tag.dart';
import 'package:app/presentation/common/widgets/app_sheet.dart';
import 'package:app/presentation/tags/bloc/update_tag_bloc.dart';
import 'package:app/presentation/tags/widgets/tag_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTagScreen extends StatelessWidget {
  const UpdateTagScreen({
    super.key,
    required this.tag,
  });

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateTagBloc(tag),
      child: BlocBuilder<UpdateTagBloc, UpdateTagState>(
        builder: (context, state) {
          return AppModalSheet(
            title: 'Update Tag',
            actionTitle: 'Update',
            onAction: () => context.read<UpdateTagBloc>().updateTag(),
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
