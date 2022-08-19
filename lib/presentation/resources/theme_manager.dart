import 'package:advanced_flutter_arabic/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary, // ripple effect color
    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4
    ),

    //appbar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s16)
  ),

    //button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),  // semi circle edges button
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white,fontSize:FontSize.s17 ),
        primary: ColorManager.error,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12)
        )
      )
    ),

    // text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16),
      headlineMedium: getRegularStyle(color: ColorManager.darkGrey,fontSize: FontSize.s14),
      
      headlineLarge: getSemiBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16),
      titleMedium: getMediumStyle(color: ColorManager.primary,fontSize: FontSize.s16),
      titleSmall: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s16),
      labelSmall: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s12),
      bodyLarge: getRegularStyle(color: ColorManager.grey1),
      bodySmall: getRegularStyle(color: ColorManager.grey),
        bodyMedium: getRegularStyle(color: ColorManager.grey2,fontSize: FontSize.s12)

  ),

    //input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      // hist style
      hintStyle: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14),
      // label style
      labelStyle: getMediumStyle(color: ColorManager.grey,fontSize: FontSize.s14),
      // error style
      errorStyle: getRegularStyle(color: ColorManager.error),
      // enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey,width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
      ),
      // focused border style
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
      ),
      // error border style
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
      ),
      // focused border style
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
      ),

    )


  );
}