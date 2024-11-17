import 'package:app/data/dto/create_collection_dto.dart';
import 'package:app/data/dto/search_pagination_dto.dart';
import 'package:app/data/dto/update_collection_dto.dart';
import 'package:app/domain/models/bookmark.dart';
import 'package:app/domain/models/collection.dart';
import 'package:app/main.dart';

class CollectionsRepository {
  static const _kBasePath = '/collections';
  static const _kSearchPath = '$_kBasePath/search';
  static const _kBookmarksPath = '/bookmarks';

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

  Future<Collection> createCollection(CreateCollectionDto dto) async {
    final response = await dio.post(
      _kBasePath,
      data: dto.toMap(),
    );
    return CollectionMapper.fromMap(response.data);
  }

  Future<Collection> updateCollection(
    String id,
    UpdateCollectionDto dto,
  ) async {
    final response = await dio.put(
      '$_kBasePath/$id',
      data: dto.toMap(),
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

  Future<List<Bookmark>> getCollectionBookmarks(String collectionId) async {
    final response = await dio.get('$_kBasePath/$collectionId$_kBookmarksPath');
    return (response.data as List<dynamic>)
        .map((e) => BookmarkMapper.fromMap(e))
        .toList();
  }
}
