import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    this.description,
    required this.onConfirm,
    this.onCancel,
  });

  final String title;
  final String? description;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return FDialog(
      direction: Axis.vertical,
      title: Text(title),
      body: description != null ? Text(description!) : null,
      actions: [
        FButton(
          label: const Text('Continue'),
          onPress: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
        FButton(
          style: FButtonStyle.outline,
          label: const Text('Cancel'),
          onPress: () {
            Navigator.of(context).pop();
            onCancel?.call();
          },
        ),
      ],
    );
  }
}
