import 'package:app/data/dto/create_bookmark_dto.dart';
import 'package:app/data/dto/update_bookmark_dto.dart';
import 'package:app/domain/models/bookmark.dart';
import 'package:app/main.dart';

class BookmarkRepository {
  static const _kBasePath = '/bookmarks';
  static const _kSearchPath = '$_kBasePath/search';

  Future<Bookmark> createBookmark(CreateBookmarkDto dto) async {
    final response = await dio.post(
      _kBasePath,
      data: dto.toMap(),
    );
    return BookmarkMapper.fromMap(response.data);
  }

  Future<List<Bookmark>> searchBookmarks(String query) async {
    final response = await dio.get(
      _kSearchPath,
      queryParameters: {'q': query},
    );
    return (response.data as List<dynamic>)
        .map((e) => BookmarkMapper.fromMap(e))
        .toList();
  }

  Future<Bookmark> getBookmark(String id) async {
    final response = await dio.get('$_kBasePath/$id');
    return BookmarkMapper.fromMap(response.data);
  }

  Future<Bookmark> updateBookmark(
    String id,
    UpdateBookmarkDto dto,
  ) async {
    final response = await dio.put(
      '$_kBasePath/$id',
      data: dto.toMap(),
    );
    return BookmarkMapper.fromMap(response.data);
  }

  Future<void> deleteBookmark(String id) async {
    await dio.delete('$_kBasePath/$id');
  }
}
