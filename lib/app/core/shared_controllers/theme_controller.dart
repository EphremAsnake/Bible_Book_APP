import 'package:bible_book_app/app/core/shared_controllers/master_data_controller.dart';
import 'package:bible_book_app/app/utils/helpers/app_colors.dart';
import 'package:bible_book_app/app/utils/helpers/hex_color_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final MasterDataController controller = Get.find();
  Rx<ThemeDataModel?> themeData = Rx<ThemeDataModel?>(null);

  void getThemeData() {
    final theme = ThemeDataModel(
      whiteColor: HexColor(
          controller.configs?.appConfig.appColors.whiteColor ?? "#ffffff"),
      backgroundColor: HexColor(
          controller.configs?.appConfig.appColors.backgroundColor ?? "#FEFEFE"),
      primaryColor: HexColor(
          controller.configs?.appConfig.appColors.primaryColor ?? "#7B5533"),
      blackColor: HexColor(
          controller.configs?.appConfig.appColors.blackColor ?? "#000000"),
      grayTextColor: HexColor(
        controller.configs?.appConfig.appColors.grayTextColor ?? "#747475",
      ),
      shadowColor: HexColor(
          controller.configs?.appConfig.appColors.shadowColor ?? "#EEEDED"),
      splashColor: HexColor(
          controller.configs?.appConfig.appColors.splashColor ?? "#AF703A"),
      errorColor: HexColor(
          controller.configs?.appConfig.appColors.errorColor ?? "#FF1100"),
      lightGrey: HexColor(
          controller.configs?.appConfig.appColors.lightGrey ?? "#cccbc8"),
    );
    themeData.value = theme;
    setAppTheme(theme);
  }
}

void setAppTheme(ThemeDataModel theme) {
  final appTheme = ThemeData(
    primaryColor: theme.primaryColor,
    scaffoldBackgroundColor: theme.backgroundColor,
    cardColor: theme.whiteColor,
    textTheme: TextTheme(
      headlineMedium: TextStyle(color: theme.blackColor),
      labelMedium: TextStyle(color: theme.blackColor),
      bodyMedium: TextStyle(color: theme.blackColor),
      bodySmall: TextStyle(color: theme.blackColor),
      titleMedium: TextStyle(color: theme.grayTextColor),
    ),
  );

  Get.changeTheme(appTheme);
}
