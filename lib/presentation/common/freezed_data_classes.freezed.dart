// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginObject {
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res>;
  $Res call({String userName, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res> implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  final LoginObject _value;
  // ignore: unused_field
  final $Res Function(LoginObject) _then;

  @override
  $Res call({
    Object? userName = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$_LoginObjectCopyWith(
          _$_LoginObject value, $Res Function(_$_LoginObject) then) =
      __$$_LoginObjectCopyWithImpl<$Res>;
  @override
  $Res call({String userName, String password});
}

/// @nodoc
class __$$_LoginObjectCopyWithImpl<$Res> extends _$LoginObjectCopyWithImpl<$Res>
    implements _$$_LoginObjectCopyWith<$Res> {
  __$$_LoginObjectCopyWithImpl(
      _$_LoginObject _value, $Res Function(_$_LoginObject) _then)
      : super(_value, (v) => _then(v as _$_LoginObject));

  @override
  _$_LoginObject get _value => super._value as _$_LoginObject;

  @override
  $Res call({
    Object? userName = freezed,
    Object? password = freezed,
  }) {
    return _then(_$_LoginObject(
      userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginObject implements _LoginObject {
  _$_LoginObject(this.userName, this.password);

  @override
  final String userName;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(userName: $userName, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginObject &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      __$$_LoginObjectCopyWithImpl<_$_LoginObject>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String userName, final String password) =
      _$_LoginObject;

  @override
  String get userName;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ForgetObject {
  String get email => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ForgetObjectCopyWith<ForgetObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgetObjectCopyWith<$Res> {
  factory $ForgetObjectCopyWith(
          ForgetObject value, $Res Function(ForgetObject) then) =
      _$ForgetObjectCopyWithImpl<$Res>;
  $Res call({String email});
}

/// @nodoc
class _$ForgetObjectCopyWithImpl<$Res> implements $ForgetObjectCopyWith<$Res> {
  _$ForgetObjectCopyWithImpl(this._value, this._then);

  final ForgetObject _value;
  // ignore: unused_field
  final $Res Function(ForgetObject) _then;

  @override
  $Res call({
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ForgetObjectCopyWith<$Res>
    implements $ForgetObjectCopyWith<$Res> {
  factory _$$_ForgetObjectCopyWith(
          _$_ForgetObject value, $Res Function(_$_ForgetObject) then) =
      __$$_ForgetObjectCopyWithImpl<$Res>;
  @override
  $Res call({String email});
}

/// @nodoc
class __$$_ForgetObjectCopyWithImpl<$Res>
    extends _$ForgetObjectCopyWithImpl<$Res>
    implements _$$_ForgetObjectCopyWith<$Res> {
  __$$_ForgetObjectCopyWithImpl(
      _$_ForgetObject _value, $Res Function(_$_ForgetObject) _then)
      : super(_value, (v) => _then(v as _$_ForgetObject));

  @override
  _$_ForgetObject get _value => super._value as _$_ForgetObject;

  @override
  $Res call({
    Object? email = freezed,
  }) {
    return _then(_$_ForgetObject(
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ForgetObject implements _ForgetObject {
  _$_ForgetObject(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'ForgetObject(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForgetObject &&
            const DeepCollectionEquality().equals(other.email, email));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(email));

  @JsonKey(ignore: true)
  @override
  _$$_ForgetObjectCopyWith<_$_ForgetObject> get copyWith =>
      __$$_ForgetObjectCopyWithImpl<_$_ForgetObject>(this, _$identity);
}

abstract class _ForgetObject implements ForgetObject {
  factory _ForgetObject(final String email) = _$_ForgetObject;

  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_ForgetObjectCopyWith<_$_ForgetObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterObject {
  String get userName => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;
  String get mobilNumber => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get profilePic => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res>;
  $Res call(
      {String userName,
      String countryCode,
      String mobilNumber,
      String password,
      String email,
      String profilePic});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  final RegisterObject _value;
  // ignore: unused_field
  final $Res Function(RegisterObject) _then;

  @override
  $Res call({
    Object? userName = freezed,
    Object? countryCode = freezed,
    Object? mobilNumber = freezed,
    Object? password = freezed,
    Object? email = freezed,
    Object? profilePic = freezed,
  }) {
    return _then(_value.copyWith(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      mobilNumber: mobilNumber == freezed
          ? _value.mobilNumber
          : mobilNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePic: profilePic == freezed
          ? _value.profilePic
          : profilePic // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_RegisterObjectCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$$_RegisterObjectCopyWith(
          _$_RegisterObject value, $Res Function(_$_RegisterObject) then) =
      __$$_RegisterObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String userName,
      String countryCode,
      String mobilNumber,
      String password,
      String email,
      String profilePic});
}

/// @nodoc
class __$$_RegisterObjectCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res>
    implements _$$_RegisterObjectCopyWith<$Res> {
  __$$_RegisterObjectCopyWithImpl(
      _$_RegisterObject _value, $Res Function(_$_RegisterObject) _then)
      : super(_value, (v) => _then(v as _$_RegisterObject));

  @override
  _$_RegisterObject get _value => super._value as _$_RegisterObject;

  @override
  $Res call({
    Object? userName = freezed,
    Object? countryCode = freezed,
    Object? mobilNumber = freezed,
    Object? password = freezed,
    Object? email = freezed,
    Object? profilePic = freezed,
  }) {
    return _then(_$_RegisterObject(
      userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      mobilNumber == freezed
          ? _value.mobilNumber
          : mobilNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePic == freezed
          ? _value.profilePic
          : profilePic // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RegisterObject implements _RegisterObject {
  _$_RegisterObject(this.userName, this.countryCode, this.mobilNumber,
      this.password, this.email, this.profilePic);

  @override
  final String userName;
  @override
  final String countryCode;
  @override
  final String mobilNumber;
  @override
  final String password;
  @override
  final String email;
  @override
  final String profilePic;

  @override
  String toString() {
    return 'RegisterObject(userName: $userName, countryCode: $countryCode, mobilNumber: $mobilNumber, password: $password, email: $email, profilePic: $profilePic)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterObject &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality()
                .equals(other.countryCode, countryCode) &&
            const DeepCollectionEquality()
                .equals(other.mobilNumber, mobilNumber) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other.profilePic, profilePic));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(countryCode),
      const DeepCollectionEquality().hash(mobilNumber),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(profilePic));

  @JsonKey(ignore: true)
  @override
  _$$_RegisterObjectCopyWith<_$_RegisterObject> get copyWith =>
      __$$_RegisterObjectCopyWithImpl<_$_RegisterObject>(this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  factory _RegisterObject(
      final String userName,
      final String countryCode,
      final String mobilNumber,
      final String password,
      final String email,
      final String profilePic) = _$_RegisterObject;

  @override
  String get userName;
  @override
  String get countryCode;
  @override
  String get mobilNumber;
  @override
  String get password;
  @override
  String get email;
  @override
  String get profilePic;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterObjectCopyWith<_$_RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}
