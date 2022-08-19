import 'package:advanced_flutter_arabic/app/app_preferences.dart';
import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/data/data_source/local_data_source.dart';
import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../resources/language_manager.dart';
import '../../../resources/strings_manager.dart';
import 'dart:math' as math;

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: SvgPicture.asset(ImagesAssets.changeLang),
            title: Text(AppStrings.changeLanguage.tr(),style: Theme.of(context).textTheme.bodyLarge),
            trailing:Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_isRTL(context)?math.pi:0),
              child: SvgPicture.asset(ImagesAssets.rightArrowSetting),
            ),
            onTap: (){
              _changeLanguage(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesAssets.contactUs),
            title: Text(AppStrings.contactUs.tr(),style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_isRTL(context)?math.pi:0),
              child: SvgPicture.asset(ImagesAssets.rightArrowSetting),
            ),
            onTap: (){
              _contactUs();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesAssets.inviteFriends),
            title: Text(AppStrings.inviteFriends.tr(),style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_isRTL(context)?math.pi:0),
              child: SvgPicture.asset(ImagesAssets.rightArrowSetting),
            ),
            onTap: (){
              _inviteFriends();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesAssets.logout),
            title: Text(AppStrings.logout.tr(),style: Theme.of(context).textTheme.bodyLarge),
            onTap: (){
              _logout(context);
            },
          ),

        ],
      ),
    );
  }


  bool _isRTL(BuildContext context){
    return context.locale == ARABIC_LOCALE;
  }

  _changeLanguage(context){
    // i will implement it
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _contactUs(){
    // task to open page using url
  }

  _inviteFriends(){
    // share app
  }
  
  _logout(context){
    // app logout >> app preferences make user logout
    _appPreferences.logout();
    // clear cache when logout
    _localDataSource.clearCache();
    // navigate to login screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
