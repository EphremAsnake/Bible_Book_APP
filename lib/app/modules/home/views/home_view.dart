import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:bible_book_app/app/modules/home/views/widgets/home_ad.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:bible_book_app/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
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
                  'Holy Bible',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              GetBuilder<HomeController>(
                init: HomeController(),
                initState: (_) {},
                builder: (_) {
                  if (controller.cacheStateHandler.apiState ==
                      ApiState.loading) {
                    return SizedBox(
                      height: 400,
                      width: 500,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2),
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                color: themeData!.whiteColor,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (controller.cacheStateHandler.apiState ==
                      ApiState.success) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TabBar(
                                        indicatorColor: themeData!.primaryColor,
                                        tabs: [
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Old Testament',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      themeData?.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'New Testament',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      themeData?.primaryColor,
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
                                                init: HomeController(),
                                                initState: (_) {},
                                                builder: (_) {
                                                  return ListView.builder(
                                                    itemCount: controller
                                                        .oldTestamentBook
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
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
                                                init: HomeController(),
                                                initState: (_) {},
                                                builder: (_) {
                                                  return ListView.builder(
                                                    itemCount: controller
                                                        .newTestamentBook
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: VerticalDivider(
                              color: themeData?.primaryColor,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10),
                                  child: Text(
                                    "Chapters",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: themeData?.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              GetBuilder<HomeController>(
                                init: HomeController(),
                                initState: (_) {},
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
                                                    controller.selectedVersesAMH
                                                        .clear();
                                                    controller.selectedVersesAMH
                                                        .addAll(controller
                                                            .getAMHBookChapters(
                                                                controller
                                                                    .newTestamentBook[
                                                                        index]
                                                                    .id!,
                                                                controller
                                                                    .newTestamentBook[
                                                                        index]
                                                                    .chapters!,
                                                                controller
                                                                    .versesAMH));
                                                  } else if (controller
                                                          .selectedOldTestamentBookIndex !=
                                                      -1) {
                                                    controller.selectedVersesAMH
                                                        .addAll(controller
                                                            .getAMHBookChapters(
                                                                controller
                                                                    .newTestamentBook[
                                                                        index]
                                                                    .id!,
                                                                controller
                                                                    .newTestamentBook[
                                                                        index]
                                                                    .chapters!,
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
                        ],
                      ),
                    );
                  } else if (controller.cacheStateHandler.apiState ==
                      ApiState.error) {
                    return RefreshErrorWidget(
                      showBackToHomeButton: false,
                      assetImage: "assets/images/error.png",
                      errorMessage:
                          "No internet connection, please check your internet connection and try again.",
                      onRefresh: () async {
                        controller.readBibleData();
                        controller.update();
                      },
                    );
                  } else {
                    return RefreshErrorWidget(
                      showBackToHomeButton: false,
                      assetImage: "assets/images/error.png",
                      errorMessage:
                          "No internet connection, please check your internet connection and try again.",
                      onRefresh: () async {
                        controller.readBibleData();
                        controller.update();
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
