import 'package:app/domain/models/collection.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/home/widgets/collection_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CollectionGrid extends StatelessWidget {
  const CollectionGrid({
    super.key,
    required this.collections,
  });

  final List<Collection> collections;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Collections',
          style: context.styles.button1,
        ),
        8.heightBox,
        GridView.custom(
          shrinkWrap: true,
          semanticChildCount: collections.length,
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              const QuiltedGridTile(2, 2),
              const QuiltedGridTile(1, 2),
              const QuiltedGridTile(1, 2),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => CollectionCard(collection: collections[index]),
            childCount: collections.length,
          ),
        ),
      ],
    );
  }
}

class CollectionCard extends StatelessWidget {
  const CollectionCard({super.key, required this.collection});

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          CollectionGradient(id: collection.id),
          Container(
            color: Colors.black12,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  collection.title,
                  style: context.styles.h6.copyWith(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
