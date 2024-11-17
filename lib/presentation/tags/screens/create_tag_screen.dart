import 'package:app/domain/enums/tag_icon.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/app_sheet.dart';
import 'package:app/presentation/tags/bloc/create_tag_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

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
            child: FScaffold(
              content: Column(
                children: [
                  FLabel(
                    axis: Axis.vertical,
                    label: const Text('Name'),
                    error: state.nameError != null
                        ? Text(
                            state.nameError!,
                            style: context.styles.body2.copyWith(
                              color: context.colors.red,
                            ),
                          )
                        : null,
                    child: FTextField(
                      hint: 'Tag name',
                      controller: state.nameController,
                    ),
                  ),
                  16.heightBox,
                  FLabel(
                    axis: Axis.vertical,
                    label: const Text('Color'),
                    error: state.colorError != null
                        ? Text(
                            state.colorError!,
                            style: context.styles.body2.copyWith(
                              color: context.colors.red,
                            ),
                          )
                        : null,
                    child: FSelectMenuTile<Color>(
                      groupController: state.colorController,
                      autoHide: true,
                      title: const Text('Color'),
                      details: ListenableBuilder(
                        listenable: state.colorController,
                        builder: (context, _) =>
                            state.colorController.values.isEmpty
                                ? const Text('Select color')
                                : Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: state.colorController.values.first,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                      ),
                      menu: CreateTagBloc.predefinedColors.entries
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
                      groupController: state.iconController,
                      autoHide: true,
                      title: const Text('Icon'),
                      details: ListenableBuilder(
                        listenable: state.iconController,
                        builder: (context, _) =>
                            state.iconController.values.isEmpty
                                ? const Text('Select icon')
                                : Icon(
                                    state.iconController.values.first.icon,
                                    color: context.colors.dark,
                                  ),
                      ),
                      menu: TagIcon.values
                          .map(
                            (icon) => FSelectTile(
                              uncheckedIcon:
                                  Icon(icon.icon, color: context.colors.dark),
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
            ),
          );
        },
      ),
    );
  }
}
