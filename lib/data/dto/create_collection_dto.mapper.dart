// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'create_collection_dto.dart';

class CreateCollectionDtoMapper extends ClassMapperBase<CreateCollectionDto> {
  CreateCollectionDtoMapper._();

  static CreateCollectionDtoMapper? _instance;
  static CreateCollectionDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CreateCollectionDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CreateCollectionDto';

  static String _$title(CreateCollectionDto v) => v.title;
  static const Field<CreateCollectionDto, String> _f$title =
      Field('title', _$title);
  static bool _$private(CreateCollectionDto v) => v.private;
  static const Field<CreateCollectionDto, bool> _f$private =
      Field('private', _$private);

  @override
  final MappableFields<CreateCollectionDto> fields = const {
    #title: _f$title,
    #private: _f$private,
  };

  static CreateCollectionDto _instantiate(DecodingData data) {
    return CreateCollectionDto(
        title: data.dec(_f$title), private: data.dec(_f$private));
  }

  @override
  final Function instantiate = _instantiate;

  static CreateCollectionDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CreateCollectionDto>(map);
  }

  static CreateCollectionDto fromJson(String json) {
    return ensureInitialized().decodeJson<CreateCollectionDto>(json);
  }
}

mixin CreateCollectionDtoMappable {
  String toJson() {
    return CreateCollectionDtoMapper.ensureInitialized()
        .encodeJson<CreateCollectionDto>(this as CreateCollectionDto);
  }

  Map<String, dynamic> toMap() {
    return CreateCollectionDtoMapper.ensureInitialized()
        .encodeMap<CreateCollectionDto>(this as CreateCollectionDto);
  }

  CreateCollectionDtoCopyWith<CreateCollectionDto, CreateCollectionDto,
          CreateCollectionDto>
      get copyWith => _CreateCollectionDtoCopyWithImpl(
          this as CreateCollectionDto, $identity, $identity);
  @override
  String toString() {
    return CreateCollectionDtoMapper.ensureInitialized()
        .stringifyValue(this as CreateCollectionDto);
  }

  @override
  bool operator ==(Object other) {
    return CreateCollectionDtoMapper.ensureInitialized()
        .equalsValue(this as CreateCollectionDto, other);
  }

  @override
  int get hashCode {
    return CreateCollectionDtoMapper.ensureInitialized()
        .hashValue(this as CreateCollectionDto);
  }
}

extension CreateCollectionDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CreateCollectionDto, $Out> {
  CreateCollectionDtoCopyWith<$R, CreateCollectionDto, $Out>
      get $asCreateCollectionDto =>
          $base.as((v, t, t2) => _CreateCollectionDtoCopyWithImpl(v, t, t2));
}

abstract class CreateCollectionDtoCopyWith<$R, $In extends CreateCollectionDto,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, bool? private});
  CreateCollectionDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CreateCollectionDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CreateCollectionDto, $Out>
    implements CreateCollectionDtoCopyWith<$R, CreateCollectionDto, $Out> {
  _CreateCollectionDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CreateCollectionDto> $mapper =
      CreateCollectionDtoMapper.ensureInitialized();
  @override
  $R call({String? title, bool? private}) => $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (private != null) #private: private
      }));
  @override
  CreateCollectionDto $make(CopyWithData data) => CreateCollectionDto(
      title: data.get(#title, or: $value.title),
      private: data.get(#private, or: $value.private));

  @override
  CreateCollectionDtoCopyWith<$R2, CreateCollectionDto, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CreateCollectionDtoCopyWithImpl($value, $cast, t);
}
