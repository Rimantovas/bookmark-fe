// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bookmark.dart';

class BookmarkMapper extends ClassMapperBase<Bookmark> {
  BookmarkMapper._();

  static BookmarkMapper? _instance;
  static BookmarkMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookmarkMapper._());
      TagMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Bookmark';

  static String _$id(Bookmark v) => v.id;
  static const Field<Bookmark, String> _f$id = Field('id', _$id);
  static String _$link(Bookmark v) => v.link;
  static const Field<Bookmark, String> _f$link = Field('link', _$link);
  static String? _$title(Bookmark v) => v.title;
  static const Field<Bookmark, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$description(Bookmark v) => v.description;
  static const Field<Bookmark, String> _f$description =
      Field('description', _$description, opt: true);
  static String? _$imageUrl(Bookmark v) => v.imageUrl;
  static const Field<Bookmark, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl, key: 'image_url', opt: true);
  static List<Tag> _$tags(Bookmark v) => v.tags;
  static const Field<Bookmark, List<Tag>> _f$tags = Field('tags', _$tags);
  static String? _$appId(Bookmark v) => v.appId;
  static const Field<Bookmark, String> _f$appId =
      Field('appId', _$appId, opt: true);
  static String _$collectionId(Bookmark v) => v.collectionId;
  static const Field<Bookmark, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$userId(Bookmark v) => v.userId;
  static const Field<Bookmark, String> _f$userId = Field('userId', _$userId);
  static Map<String, dynamic>? _$metadata(Bookmark v) => v.metadata;
  static const Field<Bookmark, Map<String, dynamic>> _f$metadata =
      Field('metadata', _$metadata, opt: true);
  static DateTime _$createdAt(Bookmark v) => v.createdAt;
  static const Field<Bookmark, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt);
  static DateTime _$updatedAt(Bookmark v) => v.updatedAt;
  static const Field<Bookmark, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt);

  @override
  final MappableFields<Bookmark> fields = const {
    #id: _f$id,
    #link: _f$link,
    #title: _f$title,
    #description: _f$description,
    #imageUrl: _f$imageUrl,
    #tags: _f$tags,
    #appId: _f$appId,
    #collectionId: _f$collectionId,
    #userId: _f$userId,
    #metadata: _f$metadata,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static Bookmark _instantiate(DecodingData data) {
    return Bookmark(
        id: data.dec(_f$id),
        link: data.dec(_f$link),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        imageUrl: data.dec(_f$imageUrl),
        tags: data.dec(_f$tags),
        appId: data.dec(_f$appId),
        collectionId: data.dec(_f$collectionId),
        userId: data.dec(_f$userId),
        metadata: data.dec(_f$metadata),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static Bookmark fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Bookmark>(map);
  }

  static Bookmark fromJson(String json) {
    return ensureInitialized().decodeJson<Bookmark>(json);
  }
}

mixin BookmarkMappable {
  String toJson() {
    return BookmarkMapper.ensureInitialized()
        .encodeJson<Bookmark>(this as Bookmark);
  }

  Map<String, dynamic> toMap() {
    return BookmarkMapper.ensureInitialized()
        .encodeMap<Bookmark>(this as Bookmark);
  }

  BookmarkCopyWith<Bookmark, Bookmark, Bookmark> get copyWith =>
      _BookmarkCopyWithImpl(this as Bookmark, $identity, $identity);
  @override
  String toString() {
    return BookmarkMapper.ensureInitialized().stringifyValue(this as Bookmark);
  }

  @override
  bool operator ==(Object other) {
    return BookmarkMapper.ensureInitialized()
        .equalsValue(this as Bookmark, other);
  }

  @override
  int get hashCode {
    return BookmarkMapper.ensureInitialized().hashValue(this as Bookmark);
  }
}

extension BookmarkValueCopy<$R, $Out> on ObjectCopyWith<$R, Bookmark, $Out> {
  BookmarkCopyWith<$R, Bookmark, $Out> get $asBookmark =>
      $base.as((v, t, t2) => _BookmarkCopyWithImpl(v, t, t2));
}

abstract class BookmarkCopyWith<$R, $In extends Bookmark, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Tag, TagCopyWith<$R, Tag, Tag>> get tags;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get metadata;
  $R call(
      {String? id,
      String? link,
      String? title,
      String? description,
      String? imageUrl,
      List<Tag>? tags,
      String? appId,
      String? collectionId,
      String? userId,
      Map<String, dynamic>? metadata,
      DateTime? createdAt,
      DateTime? updatedAt});
  BookmarkCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookmarkCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Bookmark, $Out>
    implements BookmarkCopyWith<$R, Bookmark, $Out> {
  _BookmarkCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Bookmark> $mapper =
      BookmarkMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Tag, TagCopyWith<$R, Tag, Tag>> get tags => ListCopyWith(
      $value.tags, (v, t) => v.copyWith.$chain(t), (v) => call(tags: v));
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
          {String? id,
          String? link,
          Object? title = $none,
          Object? description = $none,
          Object? imageUrl = $none,
          List<Tag>? tags,
          Object? appId = $none,
          String? collectionId,
          String? userId,
          Object? metadata = $none,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (link != null) #link: link,
        if (title != $none) #title: title,
        if (description != $none) #description: description,
        if (imageUrl != $none) #imageUrl: imageUrl,
        if (tags != null) #tags: tags,
        if (appId != $none) #appId: appId,
        if (collectionId != null) #collectionId: collectionId,
        if (userId != null) #userId: userId,
        if (metadata != $none) #metadata: metadata,
        if (createdAt != null) #createdAt: createdAt,
        if (updatedAt != null) #updatedAt: updatedAt
      }));
  @override
  Bookmark $make(CopyWithData data) => Bookmark(
      id: data.get(#id, or: $value.id),
      link: data.get(#link, or: $value.link),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      tags: data.get(#tags, or: $value.tags),
      appId: data.get(#appId, or: $value.appId),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      userId: data.get(#userId, or: $value.userId),
      metadata: data.get(#metadata, or: $value.metadata),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt));

  @override
  BookmarkCopyWith<$R2, Bookmark, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BookmarkCopyWithImpl($value, $cast, t);
}
