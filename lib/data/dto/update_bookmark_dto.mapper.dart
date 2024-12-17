// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'update_bookmark_dto.dart';

class UpdateBookmarkDtoMapper extends ClassMapperBase<UpdateBookmarkDto> {
  UpdateBookmarkDtoMapper._();

  static UpdateBookmarkDtoMapper? _instance;
  static UpdateBookmarkDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpdateBookmarkDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UpdateBookmarkDto';

  static String? _$link(UpdateBookmarkDto v) => v.link;
  static const Field<UpdateBookmarkDto, String> _f$link =
      Field('link', _$link, opt: true);
  static String? _$title(UpdateBookmarkDto v) => v.title;
  static const Field<UpdateBookmarkDto, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$description(UpdateBookmarkDto v) => v.description;
  static const Field<UpdateBookmarkDto, String> _f$description =
      Field('description', _$description, opt: true);
  static String? _$imageUrl(UpdateBookmarkDto v) => v.imageUrl;
  static const Field<UpdateBookmarkDto, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl, key: 'image_url', opt: true);
  static List<String>? _$tagIds(UpdateBookmarkDto v) => v.tagIds;
  static const Field<UpdateBookmarkDto, List<String>> _f$tagIds =
      Field('tagIds', _$tagIds, opt: true);
  static String? _$appId(UpdateBookmarkDto v) => v.appId;
  static const Field<UpdateBookmarkDto, String> _f$appId =
      Field('appId', _$appId, opt: true);
  static String? _$collectionId(UpdateBookmarkDto v) => v.collectionId;
  static const Field<UpdateBookmarkDto, String> _f$collectionId =
      Field('collectionId', _$collectionId, opt: true);
  static Map<String, dynamic>? _$metadata(UpdateBookmarkDto v) => v.metadata;
  static const Field<UpdateBookmarkDto, Map<String, dynamic>> _f$metadata =
      Field('metadata', _$metadata, opt: true);

  @override
  final MappableFields<UpdateBookmarkDto> fields = const {
    #link: _f$link,
    #title: _f$title,
    #description: _f$description,
    #imageUrl: _f$imageUrl,
    #tagIds: _f$tagIds,
    #appId: _f$appId,
    #collectionId: _f$collectionId,
    #metadata: _f$metadata,
  };

  static UpdateBookmarkDto _instantiate(DecodingData data) {
    return UpdateBookmarkDto(
        link: data.dec(_f$link),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        imageUrl: data.dec(_f$imageUrl),
        tagIds: data.dec(_f$tagIds),
        appId: data.dec(_f$appId),
        collectionId: data.dec(_f$collectionId),
        metadata: data.dec(_f$metadata));
  }

  @override
  final Function instantiate = _instantiate;

  static UpdateBookmarkDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpdateBookmarkDto>(map);
  }

  static UpdateBookmarkDto fromJson(String json) {
    return ensureInitialized().decodeJson<UpdateBookmarkDto>(json);
  }
}

mixin UpdateBookmarkDtoMappable {
  String toJson() {
    return UpdateBookmarkDtoMapper.ensureInitialized()
        .encodeJson<UpdateBookmarkDto>(this as UpdateBookmarkDto);
  }

  Map<String, dynamic> toMap() {
    return UpdateBookmarkDtoMapper.ensureInitialized()
        .encodeMap<UpdateBookmarkDto>(this as UpdateBookmarkDto);
  }

  UpdateBookmarkDtoCopyWith<UpdateBookmarkDto, UpdateBookmarkDto,
          UpdateBookmarkDto>
      get copyWith => _UpdateBookmarkDtoCopyWithImpl(
          this as UpdateBookmarkDto, $identity, $identity);
  @override
  String toString() {
    return UpdateBookmarkDtoMapper.ensureInitialized()
        .stringifyValue(this as UpdateBookmarkDto);
  }

  @override
  bool operator ==(Object other) {
    return UpdateBookmarkDtoMapper.ensureInitialized()
        .equalsValue(this as UpdateBookmarkDto, other);
  }

  @override
  int get hashCode {
    return UpdateBookmarkDtoMapper.ensureInitialized()
        .hashValue(this as UpdateBookmarkDto);
  }
}

extension UpdateBookmarkDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpdateBookmarkDto, $Out> {
  UpdateBookmarkDtoCopyWith<$R, UpdateBookmarkDto, $Out>
      get $asUpdateBookmarkDto =>
          $base.as((v, t, t2) => _UpdateBookmarkDtoCopyWithImpl(v, t, t2));
}

abstract class UpdateBookmarkDtoCopyWith<$R, $In extends UpdateBookmarkDto,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get tagIds;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get metadata;
  $R call(
      {String? link,
      String? title,
      String? description,
      String? imageUrl,
      List<String>? tagIds,
      String? appId,
      String? collectionId,
      Map<String, dynamic>? metadata});
  UpdateBookmarkDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _UpdateBookmarkDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpdateBookmarkDto, $Out>
    implements UpdateBookmarkDtoCopyWith<$R, UpdateBookmarkDto, $Out> {
  _UpdateBookmarkDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpdateBookmarkDto> $mapper =
      UpdateBookmarkDtoMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get tagIds =>
      $value.tagIds != null
          ? ListCopyWith($value.tagIds!,
              (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(tagIds: v))
          : null;
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get metadata => $value.metadata != null
          ? MapCopyWith(
              $value.metadata!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(metadata: v))
          : null;
  @override
  $R call(
          {Object? link = $none,
          Object? title = $none,
          Object? description = $none,
          Object? imageUrl = $none,
          Object? tagIds = $none,
          Object? appId = $none,
          Object? collectionId = $none,
          Object? metadata = $none}) =>
      $apply(FieldCopyWithData({
        if (link != $none) #link: link,
        if (title != $none) #title: title,
        if (description != $none) #description: description,
        if (imageUrl != $none) #imageUrl: imageUrl,
        if (tagIds != $none) #tagIds: tagIds,
        if (appId != $none) #appId: appId,
        if (collectionId != $none) #collectionId: collectionId,
        if (metadata != $none) #metadata: metadata
      }));
  @override
  UpdateBookmarkDto $make(CopyWithData data) => UpdateBookmarkDto(
      link: data.get(#link, or: $value.link),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      tagIds: data.get(#tagIds, or: $value.tagIds),
      appId: data.get(#appId, or: $value.appId),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      metadata: data.get(#metadata, or: $value.metadata));

  @override
  UpdateBookmarkDtoCopyWith<$R2, UpdateBookmarkDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UpdateBookmarkDtoCopyWithImpl($value, $cast, t);
}
