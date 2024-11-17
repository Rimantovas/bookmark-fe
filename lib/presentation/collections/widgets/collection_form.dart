import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class CollectionForm extends StatelessWidget {
  const CollectionForm({
    super.key,
    required this.titleController,
    required this.private,
    required this.onPrivateChanged,
  });

  final TextEditingController titleController;
  final bool private;
  final Function(bool) onPrivateChanged;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      content: Column(
        children: [
          FTextField(
            hint: 'Title',
            label: const Text('Title'),
            controller: titleController,
          ),
          16.heightBox,
          FLabel(
            axis: Axis.vertical,
            label: const Text('Private Collection'),
            description: const Text(
              'Private collections are only visible to you and cannot be shared with others.',
            ),
            child: FSwitch(
              value: private,
              onChange: onPrivateChanged,
            ),
          ),
        ],
      ),
    );
  }
}