import 'package:app/domain/enums/tag_icon.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class TagForm extends StatelessWidget {
  const TagForm({
    super.key,
    required this.nameController,
    required this.colorController,
    required this.iconController,
    this.nameError,
    this.colorError,
  });

  final TextEditingController nameController;
  final FRadioSelectGroupController<Color> colorController;
  final FRadioSelectGroupController<TagIcon> iconController;
  final String? nameError;
  final String? colorError;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      resizeToAvoidBottomInset: false,
      content: Column(
        children: [
          FLabel(
            axis: Axis.vertical,
            label: const Text('Name'),
            error: nameError != null
                ? Text(
                    nameError!,
                    style: context.styles.body2.copyWith(
                      color: context.colors.destructive,
                    ),
                  )
                : null,
            child: FTextField(
              hint: 'Tag name',
              controller: nameController,
            ),
          ),
          16.heightBox,
          FLabel(
            axis: Axis.vertical,
            label: const Text('Color'),
            error: colorError != null
                ? Text(
                    colorError!,
                    style: context.styles.body2.copyWith(
                      color: context.colors.destructive,
                    ),
                  )
                : null,
            child: FSelectMenuTile<Color>(
              groupController: colorController,
              autoHide: true,
              title: const Text('Color'),
              details: ListenableBuilder(
                listenable: colorController,
                builder: (context, _) => colorController.values.isEmpty
                    ? const Text('Select color')
                    : Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: colorController.values.first,
                          shape: BoxShape.circle,
                        ),
                      ),
              ),
              menu: predefinedColors.entries
                  .map(
                    (entry) => FSelectTile(
                      checkedIcon: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: entry.value,
                          shape: BoxShape.circle,
                        ),
                      ),
                      uncheckedIcon: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: entry.value,
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text(entry.key),
                      value: entry.value,
                    ),
                  )
                  .toList(),
            ),
          ),
          16.heightBox,
          FLabel(
            axis: Axis.vertical,
            label: const Text('Icon (optional)'),
            child: FSelectMenuTile(
              groupController: iconController,
              autoHide: true,
              title: const Text('Icon'),
              details: ListenableBuilder(
                listenable: iconController,
                builder: (context, _) => iconController.values.isEmpty
                    ? const Text('Select icon')
                    : Icon(
                        iconController.values.first.icon,
                        color: context.colors.primary,
                      ),
              ),
              menu: TagIcon.values
                  .map(
                    (icon) => FSelectTile(
                      uncheckedIcon:
                          Icon(icon.icon, color: context.colors.primary),
                      checkedIcon: Icon(
                        icon.icon,
                        color: context.colors.primary,
                      ),
                      title: Text(icon.name),
                      value: icon,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

const predefinedColors = <String, Color>{
  'Red': Colors.red,
  'Pink': Colors.pink,
  'Purple': Colors.purple,
  'Deep Purple': Colors.deepPurple,
  'Indigo': Colors.indigo,
  'Blue': Colors.blue,
  'Green': Colors.green,
  'Yellow': Colors.yellow,
  'Deep Orange': Colors.deepOrange,
  'Grey': Colors.grey,
};
