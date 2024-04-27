







import '../../../libs.dart';

Map<int, EnumStatus> statusCodeMap = {
  200: EnumStatus.complete,
  201: EnumStatus.created,
  400: EnumStatus.error,
  401: EnumStatus.noPermission,
  403: EnumStatus.forbidden,
  404: EnumStatus.error,
};

extension ProcessRemoteDataSourceResponse on Response {
  NetworkServiceResponse processResponse() {
    if (statusCodeMap[statusCode] != null) {
      try {
        return NetworkServiceResponse(
          status: statusCodeMap[statusCode] ?? EnumStatus.error,
          data: json.decode(utf8.decode(bodyBytes)),
        );
      } catch (ignore) {
        globalPrint("error catch $ignore");
        try {
          return NetworkServiceResponse(
            status: statusCodeMap[statusCode] ?? EnumStatus.error,
            data: utf8.decode(bodyBytes),
          );
        } catch (e) {
          return NetworkServiceResponse(
            status: statusCodeMap[statusCode] ?? EnumStatus.error,
            data: bodyBytes,
          );
        }
      }
    } else if (statusCode == 504) {
      throw TimeOutException();
    } else {
      throw FetchDataException();
    }
  }
}

