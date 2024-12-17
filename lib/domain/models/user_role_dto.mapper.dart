// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_role_dto.dart';

class UserRoleDtoMapper extends ClassMapperBase<UserRoleDto> {
  UserRoleDtoMapper._();

  static UserRoleDtoMapper? _instance;
  static UserRoleDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserRoleDtoMapper._());
      UserRoleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserRoleDto';

  static UserRole _$role(UserRoleDto v) => v.role;
  static const Field<UserRoleDto, UserRole> _f$role = Field('role', _$role);

  @override
  final MappableFields<UserRoleDto> fields = const {
    #role: _f$role,
  };

  static UserRoleDto _instantiate(DecodingData data) {
    return UserRoleDto(role: data.dec(_f$role));
  }

  @override
  final Function instantiate = _instantiate;

  static UserRoleDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserRoleDto>(map);
  }

  static UserRoleDto fromJson(String json) {
    return ensureInitialized().decodeJson<UserRoleDto>(json);
  }
}

mixin UserRoleDtoMappable {
  String toJson() {
    return UserRoleDtoMapper.ensureInitialized()
        .encodeJson<UserRoleDto>(this as UserRoleDto);
  }

  Map<String, dynamic> toMap() {
    return UserRoleDtoMapper.ensureInitialized()
        .encodeMap<UserRoleDto>(this as UserRoleDto);
  }

  UserRoleDtoCopyWith<UserRoleDto, UserRoleDto, UserRoleDto> get copyWith =>
      _UserRoleDtoCopyWithImpl(this as UserRoleDto, $identity, $identity);
  @override
  String toString() {
    return UserRoleDtoMapper.ensureInitialized()
        .stringifyValue(this as UserRoleDto);
  }

  @override
  bool operator ==(Object other) {
    return UserRoleDtoMapper.ensureInitialized()
        .equalsValue(this as UserRoleDto, other);
  }

  @override
  int get hashCode {
    return UserRoleDtoMapper.ensureInitialized().hashValue(this as UserRoleDto);
  }
}

extension UserRoleDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserRoleDto, $Out> {
  UserRoleDtoCopyWith<$R, UserRoleDto, $Out> get $asUserRoleDto =>
      $base.as((v, t, t2) => _UserRoleDtoCopyWithImpl(v, t, t2));
}

abstract class UserRoleDtoCopyWith<$R, $In extends UserRoleDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({UserRole? role});
  UserRoleDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserRoleDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserRoleDto, $Out>
    implements UserRoleDtoCopyWith<$R, UserRoleDto, $Out> {
  _UserRoleDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserRoleDto> $mapper =
      UserRoleDtoMapper.ensureInitialized();
  @override
  $R call({UserRole? role}) =>
      $apply(FieldCopyWithData({if (role != null) #role: role}));
  @override
  UserRoleDto $make(CopyWithData data) =>
      UserRoleDto(role: data.get(#role, or: $value.role));

  @override
  UserRoleDtoCopyWith<$R2, UserRoleDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserRoleDtoCopyWithImpl($value, $cast, t);
}
