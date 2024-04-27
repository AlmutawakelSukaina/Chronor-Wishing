

import '../../libs.dart';

mixin class BasedHttpRequests  {

  Future<NetworkServiceResponse> getData<T>(String url,
      {dynamic parameter}) async {


    globalPrint("url inside $url");
      final request = Request('GET', Uri.parse(url)) ;

      if(parameter!=null) {
        request.body = json.encode(parameter);
      }
      final response = await request.send().timeout(const Duration(seconds: 40),
          onTimeout: () {
            throw TimeOutException(kTimeOutException);
          });
      final res = await Response.fromStream(response);

      return res.processResponse();
    }

  }




