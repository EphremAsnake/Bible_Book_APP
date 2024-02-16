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
      whiteColor: HexColor("#ffffff"),
      backgroundColor: HexColor("#FEFEFE"),
      primaryColor: HexColor("#7B5533"),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#747475",
      ),
      shadowColor: HexColor("#EEEDED"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#cccbc8"),
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
