// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_registration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudentRegistrationModel {

 String get name; String get profileUrl; String get email; String get number; String get gender; DateTime get dob;
/// Create a copy of StudentRegistrationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentRegistrationModelCopyWith<StudentRegistrationModel> get copyWith => _$StudentRegistrationModelCopyWithImpl<StudentRegistrationModel>(this as StudentRegistrationModel, _$identity);

  /// Serializes this StudentRegistrationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentRegistrationModel&&(identical(other.name, name) || other.name == name)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl)&&(identical(other.email, email) || other.email == email)&&(identical(other.number, number) || other.number == number)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,profileUrl,email,number,gender,dob);

@override
String toString() {
  return 'StudentRegistrationModel(name: $name, profileUrl: $profileUrl, email: $email, number: $number, gender: $gender, dob: $dob)';
}


}

/// @nodoc
abstract mixin class $StudentRegistrationModelCopyWith<$Res>  {
  factory $StudentRegistrationModelCopyWith(StudentRegistrationModel value, $Res Function(StudentRegistrationModel) _then) = _$StudentRegistrationModelCopyWithImpl;
@useResult
$Res call({
 String name, String profileUrl, String email, String number, String gender, DateTime dob
});




}
/// @nodoc
class _$StudentRegistrationModelCopyWithImpl<$Res>
    implements $StudentRegistrationModelCopyWith<$Res> {
  _$StudentRegistrationModelCopyWithImpl(this._self, this._then);

  final StudentRegistrationModel _self;
  final $Res Function(StudentRegistrationModel) _then;

/// Create a copy of StudentRegistrationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? profileUrl = null,Object? email = null,Object? number = null,Object? gender = null,Object? dob = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentRegistrationModel].
extension StudentRegistrationModelPatterns on StudentRegistrationModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentRegistrationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentRegistrationModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentRegistrationModel value)  $default,){
final _that = this;
switch (_that) {
case _StudentRegistrationModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentRegistrationModel value)?  $default,){
final _that = this;
switch (_that) {
case _StudentRegistrationModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String profileUrl,  String email,  String number,  String gender,  DateTime dob)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentRegistrationModel() when $default != null:
return $default(_that.name,_that.profileUrl,_that.email,_that.number,_that.gender,_that.dob);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String profileUrl,  String email,  String number,  String gender,  DateTime dob)  $default,) {final _that = this;
switch (_that) {
case _StudentRegistrationModel():
return $default(_that.name,_that.profileUrl,_that.email,_that.number,_that.gender,_that.dob);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String profileUrl,  String email,  String number,  String gender,  DateTime dob)?  $default,) {final _that = this;
switch (_that) {
case _StudentRegistrationModel() when $default != null:
return $default(_that.name,_that.profileUrl,_that.email,_that.number,_that.gender,_that.dob);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudentRegistrationModel implements StudentRegistrationModel {
  const _StudentRegistrationModel({required this.name, required this.profileUrl, required this.email, required this.number, required this.gender, required this.dob});
  factory _StudentRegistrationModel.fromJson(Map<String, dynamic> json) => _$StudentRegistrationModelFromJson(json);

@override final  String name;
@override final  String profileUrl;
@override final  String email;
@override final  String number;
@override final  String gender;
@override final  DateTime dob;

/// Create a copy of StudentRegistrationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentRegistrationModelCopyWith<_StudentRegistrationModel> get copyWith => __$StudentRegistrationModelCopyWithImpl<_StudentRegistrationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudentRegistrationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentRegistrationModel&&(identical(other.name, name) || other.name == name)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl)&&(identical(other.email, email) || other.email == email)&&(identical(other.number, number) || other.number == number)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,profileUrl,email,number,gender,dob);

@override
String toString() {
  return 'StudentRegistrationModel(name: $name, profileUrl: $profileUrl, email: $email, number: $number, gender: $gender, dob: $dob)';
}


}

/// @nodoc
abstract mixin class _$StudentRegistrationModelCopyWith<$Res> implements $StudentRegistrationModelCopyWith<$Res> {
  factory _$StudentRegistrationModelCopyWith(_StudentRegistrationModel value, $Res Function(_StudentRegistrationModel) _then) = __$StudentRegistrationModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String profileUrl, String email, String number, String gender, DateTime dob
});




}
/// @nodoc
class __$StudentRegistrationModelCopyWithImpl<$Res>
    implements _$StudentRegistrationModelCopyWith<$Res> {
  __$StudentRegistrationModelCopyWithImpl(this._self, this._then);

  final _StudentRegistrationModel _self;
  final $Res Function(_StudentRegistrationModel) _then;

/// Create a copy of StudentRegistrationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? profileUrl = null,Object? email = null,Object? number = null,Object? gender = null,Object? dob = null,}) {
  return _then(_StudentRegistrationModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
