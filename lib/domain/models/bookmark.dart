import 'package:app/domain/models/tag.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'bookmark.mapper.dart';

@MappableClass()
class Bookmark with BookmarkMappable {
  final String id;
  final String link;
  final String? title;
  final String? description;
  @MappableField(key: 'image_url')
  final String? imageUrl;
  final List<Tag> tags;
  final String? appId;
  final String collectionId;
  final String userId;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  Bookmark({
    required this.id,
    required this.link,
    this.title,
    this.description,
    this.imageUrl,
    required this.tags,
    this.appId,
    required this.collectionId,
    required this.userId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });
}
