// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_response_dto.dart';

class UserResponseDtoMapper extends ClassMapperBase<UserResponseDto> {
  UserResponseDtoMapper._();

  static UserResponseDtoMapper? _instance;
  static UserResponseDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserResponseDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserResponseDto';

  static String _$id(UserResponseDto v) => v.id;
  static const Field<UserResponseDto, String> _f$id = Field('id', _$id);
  static String _$name(UserResponseDto v) => v.name;
  static const Field<UserResponseDto, String> _f$name = Field('name', _$name);
  static String _$username(UserResponseDto v) => v.username;
  static const Field<UserResponseDto, String> _f$username =
      Field('username', _$username);
  static String _$imageUrl(UserResponseDto v) => v.imageUrl;
  static const Field<UserResponseDto, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl, key: 'image_url');

  @override
  final MappableFields<UserResponseDto> fields = const {
    #id: _f$id,
    #name: _f$name,
    #username: _f$username,
    #imageUrl: _f$imageUrl,
  };

  static UserResponseDto _instantiate(DecodingData data) {
    return UserResponseDto(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        username: data.dec(_f$username),
        imageUrl: data.dec(_f$imageUrl));
  }

  @override
  final Function instantiate = _instantiate;

  static UserResponseDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserResponseDto>(map);
  }

  static UserResponseDto fromJson(String json) {
    return ensureInitialized().decodeJson<UserResponseDto>(json);
  }
}

mixin UserResponseDtoMappable {
  String toJson() {
    return UserResponseDtoMapper.ensureInitialized()
        .encodeJson<UserResponseDto>(this as UserResponseDto);
  }

  Map<String, dynamic> toMap() {
    return UserResponseDtoMapper.ensureInitialized()
        .encodeMap<UserResponseDto>(this as UserResponseDto);
  }

  UserResponseDtoCopyWith<UserResponseDto, UserResponseDto, UserResponseDto>
      get copyWith => _UserResponseDtoCopyWithImpl(
          this as UserResponseDto, $identity, $identity);
  @override
  String toString() {
    return UserResponseDtoMapper.ensureInitialized()
        .stringifyValue(this as UserResponseDto);
  }

  @override
  bool operator ==(Object other) {
    return UserResponseDtoMapper.ensureInitialized()
        .equalsValue(this as UserResponseDto, other);
  }

  @override
  int get hashCode {
    return UserResponseDtoMapper.ensureInitialized()
        .hashValue(this as UserResponseDto);
  }
}

extension UserResponseDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserResponseDto, $Out> {
  UserResponseDtoCopyWith<$R, UserResponseDto, $Out> get $asUserResponseDto =>
      $base.as((v, t, t2) => _UserResponseDtoCopyWithImpl(v, t, t2));
}

abstract class UserResponseDtoCopyWith<$R, $In extends UserResponseDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? username, String? imageUrl});
  UserResponseDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _UserResponseDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserResponseDto, $Out>
    implements UserResponseDtoCopyWith<$R, UserResponseDto, $Out> {
  _UserResponseDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserResponseDto> $mapper =
      UserResponseDtoMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, String? username, String? imageUrl}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (username != null) #username: username,
        if (imageUrl != null) #imageUrl: imageUrl
      }));
  @override
  UserResponseDto $make(CopyWithData data) => UserResponseDto(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      username: data.get(#username, or: $value.username),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl));

  @override
  UserResponseDtoCopyWith<$R2, UserResponseDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserResponseDtoCopyWithImpl($value, $cast, t);
}
