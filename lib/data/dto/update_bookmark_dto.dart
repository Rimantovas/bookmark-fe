import 'package:dart_mappable/dart_mappable.dart';

part 'update_bookmark_dto.mapper.dart';

@MappableClass()
class UpdateBookmarkDto with UpdateBookmarkDtoMappable {
  final String? link;
  final String? title;
  final String? description;
  @MappableField(
    key: 'image_url',
  )
  final String? imageUrl;
  final List<String>? tagIds;
  final String? appId;
  final String? collectionId;
  final Map<String, dynamic>? metadata;

  UpdateBookmarkDto({
    this.link,
    this.title,
    this.description,
    this.imageUrl,
    this.tagIds,
    this.appId,
    this.collectionId,
    this.metadata,
  });
}
