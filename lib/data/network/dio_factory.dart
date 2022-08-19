import 'package:advanced_flutter_arabic/app/app_preferences.dart';
import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAUILT_LANGUAGE = "language";





class DioFactory{
  final AppPreferences _appPreferences ;
  DioFactory(this._appPreferences);
  Future<Dio> getDio() async{
    Dio dio =Dio();
    String language =await _appPreferences.getAppLanguage();

    int _timeOut = Constants.API_TIME_OUT; // a min time out
    Map<String,String> headers={
      CONTENT_TYPE:APPLICATION_JSON,
      ACCEPT:APPLICATION_JSON,
      AUTHORIZATION:Constants.token,
      DEFAUILT_LANGUAGE:language, // get language from app pref

    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: _timeOut,
      sendTimeout: _timeOut
    );

    // logs should be enabled just in debug mode not in release mode
    if(!kReleaseMode) { // to know if we are in release mode or not
      dio.interceptors.add(PrettyDioLogger(  // show logs in api response
        requestHeader: true,
        requestBody: true,
        responseBody: true
      ));
    }
    return dio;
  }
}