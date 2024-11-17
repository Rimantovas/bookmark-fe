import 'package:app/domain/models/collection.dart';
import 'package:app/presentation/common/widgets/tappable.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({
    super.key,
    required this.collection,
    this.onTap,
  });

  final Collection collection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tappable.animated(
      onTap: onTap,
      child: FCard(
        image: _CollectionImages(images: collection.images),
        title: Text(collection.title),
        subtitle: Text('${collection.bookmarksCount} bookmarks'),
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
    if (images.isEmpty) {
      return Container(
        height: 150,
        color: Colors.red,
      );
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
              return Container(
                height: 150,
                color: Colors.red,
              );
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
