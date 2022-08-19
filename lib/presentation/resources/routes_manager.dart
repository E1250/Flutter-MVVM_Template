import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/presentation/forget_password/view/forget_password_view.dart';
import 'package:advanced_flutter_arabic/presentation/login/view/login_view.dart';
import 'package:advanced_flutter_arabic/presentation/main/main_view.dart';
import 'package:advanced_flutter_arabic/presentation/onboarding/view/onboarding_view.dart';
import 'package:advanced_flutter_arabic/presentation/register/view/register_view.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/spalsh/splash_view.dart';
import 'package:advanced_flutter_arabic/presentation/store_details/view/store_details_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Routes{
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String onBoardingRoute = "/onBoarding";

}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=>const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_)=>const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_)=>const RegisterView());
      case Routes.forgotPasswordRoute:
        initForgetPassModule();
        return MaterialPageRoute(builder: (_)=>const ForgetPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_)=>const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_)=>const StoreDetailsView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=>const OnBoardingView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() => MaterialPageRoute(builder: (_)=>Scaffold(appBar: AppBar(title: Text(AppStrings.noRouteFound.tr())),body:Center(child: Text(AppStrings.noRouteFound.tr())) ,));
}