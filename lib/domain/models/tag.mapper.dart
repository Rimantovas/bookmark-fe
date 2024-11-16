// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'tag.dart';

class TagMapper extends ClassMapperBase<Tag> {
  TagMapper._();

  static TagMapper? _instance;
  static TagMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TagMapper._());
      TagIconMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Tag';

  static String _$id(Tag v) => v.id;
  static const Field<Tag, String> _f$id = Field('id', _$id);
  static String _$name(Tag v) => v.name;
  static const Field<Tag, String> _f$name = Field('name', _$name);
  static Color _$color(Tag v) => v.color;
  static const Field<Tag, Color> _f$color =
      Field('color', _$color, hook: ColorHook());
  static TagIcon? _$icon(Tag v) => v.icon;
  static const Field<Tag, TagIcon> _f$icon = Field('icon', _$icon,
      opt: true, hook: SafeEnumHook<TagIcon>(TagIcon.values));

  @override
  final MappableFields<Tag> fields = const {
    #id: _f$id,
    #name: _f$name,
    #color: _f$color,
    #icon: _f$icon,
  };

  static Tag _instantiate(DecodingData data) {
    return Tag(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        color: data.dec(_f$color),
        icon: data.dec(_f$icon));
  }

  @override
  final Function instantiate = _instantiate;

  static Tag fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Tag>(map);
  }

  static Tag fromJson(String json) {
    return ensureInitialized().decodeJson<Tag>(json);
  }
}

mixin TagMappable {
  String toJson() {
    return TagMapper.ensureInitialized().encodeJson<Tag>(this as Tag);
  }

  Map<String, dynamic> toMap() {
    return TagMapper.ensureInitialized().encodeMap<Tag>(this as Tag);
  }

  TagCopyWith<Tag, Tag, Tag> get copyWith =>
      _TagCopyWithImpl(this as Tag, $identity, $identity);
  @override
  String toString() {
    return TagMapper.ensureInitialized().stringifyValue(this as Tag);
  }

  @override
  bool operator ==(Object other) {
    return TagMapper.ensureInitialized().equalsValue(this as Tag, other);
  }

  @override
  int get hashCode {
    return TagMapper.ensureInitialized().hashValue(this as Tag);
  }
}

extension TagValueCopy<$R, $Out> on ObjectCopyWith<$R, Tag, $Out> {
  TagCopyWith<$R, Tag, $Out> get $asTag =>
      $base.as((v, t, t2) => _TagCopyWithImpl(v, t, t2));
}

abstract class TagCopyWith<$R, $In extends Tag, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, Color? color, TagIcon? icon});
  TagCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TagCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Tag, $Out>
    implements TagCopyWith<$R, Tag, $Out> {
  _TagCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Tag> $mapper = TagMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, Color? color, Object? icon = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (color != null) #color: color,
        if (icon != $none) #icon: icon
      }));
  @override
  Tag $make(CopyWithData data) => Tag(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      color: data.get(#color, or: $value.color),
      icon: data.get(#icon, or: $value.icon));

  @override
  TagCopyWith<$R2, Tag, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TagCopyWithImpl($value, $cast, t);
}
