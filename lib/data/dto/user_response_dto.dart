import 'package:app/domain/enums/user_role.dart';
import 'package:app/domain/models/user.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'user_response_dto.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase,
)
class UserResponseDto with UserResponseDtoMappable {
  final String id;
  final String name;
  final String username;
  final String imageUrl;

  UserResponseDto({
    required this.id,
    required this.name,
    required this.username,
    required this.imageUrl,
  });

  User toUser() => User(
        id: id,
        name: name,
        username: username,
        imageUrl: imageUrl,
        email: '',
        role: UserRole.regular,
      );
}
