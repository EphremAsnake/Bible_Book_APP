import 'package:bible_book_app/app/core/core_dependency.dart';
import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/utils/helpers/app_translation.dart';
import 'package:bible_book_app/app/utils/helpers/internetConnectivity.dart';
import 'package:bible_book_app/app/utils/helpers/master_data_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final internetConnectivity = InternetConnectivity();
  await internetConnectivity.initialize();

  //initializing Hive
  await Hive.initFlutter();
  await Hive.openBox('bible_app');

  //injecting http dependency
  CoreDependencyCreator.init();

  //getting app's master data
  await MasterDataHelper().getMasterData();

  //putting getter and setter controller
  Get.put(DataGetterAndSetter());

  //setting app theme
  final themeController = Get.put(ThemeController());
  themeController.getThemeData();

  // Set the app to be in portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff7B5533), // Set your desired status bar color
  ));

  runApp(
    Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        translations: AppTranslation(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('amh', 'ET'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: customSwatch,
        ),
        title: "Bible App",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    }),
  );
}

MaterialColor customSwatch = MaterialColor(0xff7B5533, {
  50: const Color(0xff7B5533).withOpacity(0.1),
  100: const Color(0xff7B5533).withOpacity(0.2),
  200: const Color(0xff7B5533).withOpacity(0.3),
  300: const Color(0xff7B5533).withOpacity(0.4),
  400: const Color(0xff7B5533).withOpacity(0.5),
  500: const Color(0xff7B5533).withOpacity(0.6),
  600: const Color(0xff7B5533).withOpacity(0.7),
  700: const Color(0xff7B5533).withOpacity(0.8),
  800: const Color(0xff7B5533).withOpacity(0.9),
  900: const Color(0xff7B5533).withOpacity(1.0),
});
