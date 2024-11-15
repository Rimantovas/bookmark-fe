import 'package:app/data/dto/create_tag_dto.dart';
import 'package:app/data/dto/update_tag_dto.dart';
import 'package:app/domain/models/tag.dart';
import 'package:app/main.dart';

class TagRepository {
  static const _kBasePath = '/tags';

  Future<Tag> createTag(CreateTagDto dto) async {
    final response = await dio.post(_kBasePath, data: dto.toMap());
    return TagMapper.fromMap(response.data);
  }

  Future<List<Tag>> getTags() async {
    final response = await dio.get(_kBasePath);
    return (response.data as List)
        .map((json) => TagMapper.fromMap(json))
        .toList();
  }

  Future<Tag> getTag(String id) async {
    final response = await dio.get('$_kBasePath/$id');
    return TagMapper.fromMap(response.data);
  }

  Future<Tag> updateTag(String id, UpdateTagDto dto) async {
    final response = await dio.put('$_kBasePath/$id', data: dto.toMap());
    return TagMapper.fromMap(response.data);
  }

  Future<void> deleteTag(String id) async {
    await dio.delete('$_kBasePath/$id');
  }
}
