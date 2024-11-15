import 'package:dart_mappable/dart_mappable.dart';

part 'create_bookmark_dto.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
)
class CreateBookmarkDto with CreateBookmarkDtoMappable {
  final String link;
  final String? title;
  final String? description;
  final String? imageUrl;
  final List<String>? tagIds;
  final String? appId;
  final String collectionId;
  final Map<String, dynamic>? metadata;

  CreateBookmarkDto({
    required this.link,
    this.title,
    this.description,
    this.imageUrl,
    this.tagIds,
    this.appId,
    required this.collectionId,
    this.metadata,
  });
}
