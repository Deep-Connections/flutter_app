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
  String? get id => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  List<String>? get genderPreferences => throw _privateConstructorUsedError;
  DateTime? get birthdate => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  List<String>? get languageCodes => throw _privateConstructorUsedError;
  Picture? get profilePicture => throw _privateConstructorUsedError;
  List<Picture>? get pictures => throw _privateConstructorUsedError;
  Map<String, Answer>? get questions => throw _privateConstructorUsedError;

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
      {String? id,
      String? firstName,
      String? gender,
      List<String>? genderPreferences,
      DateTime? birthdate,
      int? height,
      List<String>? languageCodes,
      Picture? profilePicture,
      List<Picture>? pictures,
      Map<String, Answer>? questions});

  $PictureCopyWith<$Res>? get profilePicture;
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
    Object? id = freezed,
    Object? firstName = freezed,
    Object? gender = freezed,
    Object? genderPreferences = freezed,
    Object? birthdate = freezed,
    Object? height = freezed,
    Object? languageCodes = freezed,
    Object? profilePicture = freezed,
    Object? pictures = freezed,
    Object? questions = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      languageCodes: freezed == languageCodes
          ? _value.languageCodes
          : languageCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as Picture?,
      pictures: freezed == pictures
          ? _value.pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as List<Picture>?,
      questions: freezed == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as Map<String, Answer>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PictureCopyWith<$Res>? get profilePicture {
    if (_value.profilePicture == null) {
      return null;
    }

    return $PictureCopyWith<$Res>(_value.profilePicture!, (value) {
      return _then(_value.copyWith(profilePicture: value) as $Val);
    });
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
      {String? id,
      String? firstName,
      String? gender,
      List<String>? genderPreferences,
      DateTime? birthdate,
      int? height,
      List<String>? languageCodes,
      Picture? profilePicture,
      List<Picture>? pictures,
      Map<String, Answer>? questions});

  @override
  $PictureCopyWith<$Res>? get profilePicture;
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
    Object? id = freezed,
    Object? firstName = freezed,
    Object? gender = freezed,
    Object? genderPreferences = freezed,
    Object? birthdate = freezed,
    Object? height = freezed,
    Object? languageCodes = freezed,
    Object? profilePicture = freezed,
    Object? pictures = freezed,
    Object? questions = freezed,
  }) {
    return _then(_$ProfileImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      languageCodes: freezed == languageCodes
          ? _value._languageCodes
          : languageCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as Picture?,
      pictures: freezed == pictures
          ? _value._pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as List<Picture>?,
      questions: freezed == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as Map<String, Answer>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl extends _Profile with DiagnosticableTreeMixin {
  const _$ProfileImpl(
      {this.id,
      this.firstName,
      this.gender,
      final List<String>? genderPreferences,
      this.birthdate,
      this.height,
      final List<String>? languageCodes,
      this.profilePicture,
      final List<Picture>? pictures,
      final Map<String, Answer>? questions})
      : _genderPreferences = genderPreferences,
        _languageCodes = languageCodes,
        _pictures = pictures,
        _questions = questions,
        super._();

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final String? id;
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
  final DateTime? birthdate;
  @override
  final int? height;
  final List<String>? _languageCodes;
  @override
  List<String>? get languageCodes {
    final value = _languageCodes;
    if (value == null) return null;
    if (_languageCodes is EqualUnmodifiableListView) return _languageCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Picture? profilePicture;
  final List<Picture>? _pictures;
  @override
  List<Picture>? get pictures {
    final value = _pictures;
    if (value == null) return null;
    if (_pictures is EqualUnmodifiableListView) return _pictures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, Answer>? _questions;
  @override
  Map<String, Answer>? get questions {
    final value = _questions;
    if (value == null) return null;
    if (_questions is EqualUnmodifiableMapView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Profile(id: $id, firstName: $firstName, gender: $gender, genderPreferences: $genderPreferences, birthdate: $birthdate, height: $height, languageCodes: $languageCodes, profilePicture: $profilePicture, pictures: $pictures, questions: $questions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Profile'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('genderPreferences', genderPreferences))
      ..add(DiagnosticsProperty('birthdate', birthdate))
      ..add(DiagnosticsProperty('height', height))
      ..add(DiagnosticsProperty('languageCodes', languageCodes))
      ..add(DiagnosticsProperty('profilePicture', profilePicture))
      ..add(DiagnosticsProperty('pictures', pictures))
      ..add(DiagnosticsProperty('questions', questions));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality()
                .equals(other._genderPreferences, _genderPreferences) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality()
                .equals(other._languageCodes, _languageCodes) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            const DeepCollectionEquality().equals(other._pictures, _pictures) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstName,
      gender,
      const DeepCollectionEquality().hash(_genderPreferences),
      birthdate,
      height,
      const DeepCollectionEquality().hash(_languageCodes),
      profilePicture,
      const DeepCollectionEquality().hash(_pictures),
      const DeepCollectionEquality().hash(_questions));

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

abstract class _Profile extends Profile {
  const factory _Profile(
      {final String? id,
      final String? firstName,
      final String? gender,
      final List<String>? genderPreferences,
      final DateTime? birthdate,
      final int? height,
      final List<String>? languageCodes,
      final Picture? profilePicture,
      final List<Picture>? pictures,
      final Map<String, Answer>? questions}) = _$ProfileImpl;
  const _Profile._() : super._();

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  String? get id;
  @override
  String? get firstName;
  @override
  String? get gender;
  @override
  List<String>? get genderPreferences;
  @override
  DateTime? get birthdate;
  @override
  int? get height;
  @override
  List<String>? get languageCodes;
  @override
  Picture? get profilePicture;
  @override
  List<Picture>? get pictures;
  @override
  Map<String, Answer>? get questions;
  @override
  @JsonKey(ignore: true)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
