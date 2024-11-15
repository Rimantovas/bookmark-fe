import 'package:dart_mappable/dart_mappable.dart';

part 'search_pagination_dto.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
)
class SearchPaginationDto with SearchPaginationDtoMappable {
  final String? query;
  final int? page;
  final int? limit;

  SearchPaginationDto({
    this.query,
    this.page,
    this.limit,
  });
}
