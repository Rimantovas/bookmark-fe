// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'social_app.dart';

class SocialAppMapper extends ClassMapperBase<SocialApp> {
  SocialAppMapper._();

  static SocialAppMapper? _instance;
  static SocialAppMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocialAppMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SocialApp';

  static String _$id(SocialApp v) => v.id;
  static const Field<SocialApp, String> _f$id = Field('id', _$id);
  static String _$title(SocialApp v) => v.title;
  static const Field<SocialApp, String> _f$title = Field('title', _$title);
  static String _$image(SocialApp v) => v.image;
  static const Field<SocialApp, String> _f$image = Field('image', _$image);
  static String _$website(SocialApp v) => v.website;
  static const Field<SocialApp, String> _f$website =
      Field('website', _$website);
  static String _$deeplink(SocialApp v) => v.deeplink;
  static const Field<SocialApp, String> _f$deeplink =
      Field('deeplink', _$deeplink);

  @override
  final MappableFields<SocialApp> fields = const {
    #id: _f$id,
    #title: _f$title,
    #image: _f$image,
    #website: _f$website,
    #deeplink: _f$deeplink,
  };

  static SocialApp _instantiate(DecodingData data) {
    return SocialApp(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        image: data.dec(_f$image),
        website: data.dec(_f$website),
        deeplink: data.dec(_f$deeplink));
  }

  @override
  final Function instantiate = _instantiate;

  static SocialApp fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SocialApp>(map);
  }

  static SocialApp fromJson(String json) {
    return ensureInitialized().decodeJson<SocialApp>(json);
  }
}

mixin SocialAppMappable {
  String toJson() {
    return SocialAppMapper.ensureInitialized()
        .encodeJson<SocialApp>(this as SocialApp);
  }

  Map<String, dynamic> toMap() {
    return SocialAppMapper.ensureInitialized()
        .encodeMap<SocialApp>(this as SocialApp);
  }

  SocialAppCopyWith<SocialApp, SocialApp, SocialApp> get copyWith =>
      _SocialAppCopyWithImpl(this as SocialApp, $identity, $identity);
  @override
  String toString() {
    return SocialAppMapper.ensureInitialized()
        .stringifyValue(this as SocialApp);
  }

  @override
  bool operator ==(Object other) {
    return SocialAppMapper.ensureInitialized()
        .equalsValue(this as SocialApp, other);
  }

  @override
  int get hashCode {
    return SocialAppMapper.ensureInitialized().hashValue(this as SocialApp);
  }
}

extension SocialAppValueCopy<$R, $Out> on ObjectCopyWith<$R, SocialApp, $Out> {
  SocialAppCopyWith<$R, SocialApp, $Out> get $asSocialApp =>
      $base.as((v, t, t2) => _SocialAppCopyWithImpl(v, t, t2));
}

abstract class SocialAppCopyWith<$R, $In extends SocialApp, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? title,
      String? image,
      String? website,
      String? deeplink});
  SocialAppCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SocialAppCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SocialApp, $Out>
    implements SocialAppCopyWith<$R, SocialApp, $Out> {
  _SocialAppCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SocialApp> $mapper =
      SocialAppMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? title,
          String? image,
          String? website,
          String? deeplink}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (image != null) #image: image,
        if (website != null) #website: website,
        if (deeplink != null) #deeplink: deeplink
      }));
  @override
  SocialApp $make(CopyWithData data) => SocialApp(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      image: data.get(#image, or: $value.image),
      website: data.get(#website, or: $value.website),
      deeplink: data.get(#deeplink, or: $value.deeplink));

  @override
  SocialAppCopyWith<$R2, SocialApp, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SocialAppCopyWithImpl($value, $cast, t);
}
