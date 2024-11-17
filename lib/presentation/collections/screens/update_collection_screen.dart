import 'package:app/domain/models/collection.dart';
import 'package:app/presentation/collections/bloc/update_collection_bloc.dart';
import 'package:app/presentation/collections/widgets/collection_form.dart';
import 'package:app/presentation/common/widgets/app_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCollectionScreen extends StatelessWidget {
  const UpdateCollectionScreen({
    super.key,
    required this.collection,
    this.onUpdated,
  });

  final Collection collection;
  final Function(Collection)? onUpdated;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateCollectionBloc(
        collection: collection,
        onUpdated: onUpdated,
      ),
      child: BlocBuilder<UpdateCollectionBloc, UpdateCollectionState>(
        builder: (context, state) {
          return AppModalSheet(
            title: 'Update Collection',
            actionTitle: 'Update',
            onAction: () =>
                context.read<UpdateCollectionBloc>().updateCollection(),
            child: CollectionForm(
              titleController: state.titleController,
              private: state.private,
              onPrivateChanged: (value) =>
                  context.read<UpdateCollectionBloc>().updatePrivate(value),
            ),
          );
        },
      ),
    );
  }
}
