import 'package:dio/dio.dart';
import 'package:royalcruiser/api/api_url.dart';
import 'package:royalcruiser/constants/common_constance.dart';


class DioClient {
  static Dio? dio ;

  static Dio? getDioClient() {
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = CommonConstants.CONNECTION_TIME_OUT_IN_MILL_SEC;
      dio!.options.receiveTimeout = CommonConstants.RECEIVE_TIME_OUT_IN_MILL_SEC;
      dio!.options.baseUrl = ApiUrls.str_URL;
      dio!.options.headers = {
        'Content-Type': 'text/xml; charset=utf-8',
      };
      // dio!.options.headers['content-Type'] = 'text/xml; charset=UTF-8';
      // dio!.options.headers['Access-Control-Allow-Origin'] = '*';
      // dio!.options.headers['Access-Control-Allow-Methods'] = 'GET , POST';
    }
    return dio;
  }
}
