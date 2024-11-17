import 'package:dart_mappable/dart_mappable.dart';

part 'create_collection_dto.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
)
class CreateCollectionDto with CreateCollectionDtoMappable {
  final String title;
  final bool private;

  CreateCollectionDto({
    required this.title,
    required this.private,
  });
}
