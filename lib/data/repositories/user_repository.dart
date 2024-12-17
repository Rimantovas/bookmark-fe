import 'package:app/data/dto/search_pagination_dto.dart';
import 'package:app/data/dto/user_response_dto.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/domain/models/user_role_dto.dart';
import 'package:app/main.dart';

class UserRepository {
  static const _kBasePath = '/auth';
  static const _kUsersPath = '/users';
  static const _kLoginPath = '$_kBasePath/login';
  static const _kSearchUsersPath = '$_kUsersPath/search';

  Future<User> login() async {
    final response = await dio.post(_kLoginPath);

    return UserMapper.fromMap(response.data);
  }

  Future<List<UserResponseDto>> searchUsers(
    SearchPaginationDto searchPaginationDto,
  ) async {
    final response = await dio.get(_kSearchUsersPath,
        queryParameters: searchPaginationDto.toMap());

    return response.data.map((e) => UserResponseDtoMapper.fromMap(e)).toList();
  }

  Future<void> updateRole(UserRoleDto dto) async {
    await dio.post(
      '/users/role',
      data: dto.toMap(),
    );
  }
}
