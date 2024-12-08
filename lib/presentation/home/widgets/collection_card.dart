import 'package:app/domain/models/collection.dart';
import 'package:app/main.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/utils/routes.dart';
import 'package:app/presentation/common/widgets/tappable.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';

class CollectionCard extends StatefulWidget {
  const CollectionCard({
    super.key,
    required this.collection,
    this.onTap,
  });

  final Collection collection;
  final VoidCallback? onTap;

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard>
    with SingleTickerProviderStateMixin {
  late final controller = FPopoverController(vsync: this);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tappable.animated(
      onTap: widget.onTap,
      child: FCard(
        image: _CollectionImages(images: widget.collection.images),
        title: Row(
          children: [
            Expanded(child: Text(widget.collection.title)),
            FPopoverMenu.tappable(
              controller: controller,
              menuAnchor: Alignment.bottomRight,
              childAnchor: Alignment.topRight,
              menu: [
                FTileGroup(
                  children: [
                    FTile(
                      prefixIcon: HugeIcon(
                          icon: HugeIcons.strokeRoundedEdit01,
                          color: context.colors.dark),
                      title: const Text('Edit'),
                      onPress: () {
                        controller.hide();
                        router.push(UpdateCollectionRoute(
                          collection: widget.collection,
                        ));
                      },
                    ),
                    FTile(
                      prefixIcon: FIcon(
                        FAssets.icons.delete,
                        color: context.colors.red,
                      ),
                      title: Text(
                        'Delete',
                        style: TextStyle(color: context.colors.red),
                      ),
                      onPress: () {
                        controller.hide();
                        context.showConfirmation(
                          title: 'Delete Collection',
                          description:
                              'Are you sure you want to delete this collection? This action cannot be undone.',
                          onConfirm: () {
                            GetIt.I<UserBloc>()
                                .deleteCollection(widget.collection.id);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedMoreVertical,
                color: context.colors.dark,
              ),
            ),
          ],
        ),
        subtitle: Text('${widget.collection.bookmarkCount} bookmarks'),
      ),
    );
  }
}

class _CollectionImages extends StatelessWidget {
  const _CollectionImages({
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      height: 150,
      color: context.colors.grey,
      child: Center(
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedFolder02,
          color: context.colors.dark,
          size: 54,
        ),
      ),
    );
    if (images.isEmpty) {
      return placeholder;
    }

    return SizedBox(
      height: 150,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          switch (images.length) {
            case 1:
              return _buildImage(images[0]);
            case 2:
              return Row(
                children: [
                  Expanded(child: _buildImage(images[0])),
                  const SizedBox(width: 2),
                  Expanded(child: _buildImage(images[1])),
                ],
              );
            case 3:
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildImage(images[0]),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(child: _buildImage(images[1])),
                        const SizedBox(height: 2),
                        Expanded(child: _buildImage(images[2])),
                      ],
                    ),
                  ),
                ],
              );
            case 4:
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: _buildImage(images[0])),
                        const SizedBox(height: 2),
                        Expanded(child: _buildImage(images[1])),
                      ],
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: _buildImage(images[2])),
                        const SizedBox(height: 2),
                        Expanded(child: _buildImage(images[3])),
                      ],
                    ),
                  ),
                ],
              );
            default:
              return placeholder;
          }
        },
      ),
    );
  }

  Widget _buildImage(String url) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
