import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  final DetailController detailController = Get.find<DetailController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData?.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xff7B5533),
            statusBarIconBrightness: Brightness.light),
        elevation: 0,
        backgroundColor: const Color(0xff7B5533),
        title: Text(
          'settings'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: themeData!.whiteColor),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffEEEDED),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 8), // horizontal, vertical offset
                  ),
                  BoxShadow(
                    color: Color(0xffEEEDED),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, -8), // horizontal, vertical offset
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  if (Get.locale.toString() == "amh_ET") {
                    detailController.saveLocale('en_US');
                    Get.updateLocale(const Locale('en', 'US'));
                    Get.snackbar(
                      'Info',
                      'App Language Changed To English',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    Get.updateLocale(const Locale('amh', 'ET'));
                    detailController.saveLocale('amh_ET');
                    Get.snackbar(
                      'መረጃ',
                      'የመተግበሪያ ቋንቋ ወደ አማርኛ ተቀይሯል።',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                leading: const Icon(
                  Icons.translate,
                  color: Colors.grey,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 30,
                ),
                title: Text(
                  "change_language".tr,
                  style: TextStyle(color: Colors.black, fontSize: 12.5.sp),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffEEEDED),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 8), // horizontal, vertical offset
                    ),
                    BoxShadow(
                      color: Color(0xffEEEDED),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, -8), // horizontal, vertical offset
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    showFontSizeBottomSheet(context);
                  },
                  leading: const Icon(
                    Icons.font_download,
                    color: Colors.grey,
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 30,
                  ),
                  title: Text(
                    "font_size".tr,
                    style: TextStyle(color: Colors.black, fontSize: 12.5.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFontSizeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<DetailController>(
          init: DetailController(),
          initState: (_) {},
          builder: (_) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "font_size".tr,
                    style: TextStyle(fontSize: 12.5.sp),
                  ),
                  Slider(
                    value: detailController.fontSize,
                    onChanged: (value) async {
                      await detailController.updateFontSize(value);
                      detailController.update();
                    },
                    min: 10.0,
                    max: 15,
                    label: detailController.fontSize.toString(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
