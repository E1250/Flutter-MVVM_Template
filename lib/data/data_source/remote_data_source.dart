import 'package:advanced_flutter_arabic/data/network/app_api.dart';
import 'package:advanced_flutter_arabic/data/network/requests.dart';
import 'package:advanced_flutter_arabic/data/response/responses.dart';
import 'package:advanced_flutter_arabic/domain/models/models.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgetPassResponse> forgotPass(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetails();

}

class RemoteDataSourceImpl implements RemoteDataSource{

  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
    return await _appServiceClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgetPassResponse> forgotPass(String email) async{
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async{
    return await _appServiceClient.register(
      registerRequest.userName,
      registerRequest.password,
      "",
      registerRequest.mobilNumber,
      registerRequest.countryCode,
      registerRequest.email,

    );
  }

  @override
  Future<HomeResponse> getHomeData() async{
    return await _appServiceClient.getHomeData();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() {
    return _appServiceClient.getStoreDetails();
  }

}