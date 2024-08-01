// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiStateinitial<T> value) initial,
    required TResult Function(_ApiStateloading<T> value) loading,
    required TResult Function(_ApiStateloaded<T> value) loaded,
    required TResult Function(_ApiStateerror<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ApiStateinitial<T> value)? initial,
    TResult? Function(_ApiStateloading<T> value)? loading,
    TResult? Function(_ApiStateloaded<T> value)? loaded,
    TResult? Function(_ApiStateerror<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiStateCopyWith<T, $Res> {
  factory $ApiStateCopyWith(
          ApiState<T> value, $Res Function(ApiState<T>) then) =
      _$ApiStateCopyWithImpl<T, $Res, ApiState<T>>;
}

/// @nodoc
class _$ApiStateCopyWithImpl<T, $Res, $Val extends ApiState<T>>
    implements $ApiStateCopyWith<T, $Res> {
  _$ApiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ApiStateinitialImplCopyWith<T, $Res> {
  factory _$$ApiStateinitialImplCopyWith(_$ApiStateinitialImpl<T> value,
          $Res Function(_$ApiStateinitialImpl<T>) then) =
      __$$ApiStateinitialImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ApiStateinitialImplCopyWithImpl<T, $Res>
    extends _$ApiStateCopyWithImpl<T, $Res, _$ApiStateinitialImpl<T>>
    implements _$$ApiStateinitialImplCopyWith<T, $Res> {
  __$$ApiStateinitialImplCopyWithImpl(_$ApiStateinitialImpl<T> _value,
      $Res Function(_$ApiStateinitialImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiStateinitialImpl<T> implements _ApiStateinitial<T> {
  const _$ApiStateinitialImpl();

  @override
  String toString() {
    return 'ApiState<$T>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiStateinitialImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiStateinitial<T> value) initial,
    required TResult Function(_ApiStateloading<T> value) loading,
    required TResult Function(_ApiStateloaded<T> value) loaded,
    required TResult Function(_ApiStateerror<T> value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ApiStateinitial<T> value)? initial,
    TResult? Function(_ApiStateloading<T> value)? loading,
    TResult? Function(_ApiStateloaded<T> value)? loaded,
    TResult? Function(_ApiStateerror<T> value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ApiStateinitial<T> implements ApiState<T> {
  const factory _ApiStateinitial() = _$ApiStateinitialImpl<T>;
}

/// @nodoc
abstract class _$$ApiStateloadingImplCopyWith<T, $Res> {
  factory _$$ApiStateloadingImplCopyWith(_$ApiStateloadingImpl<T> value,
          $Res Function(_$ApiStateloadingImpl<T>) then) =
      __$$ApiStateloadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ApiStateloadingImplCopyWithImpl<T, $Res>
    extends _$ApiStateCopyWithImpl<T, $Res, _$ApiStateloadingImpl<T>>
    implements _$$ApiStateloadingImplCopyWith<T, $Res> {
  __$$ApiStateloadingImplCopyWithImpl(_$ApiStateloadingImpl<T> _value,
      $Res Function(_$ApiStateloadingImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiStateloadingImpl<T> implements _ApiStateloading<T> {
  const _$ApiStateloadingImpl();

  @override
  String toString() {
    return 'ApiState<$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiStateloadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiStateinitial<T> value) initial,
    required TResult Function(_ApiStateloading<T> value) loading,
    required TResult Function(_ApiStateloaded<T> value) loaded,
    required TResult Function(_ApiStateerror<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ApiStateinitial<T> value)? initial,
    TResult? Function(_ApiStateloading<T> value)? loading,
    TResult? Function(_ApiStateloaded<T> value)? loaded,
    TResult? Function(_ApiStateerror<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ApiStateloading<T> implements ApiState<T> {
  const factory _ApiStateloading() = _$ApiStateloadingImpl<T>;
}

/// @nodoc
abstract class _$$ApiStateloadedImplCopyWith<T, $Res> {
  factory _$$ApiStateloadedImplCopyWith(_$ApiStateloadedImpl<T> value,
          $Res Function(_$ApiStateloadedImpl<T>) then) =
      __$$ApiStateloadedImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$ApiStateloadedImplCopyWithImpl<T, $Res>
    extends _$ApiStateCopyWithImpl<T, $Res, _$ApiStateloadedImpl<T>>
    implements _$$ApiStateloadedImplCopyWith<T, $Res> {
  __$$ApiStateloadedImplCopyWithImpl(_$ApiStateloadedImpl<T> _value,
      $Res Function(_$ApiStateloadedImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$ApiStateloadedImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$ApiStateloadedImpl<T> implements _ApiStateloaded<T> {
  const _$ApiStateloadedImpl({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'ApiState<$T>.loaded(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiStateloadedImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiStateloadedImplCopyWith<T, _$ApiStateloadedImpl<T>> get copyWith =>
      __$$ApiStateloadedImplCopyWithImpl<T, _$ApiStateloadedImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiStateinitial<T> value) initial,
    required TResult Function(_ApiStateloading<T> value) loading,
    required TResult Function(_ApiStateloaded<T> value) loaded,
    required TResult Function(_ApiStateerror<T> value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ApiStateinitial<T> value)? initial,
    TResult? Function(_ApiStateloading<T> value)? loading,
    TResult? Function(_ApiStateloaded<T> value)? loaded,
    TResult? Function(_ApiStateerror<T> value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _ApiStateloaded<T> implements ApiState<T> {
  const factory _ApiStateloaded({required final T data}) =
      _$ApiStateloadedImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$ApiStateloadedImplCopyWith<T, _$ApiStateloadedImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiStateerrorImplCopyWith<T, $Res> {
  factory _$$ApiStateerrorImplCopyWith(_$ApiStateerrorImpl<T> value,
          $Res Function(_$ApiStateerrorImpl<T>) then) =
      __$$ApiStateerrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ApiStateerrorImplCopyWithImpl<T, $Res>
    extends _$ApiStateCopyWithImpl<T, $Res, _$ApiStateerrorImpl<T>>
    implements _$$ApiStateerrorImplCopyWith<T, $Res> {
  __$$ApiStateerrorImplCopyWithImpl(_$ApiStateerrorImpl<T> _value,
      $Res Function(_$ApiStateerrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ApiStateerrorImpl<T>(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ApiStateerrorImpl<T> implements _ApiStateerror<T> {
  const _$ApiStateerrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'ApiState<$T>.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiStateerrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiStateerrorImplCopyWith<T, _$ApiStateerrorImpl<T>> get copyWith =>
      __$$ApiStateerrorImplCopyWithImpl<T, _$ApiStateerrorImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiStateinitial<T> value) initial,
    required TResult Function(_ApiStateloading<T> value) loading,
    required TResult Function(_ApiStateloaded<T> value) loaded,
    required TResult Function(_ApiStateerror<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ApiStateinitial<T> value)? initial,
    TResult? Function(_ApiStateloading<T> value)? loading,
    TResult? Function(_ApiStateloaded<T> value)? loaded,
    TResult? Function(_ApiStateerror<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiStateinitial<T> value)? initial,
    TResult Function(_ApiStateloading<T> value)? loading,
    TResult Function(_ApiStateloaded<T> value)? loaded,
    TResult Function(_ApiStateerror<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ApiStateerror<T> implements ApiState<T> {
  const factory _ApiStateerror({required final String error}) =
      _$ApiStateerrorImpl<T>;

  String get error;
  @JsonKey(ignore: true)
  _$$ApiStateerrorImplCopyWith<T, _$ApiStateerrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
