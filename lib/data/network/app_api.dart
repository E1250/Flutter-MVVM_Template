import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../response/responses.dart';
part 'app_api.g.dart';


@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient{
  factory AppServiceClient(Dio dio,{String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password
      );

  @POST("/customers/forgotPassword")
  Future<ForgetPassResponse> forgotPassword(
      @Field("email") String email,
      );

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
      @Field("user_name") String userName,
      @Field("country_code") String countryCode,
      @Field("mobile_number") String mobileNumber,
      @Field("email") String email,
      @Field("password") String password,
      @Field("profile_pic") String profilePic,

      );

  @GET("/home")
  Future<HomeResponse> getHomeData();

  @GET("/storeDetails/1")
  Future<StoreDetailsResponse> getStoreDetails();
}


