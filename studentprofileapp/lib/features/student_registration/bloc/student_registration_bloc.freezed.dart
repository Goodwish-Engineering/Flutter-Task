// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_registration_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentRegistrationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentRegistrationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StudentRegistrationEvent()';
}


}

/// @nodoc
class $StudentRegistrationEventCopyWith<$Res>  {
$StudentRegistrationEventCopyWith(StudentRegistrationEvent _, $Res Function(StudentRegistrationEvent) __);
}


/// Adds pattern-matching-related methods to [StudentRegistrationEvent].
extension StudentRegistrationEventPatterns on StudentRegistrationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Name value)?  name,TResult Function( Email value)?  email,TResult Function( Phone value)?  phone,TResult Function( Dob value)?  dob,TResult Function( Gender value)?  gender,TResult Function( Profile value)?  profile,TResult Function( EditProfile value)?  editProfile,TResult Function( Submit value)?  submit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Name() when name != null:
return name(_that);case Email() when email != null:
return email(_that);case Phone() when phone != null:
return phone(_that);case Dob() when dob != null:
return dob(_that);case Gender() when gender != null:
return gender(_that);case Profile() when profile != null:
return profile(_that);case EditProfile() when editProfile != null:
return editProfile(_that);case Submit() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Name value)  name,required TResult Function( Email value)  email,required TResult Function( Phone value)  phone,required TResult Function( Dob value)  dob,required TResult Function( Gender value)  gender,required TResult Function( Profile value)  profile,required TResult Function( EditProfile value)  editProfile,required TResult Function( Submit value)  submit,}){
final _that = this;
switch (_that) {
case Name():
return name(_that);case Email():
return email(_that);case Phone():
return phone(_that);case Dob():
return dob(_that);case Gender():
return gender(_that);case Profile():
return profile(_that);case EditProfile():
return editProfile(_that);case Submit():
return submit(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Name value)?  name,TResult? Function( Email value)?  email,TResult? Function( Phone value)?  phone,TResult? Function( Dob value)?  dob,TResult? Function( Gender value)?  gender,TResult? Function( Profile value)?  profile,TResult? Function( EditProfile value)?  editProfile,TResult? Function( Submit value)?  submit,}){
final _that = this;
switch (_that) {
case Name() when name != null:
return name(_that);case Email() when email != null:
return email(_that);case Phone() when phone != null:
return phone(_that);case Dob() when dob != null:
return dob(_that);case Gender() when gender != null:
return gender(_that);case Profile() when profile != null:
return profile(_that);case EditProfile() when editProfile != null:
return editProfile(_that);case Submit() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name)?  name,TResult Function( String email)?  email,TResult Function( String phone)?  phone,TResult Function( DateTime dob)?  dob,TResult Function( String gender)?  gender,TResult Function( ImageSource source)?  profile,TResult Function( StudentRegistrationModel student)?  editProfile,TResult Function( String message)?  submit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Name() when name != null:
return name(_that.name);case Email() when email != null:
return email(_that.email);case Phone() when phone != null:
return phone(_that.phone);case Dob() when dob != null:
return dob(_that.dob);case Gender() when gender != null:
return gender(_that.gender);case Profile() when profile != null:
return profile(_that.source);case EditProfile() when editProfile != null:
return editProfile(_that.student);case Submit() when submit != null:
return submit(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name)  name,required TResult Function( String email)  email,required TResult Function( String phone)  phone,required TResult Function( DateTime dob)  dob,required TResult Function( String gender)  gender,required TResult Function( ImageSource source)  profile,required TResult Function( StudentRegistrationModel student)  editProfile,required TResult Function( String message)  submit,}) {final _that = this;
switch (_that) {
case Name():
return name(_that.name);case Email():
return email(_that.email);case Phone():
return phone(_that.phone);case Dob():
return dob(_that.dob);case Gender():
return gender(_that.gender);case Profile():
return profile(_that.source);case EditProfile():
return editProfile(_that.student);case Submit():
return submit(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name)?  name,TResult? Function( String email)?  email,TResult? Function( String phone)?  phone,TResult? Function( DateTime dob)?  dob,TResult? Function( String gender)?  gender,TResult? Function( ImageSource source)?  profile,TResult? Function( StudentRegistrationModel student)?  editProfile,TResult? Function( String message)?  submit,}) {final _that = this;
switch (_that) {
case Name() when name != null:
return name(_that.name);case Email() when email != null:
return email(_that.email);case Phone() when phone != null:
return phone(_that.phone);case Dob() when dob != null:
return dob(_that.dob);case Gender() when gender != null:
return gender(_that.gender);case Profile() when profile != null:
return profile(_that.source);case EditProfile() when editProfile != null:
return editProfile(_that.student);case Submit() when submit != null:
return submit(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class Name implements StudentRegistrationEvent {
  const Name({required this.name});
  

 final  String name;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NameCopyWith<Name> get copyWith => _$NameCopyWithImpl<Name>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Name&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'StudentRegistrationEvent.name(name: $name)';
}


}

/// @nodoc
abstract mixin class $NameCopyWith<$Res> implements $StudentRegistrationEventCopyWith<$Res> {
  factory $NameCopyWith(Name value, $Res Function(Name) _then) = _$NameCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$NameCopyWithImpl<$Res>
    implements $NameCopyWith<$Res> {
  _$NameCopyWithImpl(this._self, this._then);

  final Name _self;
  final $Res Function(Name) _then;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(Name(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Email implements StudentRegistrationEvent {
  const Email({required this.email});
  

 final  String email;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailCopyWith<Email> get copyWith => _$EmailCopyWithImpl<Email>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Email&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'StudentRegistrationEvent.email(email: $email)';
}


}

/// @nodoc
abstract mixin class $EmailCopyWith<$Res> implements $StudentRegistrationEventCopyWith<$Res> {
  factory $EmailCopyWith(Email value, $Res Function(Email) _then) = _$EmailCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$EmailCopyWithImpl<$Res>
    implements $EmailCopyWith<$Res> {
  _$EmailCopyWithImpl(this._self, this._then);

  final Email _self;
  final $Res Function(Email) _then;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(Email(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Phone implements StudentRegistrationEvent {
  const Phone({required this.phone});
  

 final  String phone;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneCopyWith<Phone> get copyWith => _$PhoneCopyWithImpl<Phone>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Phone&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'StudentRegistrationEvent.phone(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $PhoneCopyWith<$Res> implements $StudentRegistrationEventCopyWith<$Res> {
  factory $PhoneCopyWith(Phone value, $Res Function(Phone) _then) = _$PhoneCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$PhoneCopyWithImpl<$Res>
    implements $PhoneCopyWith<$Res> {
  _$PhoneCopyWithImpl(this._self, this._then);

  final Phone _self;
  final $Res Function(Phone) _then;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(Phone(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Dob implements StudentRegistrationEvent {
  const Dob({required this.dob});
  

 final  DateTime dob;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DobCopyWith<Dob> get copyWith => _$DobCopyWithImpl<Dob>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Dob&&(identical(other.dob, dob) || other.dob == dob));
}


@override
int get hashCode => Object.hash(runtimeType,dob);

@override
String toString() {
  return 'StudentRegistrationEvent.dob(dob: $dob)';
}


}

/// @nodoc
abstract mixin class $DobCopyWith<$Res> implements $StudentRegistrationEventCopyWith<$Res> {
  factory $DobCopyWith(Dob value, $Res Function(Dob) _then) = _$DobCopyWithImpl;
@useResult
$Res call({
 DateTime dob
});




}
/// @nodoc
class _$DobCopyWithImpl<$Res>
    implements $DobCopyWith<$Res> {
  _$DobCopyWithImpl(this._self, this._then);

  final Dob _self;
  final $Res Function(Dob) _then;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dob = null,}) {
  return _then(Dob(
dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class Gender implements StudentRegistrationEvent {
  const Gender({required this.gender});
  

 final  String gender;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenderCopyWith<Gender> get copyWith => _$GenderCopyWithImpl<Gender>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Gender&&(identical(other.gender, gender) || other.gender == gender));
}


@override
int get hashCode => Object.hash(runtimeType,gender);

@override
String toString() {
  return 'StudentRegistrationEvent.gender(gender: $gender)';
}


}

/// @nodoc
abstract mixin class $GenderCopyWith<$Res> implements $StudentRegistrationEventCopyWith<$Res> {
  factory $GenderCopyWith(Gender value, $Res Function(Gender) _then) = _$GenderCopyWithImpl;
@useResult
$Res call({
 String gender
});




}
/// @nodoc
class _$GenderCopyWithImpl<$Res>
    implements $GenderCopyWith<$Res> {
  _$GenderCopyWithImpl(this._self, this._then);

  final Gender _self;
  final $Res Function(Gender) _then;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? gender = null,}) {
  return _then(Gender(
gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Profile implements StudentRegistrationEvent {
  const Profile({required this.source});
  

 final  ImageSource source;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,source);

@override
String toString() {
  return 'StudentRegistrationEvent.profile(source: $source)';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res> implements $StudentRegistrationEventCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 ImageSource source
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? source = null,}) {
  return _then(Profile(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ImageSource,
  ));
}


}

/// @nodoc


class EditProfile implements StudentRegistrationEvent {
  const EditProfile({required this.student});
  

 final  StudentRegistrationModel student;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileCopyWith<EditProfile> get copyWith => _$EditProfileCopyWithImpl<EditProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfile&&(identical(other.student, student) || other.student == student));
}


@override
int get hashCode => Object.hash(runtimeType,student);

@override
String toString() {
  return 'StudentRegistrationEvent.editProfile(student: $student)';
}


}

/// @nodoc
abstract mixin class $EditProfileCopyWith<$Res> implements $StudentRegistrationEventCopyWith<$Res> {
  factory $EditProfileCopyWith(EditProfile value, $Res Function(EditProfile) _then) = _$EditProfileCopyWithImpl;
@useResult
$Res call({
 StudentRegistrationModel student
});


$StudentRegistrationModelCopyWith<$Res> get student;

}
/// @nodoc
class _$EditProfileCopyWithImpl<$Res>
    implements $EditProfileCopyWith<$Res> {
  _$EditProfileCopyWithImpl(this._self, this._then);

  final EditProfile _self;
  final $Res Function(EditProfile) _then;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? student = null,}) {
  return _then(EditProfile(
student: null == student ? _self.student : student // ignore: cast_nullable_to_non_nullable
as StudentRegistrationModel,
  ));
}

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudentRegistrationModelCopyWith<$Res> get student {
  
  return $StudentRegistrationModelCopyWith<$Res>(_self.student, (value) {
    return _then(_self.copyWith(student: value));
  });
}
}

/// @nodoc


class Submit implements StudentRegistrationEvent {
  const Submit({required this.message});
  

 final  String message;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitCopyWith<Submit> get copyWith => _$SubmitCopyWithImpl<Submit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Submit&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'StudentRegistrationEvent.submit(message: $message)';
}


}

/// @nodoc
abstract mixin class $SubmitCopyWith<$Res> implements $StudentRegistrationEventCopyWith<$Res> {
  factory $SubmitCopyWith(Submit value, $Res Function(Submit) _then) = _$SubmitCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SubmitCopyWithImpl<$Res>
    implements $SubmitCopyWith<$Res> {
  _$SubmitCopyWithImpl(this._self, this._then);

  final Submit _self;
  final $Res Function(Submit) _then;

/// Create a copy of StudentRegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Submit(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$StudentRegistrationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentRegistrationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StudentRegistrationState()';
}


}

/// @nodoc
class $StudentRegistrationStateCopyWith<$Res>  {
$StudentRegistrationStateCopyWith(StudentRegistrationState _, $Res Function(StudentRegistrationState) __);
}


/// Adds pattern-matching-related methods to [StudentRegistrationState].
extension StudentRegistrationStatePatterns on StudentRegistrationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( ProfileUploaded value)?  profileUploaded,TResult Function( Success value)?  success,TResult Function( Error value)?  error,TResult Function( EditProfileState value)?  editProfileState,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ProfileUploaded() when profileUploaded != null:
return profileUploaded(_that);case Success() when success != null:
return success(_that);case Error() when error != null:
return error(_that);case EditProfileState() when editProfileState != null:
return editProfileState(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( ProfileUploaded value)  profileUploaded,required TResult Function( Success value)  success,required TResult Function( Error value)  error,required TResult Function( EditProfileState value)  editProfileState,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ProfileUploaded():
return profileUploaded(_that);case Success():
return success(_that);case Error():
return error(_that);case EditProfileState():
return editProfileState(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( ProfileUploaded value)?  profileUploaded,TResult? Function( Success value)?  success,TResult? Function( Error value)?  error,TResult? Function( EditProfileState value)?  editProfileState,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ProfileUploaded() when profileUploaded != null:
return profileUploaded(_that);case Success() when success != null:
return success(_that);case Error() when error != null:
return error(_that);case EditProfileState() when editProfileState != null:
return editProfileState(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String url)?  profileUploaded,TResult Function( String message)?  success,TResult Function( String errorMessage)?  error,TResult Function( StudentRegistrationModel student)?  editProfileState,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ProfileUploaded() when profileUploaded != null:
return profileUploaded(_that.url);case Success() when success != null:
return success(_that.message);case Error() when error != null:
return error(_that.errorMessage);case EditProfileState() when editProfileState != null:
return editProfileState(_that.student);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String url)  profileUploaded,required TResult Function( String message)  success,required TResult Function( String errorMessage)  error,required TResult Function( StudentRegistrationModel student)  editProfileState,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ProfileUploaded():
return profileUploaded(_that.url);case Success():
return success(_that.message);case Error():
return error(_that.errorMessage);case EditProfileState():
return editProfileState(_that.student);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String url)?  profileUploaded,TResult? Function( String message)?  success,TResult? Function( String errorMessage)?  error,TResult? Function( StudentRegistrationModel student)?  editProfileState,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ProfileUploaded() when profileUploaded != null:
return profileUploaded(_that.url);case Success() when success != null:
return success(_that.message);case Error() when error != null:
return error(_that.errorMessage);case EditProfileState() when editProfileState != null:
return editProfileState(_that.student);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements StudentRegistrationState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StudentRegistrationState.initial()';
}


}




/// @nodoc


class ProfileUploaded implements StudentRegistrationState {
  const ProfileUploaded({required this.url});
  

 final  String url;

/// Create a copy of StudentRegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUploadedCopyWith<ProfileUploaded> get copyWith => _$ProfileUploadedCopyWithImpl<ProfileUploaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUploaded&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'StudentRegistrationState.profileUploaded(url: $url)';
}


}

/// @nodoc
abstract mixin class $ProfileUploadedCopyWith<$Res> implements $StudentRegistrationStateCopyWith<$Res> {
  factory $ProfileUploadedCopyWith(ProfileUploaded value, $Res Function(ProfileUploaded) _then) = _$ProfileUploadedCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$ProfileUploadedCopyWithImpl<$Res>
    implements $ProfileUploadedCopyWith<$Res> {
  _$ProfileUploadedCopyWithImpl(this._self, this._then);

  final ProfileUploaded _self;
  final $Res Function(ProfileUploaded) _then;

/// Create a copy of StudentRegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(ProfileUploaded(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Success implements StudentRegistrationState {
  const Success({required this.message});
  

 final  String message;

/// Create a copy of StudentRegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'StudentRegistrationState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $StudentRegistrationStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of StudentRegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Success(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Error implements StudentRegistrationState {
  const Error({required this.errorMessage});
  

 final  String errorMessage;

/// Create a copy of StudentRegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'StudentRegistrationState.error(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $StudentRegistrationStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of StudentRegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(Error(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EditProfileState implements StudentRegistrationState {
  const EditProfileState({required this.student});
  

 final  StudentRegistrationModel student;

/// Create a copy of StudentRegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileStateCopyWith<EditProfileState> get copyWith => _$EditProfileStateCopyWithImpl<EditProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState&&(identical(other.student, student) || other.student == student));
}


@override
int get hashCode => Object.hash(runtimeType,student);

@override
String toString() {
  return 'StudentRegistrationState.editProfileState(student: $student)';
}


}

/// @nodoc
abstract mixin class $EditProfileStateCopyWith<$Res> implements $StudentRegistrationStateCopyWith<$Res> {
  factory $EditProfileStateCopyWith(EditProfileState value, $Res Function(EditProfileState) _then) = _$EditProfileStateCopyWithImpl;
@useResult
$Res call({
 StudentRegistrationModel student
});


$StudentRegistrationModelCopyWith<$Res> get student;

}
/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._self, this._then);

  final EditProfileState _self;
  final $Res Function(EditProfileState) _then;

/// Create a copy of StudentRegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? student = null,}) {
  return _then(EditProfileState(
student: null == student ? _self.student : student // ignore: cast_nullable_to_non_nullable
as StudentRegistrationModel,
  ));
}

/// Create a copy of StudentRegistrationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudentRegistrationModelCopyWith<$Res> get student {
  
  return $StudentRegistrationModelCopyWith<$Res>(_self.student, (value) {
    return _then(_self.copyWith(student: value));
  });
}
}

// dart format on
