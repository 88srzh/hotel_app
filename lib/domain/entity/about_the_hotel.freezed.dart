// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'about_the_hotel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AboutTheHotel _$AboutTheHotelFromJson(Map<String, dynamic> json) {
  return _AboutTheHotel.fromJson(json);
}

/// @nodoc
mixin _$AboutTheHotel {
  String get description => throw _privateConstructorUsedError;
  String get peculiarities => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AboutTheHotelCopyWith<AboutTheHotel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AboutTheHotelCopyWith<$Res> {
  factory $AboutTheHotelCopyWith(
          AboutTheHotel value, $Res Function(AboutTheHotel) then) =
      _$AboutTheHotelCopyWithImpl<$Res, AboutTheHotel>;
  @useResult
  $Res call({String description, String peculiarities});
}

/// @nodoc
class _$AboutTheHotelCopyWithImpl<$Res, $Val extends AboutTheHotel>
    implements $AboutTheHotelCopyWith<$Res> {
  _$AboutTheHotelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? peculiarities = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      peculiarities: null == peculiarities
          ? _value.peculiarities
          : peculiarities // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AboutTheHotelCopyWith<$Res>
    implements $AboutTheHotelCopyWith<$Res> {
  factory _$$_AboutTheHotelCopyWith(
          _$_AboutTheHotel value, $Res Function(_$_AboutTheHotel) then) =
      __$$_AboutTheHotelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String peculiarities});
}

/// @nodoc
class __$$_AboutTheHotelCopyWithImpl<$Res>
    extends _$AboutTheHotelCopyWithImpl<$Res, _$_AboutTheHotel>
    implements _$$_AboutTheHotelCopyWith<$Res> {
  __$$_AboutTheHotelCopyWithImpl(
      _$_AboutTheHotel _value, $Res Function(_$_AboutTheHotel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? peculiarities = null,
  }) {
    return _then(_$_AboutTheHotel(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      peculiarities: null == peculiarities
          ? _value.peculiarities
          : peculiarities // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AboutTheHotel implements _AboutTheHotel {
  _$_AboutTheHotel({required this.description, required this.peculiarities});

  factory _$_AboutTheHotel.fromJson(Map<String, dynamic> json) =>
      _$$_AboutTheHotelFromJson(json);

  @override
  final String description;
  @override
  final String peculiarities;

  @override
  String toString() {
    return 'AboutTheHotel(description: $description, peculiarities: $peculiarities)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AboutTheHotel &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.peculiarities, peculiarities) ||
                other.peculiarities == peculiarities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description, peculiarities);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AboutTheHotelCopyWith<_$_AboutTheHotel> get copyWith =>
      __$$_AboutTheHotelCopyWithImpl<_$_AboutTheHotel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AboutTheHotelToJson(
      this,
    );
  }
}

abstract class _AboutTheHotel implements AboutTheHotel {
  factory _AboutTheHotel(
      {required final String description,
      required final String peculiarities}) = _$_AboutTheHotel;

  factory _AboutTheHotel.fromJson(Map<String, dynamic> json) =
      _$_AboutTheHotel.fromJson;

  @override
  String get description;
  @override
  String get peculiarities;
  @override
  @JsonKey(ignore: true)
  _$$_AboutTheHotelCopyWith<_$_AboutTheHotel> get copyWith =>
      throw _privateConstructorUsedError;
}
