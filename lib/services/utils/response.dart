import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class Response<T> {
  T? getOrNull() => null;

  String? getUiErrOrNull(AppLocalizations loc) => null;

  bool get isSuccess => this is SuccessRes<T>;

  bool get isFailure => this is ErrorRes || this is ExceptionRes;

  Response<T> onSuccess(Function(T result) callback) {
    if (this is SuccessRes<T>) {
      callback((this as SuccessRes<T>).data);
    }
    return this;
  }

  Response<T> onFailure(Function(FailureRes response) callback) {
    if (this is FailureRes<T>) {
      callback((this as FailureRes<T>));
    }
    return this;
  }
}

class SuccessRes<T> extends Response<T> {
  final T data;

  SuccessRes(this.data);

  @override
  T? getOrNull() => data;
}

class FailureRes<T> extends Response<T> {
  LocKey? uiMessage = defaultError;

  FailureRes({this.uiMessage});

  @override
  String? getUiErrOrNull(AppLocalizations loc) => uiMessage?.localize(loc);
}

class ErrorRes<T> extends FailureRes<T> {
  final String? errorCode;
  final String? errorMessage;

  ErrorRes({this.errorCode, this.errorMessage, super.uiMessage});
}

class ExceptionRes<T> extends FailureRes<T> {
  final Exception exception;

  ExceptionRes(this.exception, {super.uiMessage});
}

Response<T> createResponse<T>(T? value) {
  if (value != null) {
    return SuccessRes<T>(value);
  } else {
    return ErrorRes<T>(errorMessage: "createResponse: value is null");
  }
}
