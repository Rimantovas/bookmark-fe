// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'search_pagination_dto.dart';

class SearchPaginationDtoMapper extends ClassMapperBase<SearchPaginationDto> {
  SearchPaginationDtoMapper._();

  static SearchPaginationDtoMapper? _instance;
  static SearchPaginationDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchPaginationDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SearchPaginationDto';

  static String? _$query(SearchPaginationDto v) => v.query;
  static const Field<SearchPaginationDto, String> _f$query =
      Field('query', _$query, opt: true);
  static int? _$page(SearchPaginationDto v) => v.page;
  static const Field<SearchPaginationDto, int> _f$page =
      Field('page', _$page, opt: true);
  static int? _$limit(SearchPaginationDto v) => v.limit;
  static const Field<SearchPaginationDto, int> _f$limit =
      Field('limit', _$limit, opt: true);

  @override
  final MappableFields<SearchPaginationDto> fields = const {
    #query: _f$query,
    #page: _f$page,
    #limit: _f$limit,
  };

  static SearchPaginationDto _instantiate(DecodingData data) {
    return SearchPaginationDto(
        query: data.dec(_f$query),
        page: data.dec(_f$page),
        limit: data.dec(_f$limit));
  }

  @override
  final Function instantiate = _instantiate;

  static SearchPaginationDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchPaginationDto>(map);
  }

  static SearchPaginationDto fromJson(String json) {
    return ensureInitialized().decodeJson<SearchPaginationDto>(json);
  }
}

mixin SearchPaginationDtoMappable {
  String toJson() {
    return SearchPaginationDtoMapper.ensureInitialized()
        .encodeJson<SearchPaginationDto>(this as SearchPaginationDto);
  }

  Map<String, dynamic> toMap() {
    return SearchPaginationDtoMapper.ensureInitialized()
        .encodeMap<SearchPaginationDto>(this as SearchPaginationDto);
  }

  SearchPaginationDtoCopyWith<SearchPaginationDto, SearchPaginationDto,
          SearchPaginationDto>
      get copyWith => _SearchPaginationDtoCopyWithImpl(
          this as SearchPaginationDto, $identity, $identity);
  @override
  String toString() {
    return SearchPaginationDtoMapper.ensureInitialized()
        .stringifyValue(this as SearchPaginationDto);
  }

  @override
  bool operator ==(Object other) {
    return SearchPaginationDtoMapper.ensureInitialized()
        .equalsValue(this as SearchPaginationDto, other);
  }

  @override
  int get hashCode {
    return SearchPaginationDtoMapper.ensureInitialized()
        .hashValue(this as SearchPaginationDto);
  }
}

extension SearchPaginationDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchPaginationDto, $Out> {
  SearchPaginationDtoCopyWith<$R, SearchPaginationDto, $Out>
      get $asSearchPaginationDto =>
          $base.as((v, t, t2) => _SearchPaginationDtoCopyWithImpl(v, t, t2));
}

abstract class SearchPaginationDtoCopyWith<$R, $In extends SearchPaginationDto,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? query, int? page, int? limit});
  SearchPaginationDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SearchPaginationDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchPaginationDto, $Out>
    implements SearchPaginationDtoCopyWith<$R, SearchPaginationDto, $Out> {
  _SearchPaginationDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchPaginationDto> $mapper =
      SearchPaginationDtoMapper.ensureInitialized();
  @override
  $R call(
          {Object? query = $none,
          Object? page = $none,
          Object? limit = $none}) =>
      $apply(FieldCopyWithData({
        if (query != $none) #query: query,
        if (page != $none) #page: page,
        if (limit != $none) #limit: limit
      }));
  @override
  SearchPaginationDto $make(CopyWithData data) => SearchPaginationDto(
      query: data.get(#query, or: $value.query),
      page: data.get(#page, or: $value.page),
      limit: data.get(#limit, or: $value.limit));

  @override
  SearchPaginationDtoCopyWith<$R2, SearchPaginationDto, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SearchPaginationDtoCopyWithImpl($value, $cast, t);
}
