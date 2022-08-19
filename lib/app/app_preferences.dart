import 'package:advanced_flutter_arabic/presentation/resources/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANGUAGE = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEEN_VIWED = "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";


class AppPreferences{
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);
  // language
  Future<String> getAppLanguage()async{
    String? language;
      try{
        language = _sharedPreferences.getString(PREFS_KEY_LANGUAGE);

      }catch (e){
        language = LanguageType.ENGLISH.getValue();
      }

      if(language != null && language.isNotEmpty){
            return language;
      }else{
        return LanguageType.ENGLISH.getValue(); // default language
      }

  }

  Future<void> changeAppLanguage() async{
    String currentLanguage = await getAppLanguage();
    if(currentLanguage ==LanguageType.ARABIC.getValue()){
       await _sharedPreferences.setString(PREFS_KEY_LANGUAGE, LanguageType.ENGLISH.getValue());
    }else{
       await _sharedPreferences.setString(PREFS_KEY_LANGUAGE, LanguageType.ARABIC.getValue());
    }
  }

  Future<Locale> getLocale() async{
    String currentLanguage = await getAppLanguage();
    if(currentLanguage ==LanguageType.ARABIC.getValue()){
      return ARABIC_LOCALE;
    }else{
      return ENGLISH_LOCALE;
    }
  }


  // on boarding
  Future<void> setOnBoardingScreenViewed() async{
       _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEEN_VIWED,true);

  }
  Future<bool> isOnBoardingScreenViewed() async{
      return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEEN_VIWED) ?? false;
    }

  // login screen
  Future<void> setUserLoggedIn() async{
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN,true);

  }
  Future<bool> isUserLoggedIn() async{
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;

  }

  Future<void> logout()async{
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }
}