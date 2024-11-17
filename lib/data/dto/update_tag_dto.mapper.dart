// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'update_tag_dto.dart';

class UpdateTagDtoMapper extends ClassMapperBase<UpdateTagDto> {
  UpdateTagDtoMapper._();

  static UpdateTagDtoMapper? _instance;
  static UpdateTagDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpdateTagDtoMapper._());
      TagIconMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UpdateTagDto';

  static String? _$name(UpdateTagDto v) => v.name;
  static const Field<UpdateTagDto, String> _f$name =
      Field('name', _$name, opt: true);
  static Color? _$color(UpdateTagDto v) => v.color;
  static const Field<UpdateTagDto, Color> _f$color =
      Field('color', _$color, opt: true, hook: ColorHook());
  static TagIcon? _$icon(UpdateTagDto v) => v.icon;
  static const Field<UpdateTagDto, TagIcon> _f$icon =
      Field('icon', _$icon, opt: true);

  @override
  final MappableFields<UpdateTagDto> fields = const {
    #name: _f$name,
    #color: _f$color,
    #icon: _f$icon,
  };

  static UpdateTagDto _instantiate(DecodingData data) {
    return UpdateTagDto(
        name: data.dec(_f$name),
        color: data.dec(_f$color),
        icon: data.dec(_f$icon));
  }

  @override
  final Function instantiate = _instantiate;

  static UpdateTagDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpdateTagDto>(map);
  }

  static UpdateTagDto fromJson(String json) {
    return ensureInitialized().decodeJson<UpdateTagDto>(json);
  }
}

mixin UpdateTagDtoMappable {
  String toJson() {
    return UpdateTagDtoMapper.ensureInitialized()
        .encodeJson<UpdateTagDto>(this as UpdateTagDto);
  }

  Map<String, dynamic> toMap() {
    return UpdateTagDtoMapper.ensureInitialized()
        .encodeMap<UpdateTagDto>(this as UpdateTagDto);
  }

  UpdateTagDtoCopyWith<UpdateTagDto, UpdateTagDto, UpdateTagDto> get copyWith =>
      _UpdateTagDtoCopyWithImpl(this as UpdateTagDto, $identity, $identity);
  @override
  String toString() {
    return UpdateTagDtoMapper.ensureInitialized()
        .stringifyValue(this as UpdateTagDto);
  }

  @override
  bool operator ==(Object other) {
    return UpdateTagDtoMapper.ensureInitialized()
        .equalsValue(this as UpdateTagDto, other);
  }

  @override
  int get hashCode {
    return UpdateTagDtoMapper.ensureInitialized()
        .hashValue(this as UpdateTagDto);
  }
}

extension UpdateTagDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpdateTagDto, $Out> {
  UpdateTagDtoCopyWith<$R, UpdateTagDto, $Out> get $asUpdateTagDto =>
      $base.as((v, t, t2) => _UpdateTagDtoCopyWithImpl(v, t, t2));
}

abstract class UpdateTagDtoCopyWith<$R, $In extends UpdateTagDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, Color? color, TagIcon? icon});
  UpdateTagDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UpdateTagDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpdateTagDto, $Out>
    implements UpdateTagDtoCopyWith<$R, UpdateTagDto, $Out> {
  _UpdateTagDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpdateTagDto> $mapper =
      UpdateTagDtoMapper.ensureInitialized();
  @override
  $R call(
          {Object? name = $none,
          Object? color = $none,
          Object? icon = $none}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (color != $none) #color: color,
        if (icon != $none) #icon: icon
      }));
  @override
  UpdateTagDto $make(CopyWithData data) => UpdateTagDto(
      name: data.get(#name, or: $value.name),
      color: data.get(#color, or: $value.color),
      icon: data.get(#icon, or: $value.icon));

  @override
  UpdateTagDtoCopyWith<$R2, UpdateTagDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UpdateTagDtoCopyWithImpl($value, $cast, t);
}
