import 'package:flutter/material.dart';
import 'package:remainder_application/presentation/resources/color_manager.dart';
import 'package:remainder_application/presentation/resources/font_manager.dart';
import 'package:remainder_application/presentation/resources/styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primaryLight,
    primaryColorLight: ColorManager.primaryLight,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.disabledColor,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),

    // ripple color

    splashColor: ColorManager.primaryLight,

    // card view theme

    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,),

    // app bar theme

    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primaryLight,
        elevation: AppSize.s4,
        shadowColor: ColorManager.primaryDark,
        titleTextStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),),

    //button theme

    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.disabledColor,
        buttonColor: ColorManager.primaryLight,
        splashColor: ColorManager.primaryLight),

    //elevated button theme

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.white),
          primary: ColorManager.primaryLight,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s16))),
    ),

    // text theme

    textTheme: TextTheme(
      headline1: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      subtitle1:
          getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14),
      subtitle2:
      getMediumStyle(color: ColorManager.primaryLight, fontSize: FontSize.s14),
      caption: getRegularStyle(color: ColorManager.disabledColor),
      bodyText1: getRegularStyle(color: ColorManager.grey),
    ),

    //input declaration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      //hint style
      hintStyle: getRegularStyle(color: ColorManager.disabledColor),
      //label style
      labelStyle: getMediumStyle(color: ColorManager.darkGrey),
      //error style
      errorStyle: getRegularStyle(color: ColorManager.error),

      //enabled border

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      //focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primaryLight, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      //error border

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      //focused error border

      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primaryLight, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
