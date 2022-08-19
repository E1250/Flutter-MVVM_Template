import 'package:advanced_flutter_arabic/data/network/failure.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


class ErrorHandler implements Exception{

  late Failure failure;

  ErrorHandler.handle(dynamic error){
    if(error is DioError){
      failure = _handleError(error);
    }else{
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error){
  switch (error.type){
    case DioErrorType.connectTimeout:
     return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioErrorType.response:
      if(error.response!=null&&error.response?.statusCode!=null&& error.response?.statusMessage!=null){
        return Failure(error.response?.statusCode ?? 0, error.response?.statusMessage ?? "");
      }else{
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource{
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource{
  Failure getFailure(){
    switch(this){
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
        break;
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
        break;
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
        break;
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
        break;
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
        break;
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
        break;
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR);
        break;
      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
        break;
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
        break;
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
        break;
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
        break;
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
        break;
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}


class ResponseCode{
  static const int SUCCESS = 200; //
  static const int NO_CONTENT = 201; //
  static const int BAD_REQUEST = 400; //
  static const int FORBIDDEN = 403; //
  static const int UNAUTHORIZED = 401; //
  static const int NOT_FOUND = 404; //
  static const int INTERNAL_SERVER_ERROR = 500; //

  // local status code
  static const int CONNECT_TIMEOUT = -1; //
  static const int CANCEL = -2; //
  static const int RECEIVE_TIMEOUT = -3; //
  static const int SEND_TIMEOUT = -4; //
  static const int CACHE_ERROR = -5; //
  static const int NO_INTERNET_CONNECTION = -6; //
  static const int DEFAULT = -7; //


}


class ResponseMessage{

  static const String SUCCESS = AppStrings.success; //
  static const String NO_CONTENT = AppStrings.noContent; //
  static const String BAD_REQUEST = AppStrings.badRequest; //
  static const String FORBIDDEN = AppStrings.forbidden; //
  static const String UNAUTHORIZED = AppStrings.unauthorized; //
  static const String NOT_FOUND = AppStrings.notFound; //
  static const String INTERNAL_SERVER_ERROR = AppStrings.internalServerError; //
  // local status code
  static const String CONNECT_TIMEOUT = AppStrings.connectTimeout; //
  static const String CANCEL = AppStrings.cancel; //
  static const String RECEIVE_TIMEOUT = AppStrings.receiveTimeout; //
  static const String SEND_TIMEOUT = AppStrings.sendTimeout; //
  static const String CACHE_ERROR = AppStrings.cacheError; //
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetConnection; //
  static const String DEFAULT = AppStrings.defaultError; //


}



class ApiInternalsStatus{
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}