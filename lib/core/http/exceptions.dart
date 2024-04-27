const String kException = 'Exception:';
const String kTimeOutException = 'TimeOut';
const String kFetchDataException = 'Error During Communication';

class AppException implements Exception {
  final String _message;
  final String _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return "$kException $_prefix $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message!, "$kFetchDataException: ");
}

class TimeOutException extends AppException {
  TimeOutException([message]) : super(message, "$kTimeOutException: ");
}