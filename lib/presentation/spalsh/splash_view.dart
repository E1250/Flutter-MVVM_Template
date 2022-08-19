import 'dart:async';

import 'package:advanced_flutter_arabic/app/app_preferences.dart';
import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/constants_manager.dart';
import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  initState(){
    super.initState();
    _startDelay();
  }
  @override
  dispose(){
    _timer?.cancel();
    super.dispose();
  }
  _startDelay(){
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }
  _goNext() async{
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if(isUserLoggedIn){
        // navigate to main screen
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      }else{
        _appPreferences.isOnBoardingScreenViewed().then((isOnBoardingScreenViewed) {
          if(isOnBoardingScreenViewed){
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          }else{
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });

      }

    } );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(child: Image(image: AssetImage(ImagesAssets.splashLogo),)),
    );
  }
}
