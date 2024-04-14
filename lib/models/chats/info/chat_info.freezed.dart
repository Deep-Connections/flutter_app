// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatInfo _$ChatInfoFromJson(Map<String, dynamic> json) {
  return _ChatInfo.fromJson(json);
}

/// @nodoc
mixin _$ChatInfo {
  String? get userId => throw _privateConstructorUsedError;
  bool? get unreadMessages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatInfoCopyWith<ChatInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatInfoCopyWith<$Res> {
  factory $ChatInfoCopyWith(ChatInfo value, $Res Function(ChatInfo) then) =
      _$ChatInfoCopyWithImpl<$Res, ChatInfo>;
  @useResult
  $Res call({String? userId, bool? unreadMessages});
}

/// @nodoc
class _$ChatInfoCopyWithImpl<$Res, $Val extends ChatInfo>
    implements $ChatInfoCopyWith<$Res> {
  _$ChatInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? unreadMessages = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadMessages: freezed == unreadMessages
          ? _value.unreadMessages
          : unreadMessages // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatInfoImplCopyWith<$Res>
    implements $ChatInfoCopyWith<$Res> {
  factory _$$ChatInfoImplCopyWith(
          _$ChatInfoImpl value, $Res Function(_$ChatInfoImpl) then) =
      __$$ChatInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? userId, bool? unreadMessages});
}

/// @nodoc
class __$$ChatInfoImplCopyWithImpl<$Res>
    extends _$ChatInfoCopyWithImpl<$Res, _$ChatInfoImpl>
    implements _$$ChatInfoImplCopyWith<$Res> {
  __$$ChatInfoImplCopyWithImpl(
      _$ChatInfoImpl _value, $Res Function(_$ChatInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? unreadMessages = freezed,
  }) {
    return _then(_$ChatInfoImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadMessages: freezed == unreadMessages
          ? _value.unreadMessages
          : unreadMessages // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatInfoImpl with DiagnosticableTreeMixin implements _ChatInfo {
  const _$ChatInfoImpl({this.userId, this.unreadMessages});

  factory _$ChatInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatInfoImplFromJson(json);

  @override
  final String? userId;
  @override
  final bool? unreadMessages;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatInfo(userId: $userId, unreadMessages: $unreadMessages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatInfo'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('unreadMessages', unreadMessages));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatInfoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.unreadMessages, unreadMessages) ||
                other.unreadMessages == unreadMessages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, unreadMessages);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatInfoImplCopyWith<_$ChatInfoImpl> get copyWith =>
      __$$ChatInfoImplCopyWithImpl<_$ChatInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatInfoImplToJson(
      this,
    );
  }
}

abstract class _ChatInfo implements ChatInfo {
  const factory _ChatInfo({final String? userId, final bool? unreadMessages}) =
      _$ChatInfoImpl;

  factory _ChatInfo.fromJson(Map<String, dynamic> json) =
      _$ChatInfoImpl.fromJson;

  @override
  String? get userId;
  @override
  bool? get unreadMessages;
  @override
  @JsonKey(ignore: true)
  _$$ChatInfoImplCopyWith<_$ChatInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
