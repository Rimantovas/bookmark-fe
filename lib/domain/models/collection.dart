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

  Collection({
    required this.id,
    required this.title,
    required this.private,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  Collection.mock()
      : id = mockUUID(),
        title = mockName(),
        private = false,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        userId = mockUUID();
}
