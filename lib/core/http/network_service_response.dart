import '../utils/enum.dart';

class NetworkServiceResponse {
  EnumStatus status;
  dynamic data;
  NetworkServiceResponse.completed() : status = EnumStatus.complete;

  NetworkServiceResponse.error() : status = EnumStatus.error;


  NetworkServiceResponse({required this.status, this.data});
}




