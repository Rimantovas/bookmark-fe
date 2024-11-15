import 'package:app/domain/models/collection.dart';
import 'package:app/main.dart';

class CollectionsRepository {
  static const String _kBasePath = '/collections';

  Future<List<Collection>> getCollections() async {
    final response = await dio.get(_kBasePath);

    return (response.data as List<dynamic>)
        .map((e) => CollectionMapper.fromMap(e))
        .toList();
  }
}
