import 'package:app/data/dto/search_pagination_dto.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/main.dart';

class CollectionsRepository {
  static const _kBasePath = '/collections';
  static const _kSearchPath = '$_kBasePath/search';

  Future<Collection> getCollection(String id) async {
    final response = await dio.get('$_kBasePath/$id');
    return CollectionMapper.fromMap(response.data);
  }

  Future<List<Collection>> getCollections() async {
    final response = await dio.get(_kBasePath);
    return (response.data as List<dynamic>)
        .map((e) => CollectionMapper.fromMap(e))
        .toList();
  }

  Future<Collection> createCollection(Collection collection) async {
    final response = await dio.post(
      _kBasePath,
      data: collection.toMap(),
    );
    return CollectionMapper.fromMap(response.data);
  }

  Future<Collection> updateCollection(
    String id,
    Collection collection,
  ) async {
    final response = await dio.put(
      '$_kBasePath/$id',
      data: collection.toMap(),
    );
    return CollectionMapper.fromMap(response.data);
  }

  Future<void> deleteCollection(String id) async {
    await dio.delete('$_kBasePath/$id');
  }

  Future<List<Collection>> searchCollections(
    SearchPaginationDto searchParams,
  ) async {
    final response = await dio.get(
      _kSearchPath,
      queryParameters: searchParams.toMap(),
    );
    return (response.data as List<dynamic>)
        .map((e) => CollectionMapper.fromMap(e))
        .toList();
  }
}
