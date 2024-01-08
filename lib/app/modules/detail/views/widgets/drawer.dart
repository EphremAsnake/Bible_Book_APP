
import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/modules/home/controllers/home_controller.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:bible_book_app/app/utils/helpers/app_colors.dart';
import 'package:bible_book_app/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.themeData,
    required this.getterAndSetterController,
  });

  final ThemeDataModel? themeData;
  final DataGetterAndSetter getterAndSetterController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: Padding(
        padding: const EdgeInsets.only(left: 0,right: 0,bottom: 37,top: 0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            DrawerHeader(
               padding: EdgeInsets.all(0),
              child: Container(
                child: Image(image: AssetImage("assets/images/banner.jpeg",),fit: BoxFit.fill,),
              ),
            ),
            GetBuilder<HomeController>(
              init: HomeController(),
              initState: (_) {},
              builder: (controller) {
                if (controller.cacheStateHandler.apiState ==
                    ApiState.loading) {
                  return SizedBox(
                    height: 400,
                    width: 220,
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
                    height: 80.h,
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 80.h,
                              width: 220,
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
                                              'ብሉይ ኪዳን',
                                              style: TextStyle(
                                                fontSize: 14.5,
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
                                              'አዲስ ኪዳን',
                                              style: TextStyle(
                                                fontSize: 14.5,
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
                                      height: 100.h,
                                      width: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0, left: 3),
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
                                                                    ?.primaryColor
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
                                                                    ?.primaryColor
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
                                                                    ?.primaryColor
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
                                                                    ?.primaryColor
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
                        // Visibility(
                        //   visible: controller.selectedOldTestamentBookIndex !=
                        //           -1 ||
                        //       controller.selectedNewTestamentBookIndex != -1,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(vertical: 40),
                        //     child: VerticalDivider(
                        //       color: themeData?.primaryColor,
                        //     ),
                        //   ),
                        // ),
                        Visibility(
                          visible: controller.selectedOldTestamentBookIndex !=
                                  -1 ||
                              controller.selectedNewTestamentBookIndex != -1,
                          child: SizedBox(
                            width: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50),
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
                                      width: 80,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.80,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: chapters.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ListTile(
                                              dense: true,
                                              visualDensity:
                                                  const VisualDensity(
                                                      vertical: -4),
                                              title: Center(
                                                child: Text(
                                                  chapters[index].toString(),
                                                  style: TextStyle(
                                                      color: index ==
                                                              controller
                                                                  .selectedIndex
                                                          ? themeData
                                                              ?.primaryColor
                                                          : themeData
                                                              ?.blackColor,
                                                      fontSize: index ==
                                                              controller
                                                                  .selectedIndex
                                                          ? 16
                                                          : 14,
                                                      fontWeight: index ==
                                                              controller
                                                                  .selectedIndex
                                                          ? FontWeight.bold
                                                          : FontWeight
                                                              .normal),
                                                ),
                                              ),
                                              onTap: () {
                                                controller
                                                    .updateSelectedIndex(
                                                        index);
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
                                                          .addAll(getterAndSetterController.getAMHBookChapters(
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
                                                          .addAll(getterAndSetterController.getAMHBookChapters(
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
    );
  }
}
