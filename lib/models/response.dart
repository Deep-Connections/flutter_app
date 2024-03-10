import 'package:deep_connections/utils/localization_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class Response<T> {
  T? getOrNull() => null;

  String? getUiErrOrNull(AppLocalizations loc) => null;

  bool get isSuccess => this is SuccessRes<T>;

  bool get isFailure => this is ErrorRes || this is ExceptionRes;
}

class SuccessRes<T> extends Response<T> {
  final T data;

  SuccessRes(this.data);

  @override
  T? getOrNull() => data;
}

class ErrorRes<T> extends Response<T> {
  final String errorMessage;
  LocKey? uiMessage = DefaultError;

  ErrorRes(this.errorMessage, {this.uiMessage});

  @override
  String? getUiErrOrNull(AppLocalizations loc) => uiMessage?.localize(loc);
}

class ExceptionRes<T> extends Response<T> {
  final Exception exception;
  LocKey? uiMessage = DefaultError;

  ExceptionRes(this.exception, {this.uiMessage});

  @override
  String? getUiErrOrNull(AppLocalizations loc) => uiMessage?.localize(loc);
}

Response<T> createResponse<T>(T? value) {
  if (value != null) {
    return SuccessRes<T>(value);
  } else {
    return ErrorRes<T>("createResponse: value is null");
  }
}
