import 'package:dart_mappable/dart_mappable.dart';

part 'update_collection_dto.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
)
class UpdateCollectionDto with UpdateCollectionDtoMappable {
  final String title;
  final bool private;

  UpdateCollectionDto({
    required this.title,
    required this.private,
  });
}
