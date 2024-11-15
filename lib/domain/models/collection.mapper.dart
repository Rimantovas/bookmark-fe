// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'collection.dart';

class CollectionMapper extends ClassMapperBase<Collection> {
  CollectionMapper._();

  static CollectionMapper? _instance;
  static CollectionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CollectionMapper._());
      BookmarkMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Collection';

  static String _$id(Collection v) => v.id;
  static const Field<Collection, String> _f$id = Field('id', _$id);
  static String _$title(Collection v) => v.title;
  static const Field<Collection, String> _f$title = Field('title', _$title);
  static bool _$private(Collection v) => v.private;
  static const Field<Collection, bool> _f$private = Field('private', _$private);
  static DateTime _$createdAt(Collection v) => v.createdAt;
  static const Field<Collection, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, key: 'created_at');
  static DateTime _$updatedAt(Collection v) => v.updatedAt;
  static const Field<Collection, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt, key: 'updated_at');
  static String _$userId(Collection v) => v.userId;
  static const Field<Collection, String> _f$userId =
      Field('userId', _$userId, key: 'user_id');
  static List<Bookmark>? _$bookmarks(Collection v) => v.bookmarks;
  static const Field<Collection, List<Bookmark>> _f$bookmarks =
      Field('bookmarks', _$bookmarks, opt: true);

  @override
  final MappableFields<Collection> fields = const {
    #id: _f$id,
    #title: _f$title,
    #private: _f$private,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #userId: _f$userId,
    #bookmarks: _f$bookmarks,
  };

  static Collection _instantiate(DecodingData data) {
    return Collection(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        private: data.dec(_f$private),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt),
        userId: data.dec(_f$userId),
        bookmarks: data.dec(_f$bookmarks));
  }

  @override
  final Function instantiate = _instantiate;

  static Collection fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Collection>(map);
  }

  static Collection fromJson(String json) {
    return ensureInitialized().decodeJson<Collection>(json);
  }
}

mixin CollectionMappable {
  String toJson() {
    return CollectionMapper.ensureInitialized()
        .encodeJson<Collection>(this as Collection);
  }

  Map<String, dynamic> toMap() {
    return CollectionMapper.ensureInitialized()
        .encodeMap<Collection>(this as Collection);
  }

  CollectionCopyWith<Collection, Collection, Collection> get copyWith =>
      _CollectionCopyWithImpl(this as Collection, $identity, $identity);
  @override
  String toString() {
    return CollectionMapper.ensureInitialized()
        .stringifyValue(this as Collection);
  }

  @override
  bool operator ==(Object other) {
    return CollectionMapper.ensureInitialized()
        .equalsValue(this as Collection, other);
  }

  @override
  int get hashCode {
    return CollectionMapper.ensureInitialized().hashValue(this as Collection);
  }
}

extension CollectionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Collection, $Out> {
  CollectionCopyWith<$R, Collection, $Out> get $asCollection =>
      $base.as((v, t, t2) => _CollectionCopyWithImpl(v, t, t2));
}

abstract class CollectionCopyWith<$R, $In extends Collection, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Bookmark, BookmarkCopyWith<$R, Bookmark, Bookmark>>?
      get bookmarks;
  $R call(
      {String? id,
      String? title,
      bool? private,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? userId,
      List<Bookmark>? bookmarks});
  CollectionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CollectionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Collection, $Out>
    implements CollectionCopyWith<$R, Collection, $Out> {
  _CollectionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Collection> $mapper =
      CollectionMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Bookmark, BookmarkCopyWith<$R, Bookmark, Bookmark>>?
      get bookmarks => $value.bookmarks != null
          ? ListCopyWith($value.bookmarks!, (v, t) => v.copyWith.$chain(t),
              (v) => call(bookmarks: v))
          : null;
  @override
  $R call(
          {String? id,
          String? title,
          bool? private,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? userId,
          Object? bookmarks = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (private != null) #private: private,
        if (createdAt != null) #createdAt: createdAt,
        if (updatedAt != null) #updatedAt: updatedAt,
        if (userId != null) #userId: userId,
        if (bookmarks != $none) #bookmarks: bookmarks
      }));
  @override
  Collection $make(CopyWithData data) => Collection(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      private: data.get(#private, or: $value.private),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt),
      userId: data.get(#userId, or: $value.userId),
      bookmarks: data.get(#bookmarks, or: $value.bookmarks));

  @override
  CollectionCopyWith<$R2, Collection, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CollectionCopyWithImpl($value, $cast, t);
}
