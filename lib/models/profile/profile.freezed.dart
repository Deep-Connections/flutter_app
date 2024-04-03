// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  String? get uid => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  List<String>? get genderPreferences => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;

  List<QuestionResponse>? get questionResponses =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call(
      {String? uid,
      String? firstName,
      String? gender,
      List<String>? genderPreferences,
      DateTime? dateOfBirth,
      int? height,
      List<QuestionResponse>? questionResponses});
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? firstName = freezed,
    Object? gender = freezed,
    Object? genderPreferences = freezed,
    Object? dateOfBirth = freezed,
    Object? height = freezed,
    Object? questionResponses = freezed,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      genderPreferences: freezed == genderPreferences
          ? _value.genderPreferences
          : genderPreferences // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      questionResponses: freezed == questionResponses
          ? _value.questionResponses
          : questionResponses // ignore: cast_nullable_to_non_nullable
              as List<QuestionResponse>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
          _$ProfileImpl value, $Res Function(_$ProfileImpl) then) =
      __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      String? firstName,
      String? gender,
      List<String>? genderPreferences,
      DateTime? dateOfBirth,
      int? height,
      List<QuestionResponse>? questionResponses});
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
      _$ProfileImpl _value, $Res Function(_$ProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? firstName = freezed,
    Object? gender = freezed,
    Object? genderPreferences = freezed,
    Object? dateOfBirth = freezed,
    Object? height = freezed,
    Object? questionResponses = freezed,
  }) {
    return _then(_$ProfileImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      genderPreferences: freezed == genderPreferences
          ? _value._genderPreferences
          : genderPreferences // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      questionResponses: freezed == questionResponses
          ? _value._questionResponses
          : questionResponses // ignore: cast_nullable_to_non_nullable
              as List<QuestionResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl with DiagnosticableTreeMixin implements _Profile {
  const _$ProfileImpl(
      {this.uid,
      this.firstName,
      this.gender,
      final List<String>? genderPreferences,
      this.dateOfBirth,
      this.height,
      final List<QuestionResponse>? questionResponses})
      : _genderPreferences = genderPreferences,
        _questionResponses = questionResponses;

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final String? uid;
  @override
  final String? firstName;
  @override
  final String? gender;
  final List<String>? _genderPreferences;
  @override
  List<String>? get genderPreferences {
    final value = _genderPreferences;
    if (value == null) return null;
    if (_genderPreferences is EqualUnmodifiableListView)
      return _genderPreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? dateOfBirth;
  @override
  final int? height;
  final List<QuestionResponse>? _questionResponses;

  @override
  List<QuestionResponse>? get questionResponses {
    final value = _questionResponses;
    if (value == null) return null;
    if (_questionResponses is EqualUnmodifiableListView)
      return _questionResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Profile(uid: $uid, firstName: $firstName, gender: $gender, genderPreferences: $genderPreferences, dateOfBirth: $dateOfBirth, height: $height, questionResponses: $questionResponses)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Profile'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('firstName', firstName))..add(
        DiagnosticsProperty('gender', gender))..add(
        DiagnosticsProperty('genderPreferences', genderPreferences))
      ..add(DiagnosticsProperty('dateOfBirth', dateOfBirth))..add(
        DiagnosticsProperty('height', height))..add(
        DiagnosticsProperty('questionResponses', questionResponses));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality()
                .equals(other._genderPreferences, _genderPreferences) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality()
                .equals(other._questionResponses, _questionResponses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      firstName,
      gender,
      const DeepCollectionEquality().hash(_genderPreferences),
      dateOfBirth,
      height,
      const DeepCollectionEquality().hash(_questionResponses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(
      this,
    );
  }
}

abstract class _Profile implements Profile {
  const factory _Profile(
      {final String? uid,
      final String? firstName,
      final String? gender,
      final List<String>? genderPreferences,
      final DateTime? dateOfBirth,
      final int? height,
      final List<QuestionResponse>? questionResponses}) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  String? get uid;
  @override
  String? get firstName;
  @override
  String? get gender;
  @override
  List<String>? get genderPreferences;
  @override
  DateTime? get dateOfBirth;
  @override
  int? get height;

  @override
  List<QuestionResponse>? get questionResponses;
  @override
  @JsonKey(ignore: true)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
