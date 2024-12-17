import 'package:app/domain/enums/user_role.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'user_role_dto.mapper.dart';

@MappableClass()
class UserRoleDto with UserRoleDtoMappable {
  final UserRole role;

  const UserRoleDto({required this.role});
}
