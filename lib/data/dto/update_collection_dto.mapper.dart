// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'update_collection_dto.dart';

class UpdateCollectionDtoMapper extends ClassMapperBase<UpdateCollectionDto> {
  UpdateCollectionDtoMapper._();

  static UpdateCollectionDtoMapper? _instance;
  static UpdateCollectionDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpdateCollectionDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UpdateCollectionDto';

  static String _$title(UpdateCollectionDto v) => v.title;
  static const Field<UpdateCollectionDto, String> _f$title =
      Field('title', _$title);
  static bool _$private(UpdateCollectionDto v) => v.private;
  static const Field<UpdateCollectionDto, bool> _f$private =
      Field('private', _$private);

  @override
  final MappableFields<UpdateCollectionDto> fields = const {
    #title: _f$title,
    #private: _f$private,
  };

  static UpdateCollectionDto _instantiate(DecodingData data) {
    return UpdateCollectionDto(
        title: data.dec(_f$title), private: data.dec(_f$private));
  }

  @override
  final Function instantiate = _instantiate;

  static UpdateCollectionDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpdateCollectionDto>(map);
  }

  static UpdateCollectionDto fromJson(String json) {
    return ensureInitialized().decodeJson<UpdateCollectionDto>(json);
  }
}

mixin UpdateCollectionDtoMappable {
  String toJson() {
    return UpdateCollectionDtoMapper.ensureInitialized()
        .encodeJson<UpdateCollectionDto>(this as UpdateCollectionDto);
  }

  Map<String, dynamic> toMap() {
    return UpdateCollectionDtoMapper.ensureInitialized()
        .encodeMap<UpdateCollectionDto>(this as UpdateCollectionDto);
  }

  UpdateCollectionDtoCopyWith<UpdateCollectionDto, UpdateCollectionDto,
          UpdateCollectionDto>
      get copyWith => _UpdateCollectionDtoCopyWithImpl(
          this as UpdateCollectionDto, $identity, $identity);
  @override
  String toString() {
    return UpdateCollectionDtoMapper.ensureInitialized()
        .stringifyValue(this as UpdateCollectionDto);
  }

  @override
  bool operator ==(Object other) {
    return UpdateCollectionDtoMapper.ensureInitialized()
        .equalsValue(this as UpdateCollectionDto, other);
  }

  @override
  int get hashCode {
    return UpdateCollectionDtoMapper.ensureInitialized()
        .hashValue(this as UpdateCollectionDto);
  }
}

extension UpdateCollectionDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpdateCollectionDto, $Out> {
  UpdateCollectionDtoCopyWith<$R, UpdateCollectionDto, $Out>
      get $asUpdateCollectionDto =>
          $base.as((v, t, t2) => _UpdateCollectionDtoCopyWithImpl(v, t, t2));
}

abstract class UpdateCollectionDtoCopyWith<$R, $In extends UpdateCollectionDto,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, bool? private});
  UpdateCollectionDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _UpdateCollectionDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpdateCollectionDto, $Out>
    implements UpdateCollectionDtoCopyWith<$R, UpdateCollectionDto, $Out> {
  _UpdateCollectionDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpdateCollectionDto> $mapper =
      UpdateCollectionDtoMapper.ensureInitialized();
  @override
  $R call({String? title, bool? private}) => $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (private != null) #private: private
      }));
  @override
  UpdateCollectionDto $make(CopyWithData data) => UpdateCollectionDto(
      title: data.get(#title, or: $value.title),
      private: data.get(#private, or: $value.private));

  @override
  UpdateCollectionDtoCopyWith<$R2, UpdateCollectionDto, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _UpdateCollectionDtoCopyWithImpl($value, $cast, t);
}
