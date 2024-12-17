import 'package:app/domain/enums/user_role.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/domain/models/social_app.dart';
import 'package:app/domain/models/tag.dart';
import 'package:app/presentation/common/bloc/catalog_bloc.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/home/widgets/social_app_grid.dart';
import 'package:app/presentation/tags/bloc/tags_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';

class BookmarkForm extends StatelessWidget {
  const BookmarkForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.collectionController,
    required this.tagsController,
    required this.onAppSelected,
    this.selectedAppId,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final FRadioSelectGroupController<Collection> collectionController;
  final FMultiSelectGroupController<Tag> tagsController;
  final Function(String) onAppSelected;
  final String? selectedAppId;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      resizeToAvoidBottomInset: false,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FTextField(
            hint: 'Title',
            label: const Text('Title'),
            controller: titleController,
          ),
          16.heightBox,
          FTextField(
            hint: 'Description (optional)',
            label: const Text('Description'),
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
          ),
          16.heightBox,
          BlocSelector<CatalogBloc, CatalogState, List<SocialApp>>(
            bloc: GetIt.I<CatalogBloc>(),
            selector: (state) => state.socialApps,
            builder: (context, socialApps) {
              if (socialApps.isEmpty) return const SizedBox();

              return FLabel(
                axis: Axis.vertical,
                label: const Text('Social App (optional)'),
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: socialApps.length,
                    separatorBuilder: (_, __) => 8.widthBox,
                    itemBuilder: (context, index) {
                      final app = socialApps[index];
                      return SizedBox(
                        width: 80,
                        child: SocialAppCard(
                          socialApp: app,
                          selected: selectedAppId == app.id,
                          onTap: () => onAppSelected(app.id),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          16.heightBox,
          FLabel(
            axis: Axis.vertical,
            label: const Text('Collection'),
            child: BlocSelector<UserBloc, UserState, List<Collection>>(
              bloc: GetIt.I<UserBloc>(),
              selector: (state) => state.collections,
              builder: (context, collections) {
                return FSelectMenuTile(
                  groupController: collectionController,
                  autoHide: true,
                  validator: (value) => value == null ? 'Select an item' : null,
                  title: const Text('Collection'),
                  details: ListenableBuilder(
                    listenable: collectionController,
                    builder: (context, _) => Text(
                      collectionController.values.firstOrNull?.title ?? 'None',
                    ),
                  ),
                  menu: collections
                      .map(
                        (c) => FSelectTile(
                          title: Text(c.title),
                          value: c,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
          16.heightBox,
          BlocSelector<UserBloc, UserState, bool>(
              bloc: GetIt.I<UserBloc>(),
              selector: (state) {
                return state.user.role == UserRole.premium;
              },
              builder: (context, isPremium) {
                if (!isPremium) return const SizedBox();
                return BlocSelector<TagsBloc, TagsState, List<Tag>>(
                  bloc: GetIt.I<TagsBloc>(),
                  selector: (state) => state.tags,
                  builder: (context, tags) {
                    return FLabel(
                      axis: Axis.vertical,
                      label: const Text('Tags'),
                      child: FSelectTileGroup<Tag>(
                        groupController: tagsController,
                        description:
                            const Text('Select tags for your bookmark'),
                        children: tags
                            .map(
                              (tag) => FSelectTile(
                                title: Text(tag.name),
                                suffixIcon: tag.icon != null
                                    ? Icon(tag.icon!.icon)
                                    : Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: tag.color,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                value: tag,
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}
