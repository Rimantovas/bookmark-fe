import 'package:app/presentation/collections/bloc/create_collection_bloc.dart';
import 'package:app/presentation/collections/widgets/collection_form.dart';
import 'package:app/presentation/common/widgets/app_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCollectionScreen extends StatelessWidget {
  const CreateCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateCollectionBloc(),
      child: BlocBuilder<CreateCollectionBloc, CreateCollectionState>(
        builder: (context, state) {
          return AppModalSheet(
            title: 'Create Collection',
            actionTitle: 'Create',
            onAction: () =>
                context.read<CreateCollectionBloc>().createCollection(),
            child: CollectionForm(
              titleController: state.titleController,
              private: state.private,
              onPrivateChanged: (value) =>
                  context.read<CreateCollectionBloc>().updatePrivate(value),
            ),
          );
        },
      ),
    );
  }
}
