// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Chat.fromJson(json);
}

/// @nodoc
mixin _$Chat {
  List<String> get participantIds => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  Map<String, ChatInfo>? get chatInfos => throw _privateConstructorUsedError;
  @Freezed(fromJson: false, toJson: false)
  String? get id => throw _privateConstructorUsedError;
  @Freezed(fromJson: false, toJson: false)
  Message? get lastMessage => throw _privateConstructorUsedError;
  @Freezed(fromJson: false, toJson: false)
  int? get unreadMessages => throw _privateConstructorUsedError;
  @Freezed(fromJson: false, toJson: false)
  String? get currentUserId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res, Chat>;
  @useResult
  $Res call(
      {List<String> participantIds,
      @TimestampConverter() DateTime createdAt,
      Map<String, ChatInfo>? chatInfos,
      @Freezed(fromJson: false, toJson: false) String? id,
      @Freezed(fromJson: false, toJson: false) Message? lastMessage,
      @Freezed(fromJson: false, toJson: false) int? unreadMessages,
      @Freezed(fromJson: false, toJson: false) String? currentUserId});

  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatCopyWithImpl<$Res, $Val extends Chat>
    implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? participantIds = null,
    Object? createdAt = null,
    Object? chatInfos = freezed,
    Object? id = freezed,
    Object? lastMessage = freezed,
    Object? unreadMessages = freezed,
    Object? currentUserId = freezed,
  }) {
    return _then(_value.copyWith(
      participantIds: null == participantIds
          ? _value.participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      chatInfos: freezed == chatInfos
          ? _value.chatInfos
          : chatInfos // ignore: cast_nullable_to_non_nullable
              as Map<String, ChatInfo>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
      unreadMessages: freezed == unreadMessages
          ? _value.unreadMessages
          : unreadMessages // ignore: cast_nullable_to_non_nullable
              as int?,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatImplCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$$ChatImplCopyWith(
          _$ChatImpl value, $Res Function(_$ChatImpl) then) =
      __$$ChatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> participantIds,
      @TimestampConverter() DateTime createdAt,
      Map<String, ChatInfo>? chatInfos,
      @Freezed(fromJson: false, toJson: false) String? id,
      @Freezed(fromJson: false, toJson: false) Message? lastMessage,
      @Freezed(fromJson: false, toJson: false) int? unreadMessages,
      @Freezed(fromJson: false, toJson: false) String? currentUserId});

  @override
  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ChatImplCopyWithImpl<$Res>
    extends _$ChatCopyWithImpl<$Res, _$ChatImpl>
    implements _$$ChatImplCopyWith<$Res> {
  __$$ChatImplCopyWithImpl(_$ChatImpl _value, $Res Function(_$ChatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? participantIds = null,
    Object? createdAt = null,
    Object? chatInfos = freezed,
    Object? id = freezed,
    Object? lastMessage = freezed,
    Object? unreadMessages = freezed,
    Object? currentUserId = freezed,
  }) {
    return _then(_$ChatImpl(
      participantIds: null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      chatInfos: freezed == chatInfos
          ? _value._chatInfos
          : chatInfos // ignore: cast_nullable_to_non_nullable
              as Map<String, ChatInfo>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
      unreadMessages: freezed == unreadMessages
          ? _value.unreadMessages
          : unreadMessages // ignore: cast_nullable_to_non_nullable
              as int?,
      currentUserId: freezed == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatImpl extends _Chat {
  const _$ChatImpl(
      {required final List<String> participantIds,
      @TimestampConverter() required this.createdAt,
      final Map<String, ChatInfo>? chatInfos,
      @Freezed(fromJson: false, toJson: false) this.id,
      @Freezed(fromJson: false, toJson: false) this.lastMessage,
      @Freezed(fromJson: false, toJson: false) this.unreadMessages,
      @Freezed(fromJson: false, toJson: false) this.currentUserId})
      : _participantIds = participantIds,
        _chatInfos = chatInfos,
        super._();

  factory _$ChatImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatImplFromJson(json);

  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  @override
  @TimestampConverter()
  final DateTime createdAt;
  final Map<String, ChatInfo>? _chatInfos;
  @override
  Map<String, ChatInfo>? get chatInfos {
    final value = _chatInfos;
    if (value == null) return null;
    if (_chatInfos is EqualUnmodifiableMapView) return _chatInfos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @Freezed(fromJson: false, toJson: false)
  final String? id;
  @override
  @Freezed(fromJson: false, toJson: false)
  final Message? lastMessage;
  @override
  @Freezed(fromJson: false, toJson: false)
  final int? unreadMessages;
  @override
  @Freezed(fromJson: false, toJson: false)
  final String? currentUserId;

  @override
  String toString() {
    return 'Chat(participantIds: $participantIds, createdAt: $createdAt, chatInfos: $chatInfos, id: $id, lastMessage: $lastMessage, unreadMessages: $unreadMessages, currentUserId: $currentUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatImpl &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._chatInfos, _chatInfos) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.unreadMessages, unreadMessages) ||
                other.unreadMessages == unreadMessages) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_participantIds),
      createdAt,
      const DeepCollectionEquality().hash(_chatInfos),
      id,
      lastMessage,
      unreadMessages,
      currentUserId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatImplCopyWith<_$ChatImpl> get copyWith =>
      __$$ChatImplCopyWithImpl<_$ChatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatImplToJson(
      this,
    );
  }
}

abstract class _Chat extends Chat {
  const factory _Chat(
      {required final List<String> participantIds,
      @TimestampConverter() required final DateTime createdAt,
      final Map<String, ChatInfo>? chatInfos,
      @Freezed(fromJson: false, toJson: false) final String? id,
      @Freezed(fromJson: false, toJson: false) final Message? lastMessage,
      @Freezed(fromJson: false, toJson: false) final int? unreadMessages,
      @Freezed(fromJson: false, toJson: false)
      final String? currentUserId}) = _$ChatImpl;
  const _Chat._() : super._();

  factory _Chat.fromJson(Map<String, dynamic> json) = _$ChatImpl.fromJson;

  @override
  List<String> get participantIds;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  Map<String, ChatInfo>? get chatInfos;
  @override
  @Freezed(fromJson: false, toJson: false)
  String? get id;
  @override
  @Freezed(fromJson: false, toJson: false)
  Message? get lastMessage;
  @override
  @Freezed(fromJson: false, toJson: false)
  int? get unreadMessages;
  @override
  @Freezed(fromJson: false, toJson: false)
  String? get currentUserId;
  @override
  @JsonKey(ignore: true)
  _$$ChatImplCopyWith<_$ChatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
