abstract class Response<T> {
  T? getOrNull() => null;

  String? getUiErrOrNull() => null;

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
  final String? uiMessage;

  ErrorRes(this.errorMessage, {this.uiMessage});

  @override
  String? getUiErrOrNull() => uiMessage;
}

class ExceptionRes<T> extends Response<T> {
  final Exception exception;
  final String? uiMessage;

  ExceptionRes(this.exception, {this.uiMessage});

  @override
  String? getUiErrOrNull() => uiMessage;
}

Response<T> createResponse<T>(T? value) {
  if (value != null) {
    return SuccessRes<T>(value);
  } else {
    return ErrorRes<T>("createResponse: value is null");
  }
}
