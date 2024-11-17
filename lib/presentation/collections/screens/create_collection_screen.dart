import 'package:app/presentation/collections/bloc/create_collection_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/app_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

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
            child: FScaffold(
              content: Column(
                children: [
                  FTextField(
                    hint: 'Title',
                    label: const Text('Title'),
                    controller: state.titleController,
                  ),
                  16.heightBox,
                  FLabel(
                    axis: Axis.vertical,
                    label: const Text('Private Collection'),
                    description: const Text(
                      'Private collections are only visible to you and cannot be shared with others.',
                    ),
                    child: FSwitch(
                      value: state.private,
                      onChange: (value) {
                        context
                            .read<CreateCollectionBloc>()
                            .updatePrivate(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
