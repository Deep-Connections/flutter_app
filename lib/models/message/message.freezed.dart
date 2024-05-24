// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Message _$MessageFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'unmatch':
      return MessageUnmatch.fromJson(json);
    case 'delete':
      return MessageDelete.fromJson(json);

    default:
      return MessageData.fromJson(json);
  }
}

/// @nodoc
mixin _$Message {
  String get senderId => throw _privateConstructorUsedError;
  String get chatId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;
  @Freezed(fromJson: false, toJson: false)
  String? get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        $default, {
    required TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        unmatch,
    required TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        $default, {
    TResult? Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        unmatch,
    TResult? Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        $default, {
    TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        unmatch,
    TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(MessageData value) $default, {
    required TResult Function(MessageUnmatch value) unmatch,
    required TResult Function(MessageDelete value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(MessageData value)? $default, {
    TResult? Function(MessageUnmatch value)? unmatch,
    TResult? Function(MessageDelete value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(MessageData value)? $default, {
    TResult Function(MessageUnmatch value)? unmatch,
    TResult Function(MessageDelete value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {String senderId,
      String chatId,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime lastUpdatedAt,
      List<String> participantIds,
      @Freezed(fromJson: false, toJson: false) String? id});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderId = null,
    Object? chatId = null,
    Object? createdAt = null,
    Object? lastUpdatedAt = null,
    Object? participantIds = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      participantIds: null == participantIds
          ? _value.participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageDataImplCopyWith<$Res>
    implements $MessageCopyWith<$Res> {
  factory _$$MessageDataImplCopyWith(
          _$MessageDataImpl value, $Res Function(_$MessageDataImpl) then) =
      __$$MessageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderId,
      String text,
      String chatId,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime lastUpdatedAt,
      List<String> participantIds,
      @Freezed(fromJson: false, toJson: false) String? id});
}

/// @nodoc
class __$$MessageDataImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageDataImpl>
    implements _$$MessageDataImplCopyWith<$Res> {
  __$$MessageDataImplCopyWithImpl(
      _$MessageDataImpl _value, $Res Function(_$MessageDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderId = null,
    Object? text = null,
    Object? chatId = null,
    Object? createdAt = null,
    Object? lastUpdatedAt = null,
    Object? participantIds = null,
    Object? id = freezed,
  }) {
    return _then(_$MessageDataImpl(
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      participantIds: null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageDataImpl with DiagnosticableTreeMixin implements MessageData {
  const _$MessageDataImpl(
      {required this.senderId,
      required this.text,
      required this.chatId,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.lastUpdatedAt,
      required final List<String> participantIds,
      @Freezed(fromJson: false, toJson: false) this.id,
      final String? $type})
      : _participantIds = participantIds,
        $type = $type ?? 'default';

  factory _$MessageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageDataImplFromJson(json);

  @override
  final String senderId;
  @override
  final String text;
  @override
  final String chatId;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime lastUpdatedAt;
  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  @override
  @Freezed(fromJson: false, toJson: false)
  final String? id;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Message(senderId: $senderId, text: $text, chatId: $chatId, createdAt: $createdAt, lastUpdatedAt: $lastUpdatedAt, participantIds: $participantIds, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Message'))
      ..add(DiagnosticsProperty('senderId', senderId))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('chatId', chatId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('lastUpdatedAt', lastUpdatedAt))
      ..add(DiagnosticsProperty('participantIds', participantIds))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageDataImpl &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      senderId,
      text,
      chatId,
      createdAt,
      lastUpdatedAt,
      const DeepCollectionEquality().hash(_participantIds),
      id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageDataImplCopyWith<_$MessageDataImpl> get copyWith =>
      __$$MessageDataImplCopyWithImpl<_$MessageDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        $default, {
    required TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        unmatch,
    required TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        delete,
  }) {
    return $default(
        senderId, text, chatId, createdAt, lastUpdatedAt, participantIds, id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        $default, {
    TResult? Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        unmatch,
    TResult? Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        delete,
  }) {
    return $default?.call(
        senderId, text, chatId, createdAt, lastUpdatedAt, participantIds, id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        $default, {
    TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        unmatch,
    TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        delete,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          senderId, text, chatId, createdAt, lastUpdatedAt, participantIds, id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(MessageData value) $default, {
    required TResult Function(MessageUnmatch value) unmatch,
    required TResult Function(MessageDelete value) delete,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(MessageData value)? $default, {
    TResult? Function(MessageUnmatch value)? unmatch,
    TResult? Function(MessageDelete value)? delete,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(MessageData value)? $default, {
    TResult Function(MessageUnmatch value)? unmatch,
    TResult Function(MessageDelete value)? delete,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageDataImplToJson(
      this,
    );
  }
}

abstract class MessageData implements Message {
  const factory MessageData(
          {required final String senderId,
          required final String text,
          required final String chatId,
          @TimestampConverter() required final DateTime createdAt,
          @TimestampConverter() required final DateTime lastUpdatedAt,
          required final List<String> participantIds,
          @Freezed(fromJson: false, toJson: false) final String? id}) =
      _$MessageDataImpl;

  factory MessageData.fromJson(Map<String, dynamic> json) =
      _$MessageDataImpl.fromJson;

  @override
  String get senderId;
  String get text;
  @override
  String get chatId;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get lastUpdatedAt;
  @override
  List<String> get participantIds;
  @override
  @Freezed(fromJson: false, toJson: false)
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$MessageDataImplCopyWith<_$MessageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessageUnmatchImplCopyWith<$Res>
    implements $MessageCopyWith<$Res> {
  factory _$$MessageUnmatchImplCopyWith(_$MessageUnmatchImpl value,
          $Res Function(_$MessageUnmatchImpl) then) =
      __$$MessageUnmatchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderId,
      String senderFirstName,
      String chatId,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime lastUpdatedAt,
      List<String> participantIds,
      @Freezed(fromJson: false, toJson: false) String? id});
}

/// @nodoc
class __$$MessageUnmatchImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageUnmatchImpl>
    implements _$$MessageUnmatchImplCopyWith<$Res> {
  __$$MessageUnmatchImplCopyWithImpl(
      _$MessageUnmatchImpl _value, $Res Function(_$MessageUnmatchImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderId = null,
    Object? senderFirstName = null,
    Object? chatId = null,
    Object? createdAt = null,
    Object? lastUpdatedAt = null,
    Object? participantIds = null,
    Object? id = freezed,
  }) {
    return _then(_$MessageUnmatchImpl(
      null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      null == senderFirstName
          ? _value.senderFirstName
          : senderFirstName // ignore: cast_nullable_to_non_nullable
              as String,
      null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageUnmatchImpl
    with DiagnosticableTreeMixin
    implements MessageUnmatch {
  const _$MessageUnmatchImpl(
      this.senderId,
      this.senderFirstName,
      this.chatId,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.lastUpdatedAt,
      final List<String> participantIds,
      {@Freezed(fromJson: false, toJson: false) this.id,
      final String? $type})
      : _participantIds = participantIds,
        $type = $type ?? 'unmatch';

  factory _$MessageUnmatchImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageUnmatchImplFromJson(json);

  @override
  final String senderId;
  @override
  final String senderFirstName;
  @override
  final String chatId;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime lastUpdatedAt;
  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  @override
  @Freezed(fromJson: false, toJson: false)
  final String? id;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Message.unmatch(senderId: $senderId, senderFirstName: $senderFirstName, chatId: $chatId, createdAt: $createdAt, lastUpdatedAt: $lastUpdatedAt, participantIds: $participantIds, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Message.unmatch'))
      ..add(DiagnosticsProperty('senderId', senderId))
      ..add(DiagnosticsProperty('senderFirstName', senderFirstName))
      ..add(DiagnosticsProperty('chatId', chatId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('lastUpdatedAt', lastUpdatedAt))
      ..add(DiagnosticsProperty('participantIds', participantIds))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageUnmatchImpl &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderFirstName, senderFirstName) ||
                other.senderFirstName == senderFirstName) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      senderId,
      senderFirstName,
      chatId,
      createdAt,
      lastUpdatedAt,
      const DeepCollectionEquality().hash(_participantIds),
      id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageUnmatchImplCopyWith<_$MessageUnmatchImpl> get copyWith =>
      __$$MessageUnmatchImplCopyWithImpl<_$MessageUnmatchImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        $default, {
    required TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        unmatch,
    required TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        delete,
  }) {
    return unmatch(senderId, senderFirstName, chatId, createdAt, lastUpdatedAt,
        participantIds, id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        $default, {
    TResult? Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        unmatch,
    TResult? Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        delete,
  }) {
    return unmatch?.call(senderId, senderFirstName, chatId, createdAt,
        lastUpdatedAt, participantIds, id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        $default, {
    TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        unmatch,
    TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        delete,
    required TResult orElse(),
  }) {
    if (unmatch != null) {
      return unmatch(senderId, senderFirstName, chatId, createdAt,
          lastUpdatedAt, participantIds, id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(MessageData value) $default, {
    required TResult Function(MessageUnmatch value) unmatch,
    required TResult Function(MessageDelete value) delete,
  }) {
    return unmatch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(MessageData value)? $default, {
    TResult? Function(MessageUnmatch value)? unmatch,
    TResult? Function(MessageDelete value)? delete,
  }) {
    return unmatch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(MessageData value)? $default, {
    TResult Function(MessageUnmatch value)? unmatch,
    TResult Function(MessageDelete value)? delete,
    required TResult orElse(),
  }) {
    if (unmatch != null) {
      return unmatch(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageUnmatchImplToJson(
      this,
    );
  }
}

abstract class MessageUnmatch implements Message {
  const factory MessageUnmatch(
          final String senderId,
          final String senderFirstName,
          final String chatId,
          @TimestampConverter() final DateTime createdAt,
          @TimestampConverter() final DateTime lastUpdatedAt,
          final List<String> participantIds,
          {@Freezed(fromJson: false, toJson: false) final String? id}) =
      _$MessageUnmatchImpl;

  factory MessageUnmatch.fromJson(Map<String, dynamic> json) =
      _$MessageUnmatchImpl.fromJson;

  @override
  String get senderId;
  String get senderFirstName;
  @override
  String get chatId;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get lastUpdatedAt;
  @override
  List<String> get participantIds;
  @override
  @Freezed(fromJson: false, toJson: false)
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$MessageUnmatchImplCopyWith<_$MessageUnmatchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessageDeleteImplCopyWith<$Res>
    implements $MessageCopyWith<$Res> {
  factory _$$MessageDeleteImplCopyWith(
          _$MessageDeleteImpl value, $Res Function(_$MessageDeleteImpl) then) =
      __$$MessageDeleteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderId,
      String senderFirstName,
      String chatId,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime lastUpdatedAt,
      List<String> participantIds,
      @Freezed(fromJson: false, toJson: false) String? id});
}

/// @nodoc
class __$$MessageDeleteImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageDeleteImpl>
    implements _$$MessageDeleteImplCopyWith<$Res> {
  __$$MessageDeleteImplCopyWithImpl(
      _$MessageDeleteImpl _value, $Res Function(_$MessageDeleteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderId = null,
    Object? senderFirstName = null,
    Object? chatId = null,
    Object? createdAt = null,
    Object? lastUpdatedAt = null,
    Object? participantIds = null,
    Object? id = freezed,
  }) {
    return _then(_$MessageDeleteImpl(
      null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      null == senderFirstName
          ? _value.senderFirstName
          : senderFirstName // ignore: cast_nullable_to_non_nullable
              as String,
      null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageDeleteImpl
    with DiagnosticableTreeMixin
    implements MessageDelete {
  const _$MessageDeleteImpl(
      this.senderId,
      this.senderFirstName,
      this.chatId,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.lastUpdatedAt,
      final List<String> participantIds,
      {@Freezed(fromJson: false, toJson: false) this.id,
      final String? $type})
      : _participantIds = participantIds,
        $type = $type ?? 'delete';

  factory _$MessageDeleteImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageDeleteImplFromJson(json);

  @override
  final String senderId;
  @override
  final String senderFirstName;
  @override
  final String chatId;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime lastUpdatedAt;
  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  @override
  @Freezed(fromJson: false, toJson: false)
  final String? id;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Message.delete(senderId: $senderId, senderFirstName: $senderFirstName, chatId: $chatId, createdAt: $createdAt, lastUpdatedAt: $lastUpdatedAt, participantIds: $participantIds, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Message.delete'))
      ..add(DiagnosticsProperty('senderId', senderId))
      ..add(DiagnosticsProperty('senderFirstName', senderFirstName))
      ..add(DiagnosticsProperty('chatId', chatId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('lastUpdatedAt', lastUpdatedAt))
      ..add(DiagnosticsProperty('participantIds', participantIds))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageDeleteImpl &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderFirstName, senderFirstName) ||
                other.senderFirstName == senderFirstName) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      senderId,
      senderFirstName,
      chatId,
      createdAt,
      lastUpdatedAt,
      const DeepCollectionEquality().hash(_participantIds),
      id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageDeleteImplCopyWith<_$MessageDeleteImpl> get copyWith =>
      __$$MessageDeleteImplCopyWithImpl<_$MessageDeleteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        $default, {
    required TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        unmatch,
    required TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)
        delete,
  }) {
    return delete(senderId, senderFirstName, chatId, createdAt, lastUpdatedAt,
        participantIds, id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        $default, {
    TResult? Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        unmatch,
    TResult? Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        delete,
  }) {
    return delete?.call(senderId, senderFirstName, chatId, createdAt,
        lastUpdatedAt, participantIds, id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String senderId,
            String text,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        $default, {
    TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        unmatch,
    TResult Function(
            String senderId,
            String senderFirstName,
            String chatId,
            @TimestampConverter() DateTime createdAt,
            @TimestampConverter() DateTime lastUpdatedAt,
            List<String> participantIds,
            @Freezed(fromJson: false, toJson: false) String? id)?
        delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(senderId, senderFirstName, chatId, createdAt, lastUpdatedAt,
          participantIds, id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(MessageData value) $default, {
    required TResult Function(MessageUnmatch value) unmatch,
    required TResult Function(MessageDelete value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(MessageData value)? $default, {
    TResult? Function(MessageUnmatch value)? unmatch,
    TResult? Function(MessageDelete value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(MessageData value)? $default, {
    TResult Function(MessageUnmatch value)? unmatch,
    TResult Function(MessageDelete value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageDeleteImplToJson(
      this,
    );
  }
}

abstract class MessageDelete implements Message {
  const factory MessageDelete(
          final String senderId,
          final String senderFirstName,
          final String chatId,
          @TimestampConverter() final DateTime createdAt,
          @TimestampConverter() final DateTime lastUpdatedAt,
          final List<String> participantIds,
          {@Freezed(fromJson: false, toJson: false) final String? id}) =
      _$MessageDeleteImpl;

  factory MessageDelete.fromJson(Map<String, dynamic> json) =
      _$MessageDeleteImpl.fromJson;

  @override
  String get senderId;
  String get senderFirstName;
  @override
  String get chatId;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get lastUpdatedAt;
  @override
  List<String> get participantIds;
  @override
  @Freezed(fromJson: false, toJson: false)
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$MessageDeleteImplCopyWith<_$MessageDeleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
