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
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.5.sp
                          : 9.sp),
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
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.5.sp
                            : 9.sp),
                  ),
                ),
              ),
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
                  showThemeConfigBottomSheet(context);
                },
                leading: const Icon(
                  Icons.color_lens_outlined,
                  color: Colors.grey,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 30,
                ),
                title: Text(
                  "theme".tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.5.sp
                          : 9.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showFontSizeBottomSheet(BuildContext context) {
  final DetailController detailController = Get.find<DetailController>();
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
                  style: TextStyle(
                      fontSize: SizerUtil.deviceType == DeviceType.mobile
                          ? 12.5.sp
                          : 9.sp),
                ),
                Slider(
                  value: detailController.fontSize,
                  onChanged: (value) async {
                    await detailController.updateFontSize(value);
                    // await detailController.updateChapterFontSize(value);
                    detailController.update();
                  },
                  min: SizerUtil.deviceType == DeviceType.mobile ? 10.0 : 8,
                  max: SizerUtil.deviceType == DeviceType.mobile ? 20 : 14,
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

void showThemeConfigBottomSheet(BuildContext context) {
  final DetailController detailController = Get.find<DetailController>();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    "theme".tr,
                    style: TextStyle(
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 12.5.sp
                            : 9.sp),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Divider(),
                ),
                const SizedBox(
                  height: 12,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 192, 192, 192)),
                              color: const Color.fromARGB(255, 247, 222, 184),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(child: Text("Gold")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 192, 192, 192)),
                              color: const Color.fromARGB(255, 238, 225, 206),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(child: Text("Amber")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 192, 192, 192)),
                              color: const Color.fromARGB(255, 198, 222, 238),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(child: Text("Blue")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 192, 192, 192)),
                              color: const Color.fromARGB(255, 112, 149, 173),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            "Blue-2",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 192, 192, 192)),
                              color: const Color.fromARGB(255, 77, 77, 77),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            "Dark",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 192, 192, 192)),
                              color: const Color.fromARGB(255, 96, 187, 178),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            "Teal",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 192, 192, 192)),
                              color: const Color.fromARGB(255, 198, 245, 240),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            "Teal 2",
                            style: TextStyle(color: Colors.black),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 192, 192, 192)),
                              color: const Color.fromARGB(255, 179, 137, 123),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            "Brown",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 192, 192, 192)),
                              color: const Color.fromARGB(255, 175, 175, 175),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            "Grey",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    },
  );
}
