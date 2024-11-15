// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'create_tag_dto.dart';

class CreateTagDtoMapper extends ClassMapperBase<CreateTagDto> {
  CreateTagDtoMapper._();

  static CreateTagDtoMapper? _instance;
  static CreateTagDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CreateTagDtoMapper._());
      TagIconMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CreateTagDto';

  static String _$name(CreateTagDto v) => v.name;
  static const Field<CreateTagDto, String> _f$name = Field('name', _$name);
  static Color _$color(CreateTagDto v) => v.color;
  static const Field<CreateTagDto, Color> _f$color = Field('color', _$color);
  static TagIcon? _$icon(CreateTagDto v) => v.icon;
  static const Field<CreateTagDto, TagIcon> _f$icon =
      Field('icon', _$icon, opt: true);

  @override
  final MappableFields<CreateTagDto> fields = const {
    #name: _f$name,
    #color: _f$color,
    #icon: _f$icon,
  };

  @override
  final MappingHook hook = const ColorHook();
  static CreateTagDto _instantiate(DecodingData data) {
    return CreateTagDto(
        name: data.dec(_f$name),
        color: data.dec(_f$color),
        icon: data.dec(_f$icon));
  }

  @override
  final Function instantiate = _instantiate;

  static CreateTagDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CreateTagDto>(map);
  }

  static CreateTagDto fromJson(String json) {
    return ensureInitialized().decodeJson<CreateTagDto>(json);
  }
}

mixin CreateTagDtoMappable {
  String toJson() {
    return CreateTagDtoMapper.ensureInitialized()
        .encodeJson<CreateTagDto>(this as CreateTagDto);
  }

  Map<String, dynamic> toMap() {
    return CreateTagDtoMapper.ensureInitialized()
        .encodeMap<CreateTagDto>(this as CreateTagDto);
  }

  CreateTagDtoCopyWith<CreateTagDto, CreateTagDto, CreateTagDto> get copyWith =>
      _CreateTagDtoCopyWithImpl(this as CreateTagDto, $identity, $identity);
  @override
  String toString() {
    return CreateTagDtoMapper.ensureInitialized()
        .stringifyValue(this as CreateTagDto);
  }

  @override
  bool operator ==(Object other) {
    return CreateTagDtoMapper.ensureInitialized()
        .equalsValue(this as CreateTagDto, other);
  }

  @override
  int get hashCode {
    return CreateTagDtoMapper.ensureInitialized()
        .hashValue(this as CreateTagDto);
  }
}

extension CreateTagDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CreateTagDto, $Out> {
  CreateTagDtoCopyWith<$R, CreateTagDto, $Out> get $asCreateTagDto =>
      $base.as((v, t, t2) => _CreateTagDtoCopyWithImpl(v, t, t2));
}

abstract class CreateTagDtoCopyWith<$R, $In extends CreateTagDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, Color? color, TagIcon? icon});
  CreateTagDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CreateTagDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CreateTagDto, $Out>
    implements CreateTagDtoCopyWith<$R, CreateTagDto, $Out> {
  _CreateTagDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CreateTagDto> $mapper =
      CreateTagDtoMapper.ensureInitialized();
  @override
  $R call({String? name, Color? color, Object? icon = $none}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (color != null) #color: color,
        if (icon != $none) #icon: icon
      }));
  @override
  CreateTagDto $make(CopyWithData data) => CreateTagDto(
      name: data.get(#name, or: $value.name),
      color: data.get(#color, or: $value.color),
      icon: data.get(#icon, or: $value.icon));

  @override
  CreateTagDtoCopyWith<$R2, CreateTagDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CreateTagDtoCopyWithImpl($value, $cast, t);
}
