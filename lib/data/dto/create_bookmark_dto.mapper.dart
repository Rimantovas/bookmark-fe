// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'create_bookmark_dto.dart';

class CreateBookmarkDtoMapper extends ClassMapperBase<CreateBookmarkDto> {
  CreateBookmarkDtoMapper._();

  static CreateBookmarkDtoMapper? _instance;
  static CreateBookmarkDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CreateBookmarkDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CreateBookmarkDto';

  static String _$link(CreateBookmarkDto v) => v.link;
  static const Field<CreateBookmarkDto, String> _f$link = Field('link', _$link);
  static String? _$title(CreateBookmarkDto v) => v.title;
  static const Field<CreateBookmarkDto, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$description(CreateBookmarkDto v) => v.description;
  static const Field<CreateBookmarkDto, String> _f$description =
      Field('description', _$description, opt: true);
  static String? _$imageUrl(CreateBookmarkDto v) => v.imageUrl;
  static const Field<CreateBookmarkDto, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl, key: 'image_url', opt: true);
  static List<String>? _$tagIds(CreateBookmarkDto v) => v.tagIds;
  static const Field<CreateBookmarkDto, List<String>> _f$tagIds =
      Field('tagIds', _$tagIds, opt: true);
  static String? _$appId(CreateBookmarkDto v) => v.appId;
  static const Field<CreateBookmarkDto, String> _f$appId =
      Field('appId', _$appId, opt: true);
  static String _$collectionId(CreateBookmarkDto v) => v.collectionId;
  static const Field<CreateBookmarkDto, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static Map<String, dynamic>? _$metadata(CreateBookmarkDto v) => v.metadata;
  static const Field<CreateBookmarkDto, Map<String, dynamic>> _f$metadata =
      Field('metadata', _$metadata, opt: true);

  @override
  final MappableFields<CreateBookmarkDto> fields = const {
    #link: _f$link,
    #title: _f$title,
    #description: _f$description,
    #imageUrl: _f$imageUrl,
    #tagIds: _f$tagIds,
    #appId: _f$appId,
    #collectionId: _f$collectionId,
    #metadata: _f$metadata,
  };

  static CreateBookmarkDto _instantiate(DecodingData data) {
    return CreateBookmarkDto(
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

  static CreateBookmarkDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CreateBookmarkDto>(map);
  }

  static CreateBookmarkDto fromJson(String json) {
    return ensureInitialized().decodeJson<CreateBookmarkDto>(json);
  }
}

mixin CreateBookmarkDtoMappable {
  String toJson() {
    return CreateBookmarkDtoMapper.ensureInitialized()
        .encodeJson<CreateBookmarkDto>(this as CreateBookmarkDto);
  }

  Map<String, dynamic> toMap() {
    return CreateBookmarkDtoMapper.ensureInitialized()
        .encodeMap<CreateBookmarkDto>(this as CreateBookmarkDto);
  }

  CreateBookmarkDtoCopyWith<CreateBookmarkDto, CreateBookmarkDto,
          CreateBookmarkDto>
      get copyWith => _CreateBookmarkDtoCopyWithImpl(
          this as CreateBookmarkDto, $identity, $identity);
  @override
  String toString() {
    return CreateBookmarkDtoMapper.ensureInitialized()
        .stringifyValue(this as CreateBookmarkDto);
  }

  @override
  bool operator ==(Object other) {
    return CreateBookmarkDtoMapper.ensureInitialized()
        .equalsValue(this as CreateBookmarkDto, other);
  }

  @override
  int get hashCode {
    return CreateBookmarkDtoMapper.ensureInitialized()
        .hashValue(this as CreateBookmarkDto);
  }
}

extension CreateBookmarkDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CreateBookmarkDto, $Out> {
  CreateBookmarkDtoCopyWith<$R, CreateBookmarkDto, $Out>
      get $asCreateBookmarkDto =>
          $base.as((v, t, t2) => _CreateBookmarkDtoCopyWithImpl(v, t, t2));
}

abstract class CreateBookmarkDtoCopyWith<$R, $In extends CreateBookmarkDto,
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
  CreateBookmarkDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CreateBookmarkDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CreateBookmarkDto, $Out>
    implements CreateBookmarkDtoCopyWith<$R, CreateBookmarkDto, $Out> {
  _CreateBookmarkDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CreateBookmarkDto> $mapper =
      CreateBookmarkDtoMapper.ensureInitialized();
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
          {String? link,
          Object? title = $none,
          Object? description = $none,
          Object? imageUrl = $none,
          Object? tagIds = $none,
          Object? appId = $none,
          String? collectionId,
          Object? metadata = $none}) =>
      $apply(FieldCopyWithData({
        if (link != null) #link: link,
        if (title != $none) #title: title,
        if (description != $none) #description: description,
        if (imageUrl != $none) #imageUrl: imageUrl,
        if (tagIds != $none) #tagIds: tagIds,
        if (appId != $none) #appId: appId,
        if (collectionId != null) #collectionId: collectionId,
        if (metadata != $none) #metadata: metadata
      }));
  @override
  CreateBookmarkDto $make(CopyWithData data) => CreateBookmarkDto(
      link: data.get(#link, or: $value.link),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      tagIds: data.get(#tagIds, or: $value.tagIds),
      appId: data.get(#appId, or: $value.appId),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      metadata: data.get(#metadata, or: $value.metadata));

  @override
  CreateBookmarkDtoCopyWith<$R2, CreateBookmarkDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CreateBookmarkDtoCopyWithImpl($value, $cast, t);
}
