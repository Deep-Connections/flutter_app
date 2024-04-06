import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class Response<T> {
  T? getOrNull() => null;

  String? getUiErrOrNull(AppLocalizations loc) => null;

  bool get isSuccess => this is SuccessRes<T>;

  bool get isFailure => this is ErrorRes || this is ExceptionRes;

  void onSuccess(Function(T result) callback) {
    if (this is SuccessRes<T>) {
      callback((this as SuccessRes<T>).data);
    }
  }

  Future onAwaitSuccess(Future Function(T result) callback) async {
    if (this is SuccessRes<T>) {
      await callback((this as SuccessRes<T>).data);
    }
  }
}

class SuccessRes<T> extends Response<T> {
  final T data;

  SuccessRes(this.data);

  @override
  T? getOrNull() => data;
}

class ErrorRes<T> extends Response<T> {
  final String? errorCode;
  final String? errorMessage;
  LocKey? uiMessage = DefaultError;

  ErrorRes({this.errorCode, this.errorMessage, this.uiMessage});

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
    return ErrorRes<T>(errorMessage: "createResponse: value is null");
  }
}
