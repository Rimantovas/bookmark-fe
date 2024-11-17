import 'package:app/domain/models/bookmark.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:mock_data/mock_data.dart';

part 'collection.mapper.dart';

@MappableClass()
class Collection with CollectionMappable {
  final String id;
  final String title;
  final bool private;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  final List<String> images;
  final int bookmarksCount;

  Collection({
    required this.id,
    required this.title,
    required this.private,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.images,
    required this.bookmarksCount,
  });

  Collection.mock()
      : id = mockUUID(),
        title = mockName(),
        private = false,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        userId = mockUUID(),
        images = [],
        bookmarksCount = 0;
}
