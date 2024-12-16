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
        image: CollectionImages(images: widget.collection.images),
        title: Row(
          children: [
            Expanded(child: Text(widget.collection.title)),
            FPopoverMenu.tappable(
              popoverController: controller,
              menuAnchor: Alignment.bottomRight,
              childAnchor: Alignment.topRight,
              menu: [
                FTileGroup(
                  children: [
                    FTile(
                      prefixIcon: HugeIcon(
                          icon: HugeIcons.strokeRoundedEdit01,
                          color: context.colors.primary),
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
                        color: context.colors.destructive,
                      ),
                      title: Text(
                        'Delete',
                        style: TextStyle(color: context.colors.destructive),
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
                color: context.colors.primary,
              ),
            ),
          ],
        ),
        subtitle: Text('${widget.collection.bookmarkCount} bookmarks'),
      ),
    );
  }
}

class CollectionImages extends StatelessWidget {
  const CollectionImages({
    super.key,
    required this.images,
    this.height = 150,
    this.width = double.infinity,
  });

  final List<String> images;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      height: height,
      width: width,
      color: context.colors.border,
      child: Center(
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedFolder02,
          color: context.colors.primary,
          size: 54,
        ),
      ),
    );
    if (images.isEmpty) {
      return placeholder;
    }

    return SizedBox(
      height: height,
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
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
