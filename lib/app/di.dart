import 'package:advanced_flutter_arabic/app/app_preferences.dart';
import 'package:advanced_flutter_arabic/data/data_source/local_data_source.dart';
import 'package:advanced_flutter_arabic/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter_arabic/data/network/app_api.dart';
import 'package:advanced_flutter_arabic/data/network/dio_factory.dart';
import 'package:advanced_flutter_arabic/data/network/network_info.dart';
import 'package:advanced_flutter_arabic/domain/repository/repository.dart';
import 'package:advanced_flutter_arabic/domain/use_case/forget_usecase.dart';
import 'package:advanced_flutter_arabic/domain/use_case/home_usecase.dart';
import 'package:advanced_flutter_arabic/domain/use_case/login_usecase.dart';
import 'package:advanced_flutter_arabic/domain/use_case/register_usecase.dart';
import 'package:advanced_flutter_arabic/domain/use_case/store_details_usecase.dart';
import 'package:advanced_flutter_arabic/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:advanced_flutter_arabic/presentation/main/pages/home/view_modle/home_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/register/view_model/register_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/store_details/view/store_details_view.dart';
import 'package:advanced_flutter_arabic/presentation/store_details/view_model/store_details_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repository/repository_impl.dart';
import '../presentation/forget_password/view_model/forget_password_view_model.dart';

final instance = GetIt.instance; // map has all instances

// all these are instance using many times during the app

Future<void> initAppModule() async{
  // app module, module where we could call generic dependencies

  // shared pref instance
  final sharedPrefs =await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(()=>sharedPrefs);

  // app preferences
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance())); // or instance<SharedPreferences>()


  // network info instance
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
/*  DioFactory dioFactory =DioFactory(_appPreferences); // not good way
  Dio dio = await dioFactory.getDio();*/
  Dio dio = await instance<DioFactory>().getDio();

  // app service client instance
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository 
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(),instance(),instance()));
}

 initLoginModule() async{
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() =>LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() =>LoginViewModel(instance()));
  }
}


initForgetPassModule() async {
  if (!GetIt.I.isRegistered<ForgetUseCase>()) {
    instance.registerFactory<ForgetUseCase>(() => ForgetUseCase(instance()));
    instance.registerFactory<ForgetPassViewModel>(() =>
        ForgetPassViewModel(instance()));
  }
}
initRegisterModule() async{
  if(!GetIt.I.isRegistered<RegisterUseCase>()){
    instance.registerFactory<RegisterUseCase>(() =>RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() =>RegisterViewModel(instance()));


    instance.registerFactory<ImagePicker>(() =>ImagePicker());

  }


}

initHomeModule() async{
  if(!GetIt.I.isRegistered<HomeUseCase>()){
    instance.registerFactory<HomeUseCase>(() =>HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() =>HomeViewModel(instance()));


    instance.registerFactory<ImagePicker>(() =>ImagePicker());
  }
}


initStoreDetailsModule() async{
  if(!GetIt.I.isRegistered<StoreDetailsUseCase>()){
    instance.registerFactory<StoreDetailsUseCase>(() =>StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(() =>StoreDetailsViewModel(instance()));
  }
}


