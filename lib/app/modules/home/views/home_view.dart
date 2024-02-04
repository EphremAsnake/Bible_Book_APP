import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/modules/home/views/widgets/home_ad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  final DataGetterAndSetter getterAndSetterController =
      Get.find<DataGetterAndSetter>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData?.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAD(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'መጽሐፍ ቅዱስ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              GetBuilder<HomeController>(
                builder: (_) {
                  return SizedBox(
                    height: 900,
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 700,
                              width: 280,
                              child: DefaultTabController(
                                length: 2, // Number of tabs
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TabBar(
                                      indicatorColor: themeData!.primaryColor,
                                      tabs: [
                                        Tab(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'ብሉይ ኪዳን',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: themeData?.primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'አዲስ ኪዳን',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: themeData?.primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 600,
                                      width: 500,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 3),
                                        child: TabBarView(
                                          children: [
                                            GetBuilder<HomeController>(
                                              builder: (_) {
                                                return ListView.builder(
                                                  itemCount: controller
                                                      .oldTestamentBook.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color: index ==
                                                                controller
                                                                    .selectedOldTestamentBookIndex
                                                            ? themeData
                                                                ?.primaryColor
                                                                .withOpacity(
                                                                    0.8)
                                                            : null,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: ListTile(
                                                        visualDensity:
                                                            const VisualDensity(
                                                          vertical: -3,
                                                        ),
                                                        title: Text(
                                                          controller
                                                              .oldTestamentBook[
                                                                  index]
                                                              .titleGeez!,
                                                          style: TextStyle(
                                                            color: index ==
                                                                    controller
                                                                        .selectedOldTestamentBookIndex
                                                                ? themeData
                                                                    ?.whiteColor
                                                                : themeData
                                                                    ?.blackColor,
                                                            fontSize: 16,
                                                            fontWeight: index ==
                                                                    controller
                                                                        .selectedOldTestamentBookIndex
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          controller
                                                              .oldTestamentBook[
                                                                  index]
                                                              .title!,
                                                          style: TextStyle(
                                                            color: index ==
                                                                    controller
                                                                        .selectedOldTestamentBookIndex
                                                                ? themeData
                                                                    ?.whiteColor
                                                                : themeData
                                                                    ?.blackColor,
                                                            fontSize: 14,
                                                            fontWeight: index ==
                                                                    controller
                                                                        .selectedOldTestamentBookIndex
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          controller
                                                              .updateOldTestamentSelectedBookIndex(
                                                                  index);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            GetBuilder<HomeController>(
                                              builder: (_) {
                                                return ListView.builder(
                                                  itemCount: controller
                                                      .newTestamentBook.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color: index ==
                                                                controller
                                                                    .selectedNewTestamentBookIndex
                                                            ? themeData
                                                                ?.primaryColor
                                                                .withOpacity(
                                                                    0.8)
                                                            : null,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: ListTile(
                                                        visualDensity:
                                                            const VisualDensity(
                                                                vertical: -3),
                                                        title: Text(
                                                          controller
                                                              .newTestamentBook[
                                                                  index]
                                                              .titleGeez!,
                                                          style: TextStyle(
                                                            color: index ==
                                                                    controller
                                                                        .selectedNewTestamentBookIndex
                                                                ? themeData
                                                                    ?.whiteColor
                                                                : themeData
                                                                    ?.blackColor,
                                                            fontSize: 16,
                                                            fontWeight: index ==
                                                                    controller
                                                                        .selectedNewTestamentBookIndex
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          controller
                                                              .newTestamentBook[
                                                                  index]
                                                              .title!,
                                                          style: TextStyle(
                                                            color: index ==
                                                                    controller
                                                                        .selectedNewTestamentBookIndex
                                                                ? themeData
                                                                    ?.whiteColor
                                                                : themeData
                                                                    ?.blackColor,
                                                            fontSize: 14,
                                                            fontWeight: index ==
                                                                    controller
                                                                        .selectedNewTestamentBookIndex
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          controller
                                                              .updateNewTestamentSelectedBookIndex(
                                                                  index);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Visibility(
                          visible: controller.selectedOldTestamentBookIndex !=
                                  -1 ||
                              controller.selectedNewTestamentBookIndex != -1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: VerticalDivider(
                              color: themeData?.primaryColor,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: controller.selectedOldTestamentBookIndex !=
                                  -1 ||
                              controller.selectedNewTestamentBookIndex != -1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10),
                                  child: Text(
                                    "ምዕራፍ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: themeData?.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              GetBuilder<HomeController>(
                                builder: (_) {
                                  int bookChapters = 0;

                                  if (controller
                                          .selectedOldTestamentBookIndex !=
                                      -1) {
                                    bookChapters = controller
                                        .oldTestamentBook[controller
                                            .selectedOldTestamentBookIndex]
                                        .chapters!;
                                  } else if (controller
                                          .selectedNewTestamentBookIndex !=
                                      -1) {
                                    bookChapters = controller
                                        .newTestamentBook[controller
                                            .selectedNewTestamentBookIndex]
                                        .chapters!;
                                  }

                                  List<int> chapters = List.generate(
                                      bookChapters, (index) => index + 1);
                                  return SizedBox(
                                    width: 60,
                                    height: MediaQuery.of(context).size.height *
                                        0.80,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: chapters.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: index ==
                                                    controller.selectedIndex
                                                ? themeData?.primaryColor
                                                    .withOpacity(0.8)
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListTile(
                                            dense: true,
                                            visualDensity: const VisualDensity(
                                                vertical: -4),
                                            title: Center(
                                              child: Text(
                                                chapters[index].toString(),
                                                style: TextStyle(
                                                    color: index ==
                                                            controller
                                                                .selectedIndex
                                                        ? themeData?.whiteColor
                                                        : themeData?.blackColor,
                                                    fontSize: 14,
                                                    fontWeight: index ==
                                                            controller
                                                                .selectedIndex
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              ),
                                            ),
                                            onTap: () {
                                              controller
                                                  .updateSelectedIndex(index);
                                              Future.delayed(
                                                const Duration(
                                                    milliseconds: 100),
                                                () {
                                                  if (controller
                                                          .selectedNewTestamentBookIndex !=
                                                      -1) {
                                                    getterAndSetterController
                                                        .selectedVersesAMH
                                                        .clear();
                                                    getterAndSetterController
                                                        .selectedVersesAMH
                                                        .addAll(getterAndSetterController
                                                            .getAMHBookChapters(
                                                                controller
                                                                    .newTestamentBook[
                                                                        controller
                                                                            .selectedNewTestamentBookIndex]
                                                                    .id!,
                                                                chapters[index],
                                                                controller
                                                                    .versesAMH));
                                                  } else if (controller
                                                          .selectedOldTestamentBookIndex !=
                                                      -1) {
                                                    getterAndSetterController
                                                        .selectedVersesAMH
                                                        .clear();
                                                    getterAndSetterController
                                                        .selectedVersesAMH
                                                        .addAll(getterAndSetterController
                                                            .getAMHBookChapters(
                                                                controller
                                                                    .oldTestamentBook[
                                                                        controller
                                                                            .selectedOldTestamentBookIndex]
                                                                    .id!,
                                                                chapters[index],
                                                                controller
                                                                    .versesAMH));
                                                  }
                                                  Get.toNamed("/detail");
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
