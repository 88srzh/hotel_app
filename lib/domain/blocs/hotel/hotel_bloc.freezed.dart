// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hotel_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HotelEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadPage,
    required TResult Function() reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadPage,
    TResult? Function()? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadPage,
    TResult Function()? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelEventLoadPage value) loadPage,
    required TResult Function(HotelEventReset value) reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelEventLoadPage value)? loadPage,
    TResult? Function(HotelEventReset value)? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelEventLoadPage value)? loadPage,
    TResult Function(HotelEventReset value)? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotelEventCopyWith<$Res> {
  factory $HotelEventCopyWith(
          HotelEvent value, $Res Function(HotelEvent) then) =
      _$HotelEventCopyWithImpl<$Res, HotelEvent>;
}

/// @nodoc
class _$HotelEventCopyWithImpl<$Res, $Val extends HotelEvent>
    implements $HotelEventCopyWith<$Res> {
  _$HotelEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$HotelEventLoadPageCopyWith<$Res> {
  factory _$$HotelEventLoadPageCopyWith(_$HotelEventLoadPage value,
          $Res Function(_$HotelEventLoadPage) then) =
      __$$HotelEventLoadPageCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HotelEventLoadPageCopyWithImpl<$Res>
    extends _$HotelEventCopyWithImpl<$Res, _$HotelEventLoadPage>
    implements _$$HotelEventLoadPageCopyWith<$Res> {
  __$$HotelEventLoadPageCopyWithImpl(
      _$HotelEventLoadPage _value, $Res Function(_$HotelEventLoadPage) _then)
      : super(_value, _then);
}

/// @nodoc

class _$HotelEventLoadPage implements HotelEventLoadPage {
  const _$HotelEventLoadPage();

  @override
  String toString() {
    return 'HotelEvent.loadPage()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HotelEventLoadPage);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadPage,
    required TResult Function() reset,
  }) {
    return loadPage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadPage,
    TResult? Function()? reset,
  }) {
    return loadPage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadPage,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (loadPage != null) {
      return loadPage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelEventLoadPage value) loadPage,
    required TResult Function(HotelEventReset value) reset,
  }) {
    return loadPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelEventLoadPage value)? loadPage,
    TResult? Function(HotelEventReset value)? reset,
  }) {
    return loadPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelEventLoadPage value)? loadPage,
    TResult Function(HotelEventReset value)? reset,
    required TResult orElse(),
  }) {
    if (loadPage != null) {
      return loadPage(this);
    }
    return orElse();
  }
}

abstract class HotelEventLoadPage implements HotelEvent {
  const factory HotelEventLoadPage() = _$HotelEventLoadPage;
}

/// @nodoc
abstract class _$$HotelEventResetCopyWith<$Res> {
  factory _$$HotelEventResetCopyWith(
          _$HotelEventReset value, $Res Function(_$HotelEventReset) then) =
      __$$HotelEventResetCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HotelEventResetCopyWithImpl<$Res>
    extends _$HotelEventCopyWithImpl<$Res, _$HotelEventReset>
    implements _$$HotelEventResetCopyWith<$Res> {
  __$$HotelEventResetCopyWithImpl(
      _$HotelEventReset _value, $Res Function(_$HotelEventReset) _then)
      : super(_value, _then);
}

/// @nodoc

class _$HotelEventReset implements HotelEventReset {
  const _$HotelEventReset();

  @override
  String toString() {
    return 'HotelEvent.reset()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HotelEventReset);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadPage,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadPage,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadPage,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HotelEventLoadPage value) loadPage,
    required TResult Function(HotelEventReset value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HotelEventLoadPage value)? loadPage,
    TResult? Function(HotelEventReset value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HotelEventLoadPage value)? loadPage,
    TResult Function(HotelEventReset value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class HotelEventReset implements HotelEvent {
  const factory HotelEventReset() = _$HotelEventReset;
}
