import 'package:advanced_flutter_arabic/data/data_source/local_data_source.dart';
import 'package:advanced_flutter_arabic/data/mapper/mapper.dart';
import 'package:advanced_flutter_arabic/data/network/error_handler.dart';
import 'package:advanced_flutter_arabic/data/network/failure.dart';
import 'package:advanced_flutter_arabic/data/network/requests.dart';
import 'package:advanced_flutter_arabic/domain/models/models.dart';
import 'package:advanced_flutter_arabic/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository{

  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource,this._networkInfo,this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
    if(await _networkInfo.isConnected){
      // it is connected to internet, safe to call API
      try{
        final response =await _remoteDataSource.login(loginRequest);
        if(response.status == ApiInternalsStatus.SUCCESS){
          // success
          // return data
          return Right(response.toDomain());
        }else{
          // fail
          // return
          return Left(Failure(ApiInternalsStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));

        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    }else{
      // internet connection error
      // fail
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,ResponseMessage.NO_INTERNET_CONNECTION));

    }
  }


  @override
  Future<Either<Failure, String>> forgetPass(String email) async{
    if(await _networkInfo.isConnected){
      // it is connected to internet, safe to call API
      try{
        final response =await _remoteDataSource.forgotPass(email);
        if(response.status == ApiInternalsStatus.SUCCESS){
          // success
          // return data
          return Right(response.toDomain());
        }else{
          // fail
          // return
          return Left(Failure(ApiInternalsStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));

        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    }else{
      // internet connection error
      // fail
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,ResponseMessage.NO_INTERNET_CONNECTION));

    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async{
    if(await _networkInfo.isConnected){
      // it is connected to internet, safe to call API
      try{
        final response =await _remoteDataSource.register(registerRequest);
        if(response.status == ApiInternalsStatus.SUCCESS){
          // success
          // return data
          return Right(response.toDomain());
        }else{
          // fail
          // return
          return Left(Failure(ApiInternalsStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));

        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    }else{
      // internet connection error
      // fail
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,ResponseMessage.NO_INTERNET_CONNECTION));

    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async{

    try{
      // get response from cache
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());

    }catch(cacheError){
      // cache is not existing or not valid

      // get data from api
      if(await _networkInfo.isConnected){
        // it is connected to internet, safe to call API
        try{
          final response =await _remoteDataSource.getHomeData();
          if(response.status == ApiInternalsStatus.SUCCESS){
            // save response in cache (local data source)
            _localDataSource.saveHomeToCache(response);
            // success
            // return data
            return Right(response.toDomain());
          }else{
            // fail
            // return
            return Left(Failure(ApiInternalsStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));

          }
        }catch(error){
          return Left(ErrorHandler.handle(error).failure);
        }

      }else{
        // internet connection error
        // fail
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,ResponseMessage.NO_INTERNET_CONNECTION));

      }

    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async{

    try{
      // get response from cache
      final response = await _localDataSource.getStoreDetails();
      return Right(response.toDomain());

    }catch(cacheError){
      // cache is not existing or not valid

      // get data from api
      if(await _networkInfo.isConnected){
        // it is connected to internet, safe to call API
        try{
          final response =await _remoteDataSource.getStoreDetails();
          if(response.status == ApiInternalsStatus.SUCCESS){
            // save response in cache (local data source)
            _localDataSource.saveStoreDetailsToCache(response);
            // success
            // return data
            return Right(response.toDomain());
          }else{
            // fail
            // return
            return Left(Failure(ApiInternalsStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));

          }
        }catch(error){
          return Left(ErrorHandler.handle(error).failure);
        }

      }else{
        // internet connection error
        // fail
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,ResponseMessage.NO_INTERNET_CONNECTION));

      }

    }
  }




}