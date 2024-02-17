import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:bible_book_app/app/modules/detail/helpers/detail_helpers.dart';
import 'package:bible_book_app/app/modules/home/controllers/home_controller.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:bible_book_app/app/utils/helpers/app_colors.dart';
import 'package:bible_book_app/app/utils/helpers/in_app_web_viewer.dart';
import 'package:bible_book_app/app/utils/shared_widgets/refresh_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    super.key,
    required this.themeData,
    required this.getterAndSetterController,
  });

  final ThemeDataModel? themeData;
  final DataGetterAndSetter getterAndSetterController;
  final DetailController detailController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 90.w,
      child: Column(
        //physics: const NeverScrollableScrollPhysics(),
        children: [
          GetBuilder<DetailController>(
            init: DetailController(),
            initState: (_) {},
            builder: (_) {
              if (detailController.apiStateHandler.apiState ==
                  ApiState.loading) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      color: themeData!.whiteColor,
                    ),
                  ),
                );
              } else if (detailController.apiStateHandler.apiState ==
                  ApiState.success) {
                if (detailController
                        .apiStateHandler.data!.houseAds[0].houseAd1!.show ==
                    true) {
                  return GestureDetector(
                    onTap: () {
                      if (detailController.apiStateHandler.data!.houseAds[0]
                              .houseAd1!.openInAppBrowser ==
                          true) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => InAppWebViewer(
                                url: detailController.apiStateHandler.data!
                                    .houseAds[0].houseAd1!.url),
                          ),
                        );
                      } else {
                        DetailHelpers().openStores(
                            androidAppId: detailController.apiStateHandler.data!
                                .houseAds[0].houseAd1!.url);
                      }
                    },
                    child: Container(
                      height: 25.h,
                      width: 90.w,
                      padding: const EdgeInsets.all(0),
                      child: Image(
                        image: NetworkImage(
                          detailController.apiStateHandler.data!.houseAds[0]
                              .houseAd1!.image,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 25.h,
                    width: 90.w,
                    padding: const EdgeInsets.all(0),
                    child: const Image(
                      image: AssetImage(
                        "assets/images/banner.jpeg",
                      ),
                      fit: BoxFit.fill,
                    ),
                  );
                }
              } else {
                return Container(
                  height: 25.h,
                  width: 90.w,
                  padding: const EdgeInsets.all(0),
                  child: const Image(
                    image: AssetImage(
                      "assets/images/banner.jpeg",
                    ),
                    fit: BoxFit.fill,
                  ),
                );
              }
            },
          ),
          Expanded(
            child: GetBuilder<HomeController>(
              init: HomeController(),
              initState: (_) {},
              builder: (controller) {
                if (controller.cacheStateHandler.apiState == ApiState.loading) {
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 68.w,
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
                                              alignment: Alignment.center,
                                              child: Text(
                                                'ot'.tr,
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color:
                                                      themeData?.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'nt'.tr,
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color:
                                                      themeData?.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: 80.w,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3, left: 3, bottom: 0),
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
                                                                ? const Color(
                                                                    0xffB8A696)
                                                                : null,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: ListTile(
                                                            dense: true,
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
                                                              detailController
                                                                      .isSelectingBook =
                                                                  true;

                                                              detailController
                                                                  .update();
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
                                                                ? const Color(
                                                                    0xffB8A696)
                                                                : null,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: ListTile(
                                                            dense: true,
                                                            visualDensity:
                                                                const VisualDensity(
                                                                    vertical:
                                                                        -3),
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
                                                              detailController
                                                                      .isSelectingBook =
                                                                  true;
                                                              detailController
                                                                  .update();
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
                                      ),
                                    ],
                                  ),
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
                            padding: EdgeInsets.symmetric(
                                vertical: 0.sp, horizontal: 0),
                            child: VerticalDivider(
                              color: themeData?.primaryColor,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: controller.selectedOldTestamentBookIndex !=
                                  -1 ||
                              controller.selectedNewTestamentBookIndex != -1,
                          child: SizedBox(
                            width: 17.w,
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
                                    return Expanded(
                                      child: SizedBox(
                                        width: 15.w,
                                        child: ListView.builder(
                                          controller: detailController
                                              .drawerScrollController,
                                          shrinkWrap: true,
                                          itemCount: chapters.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: index ==
                                                          controller
                                                              .selectedIndex
                                                      ? const Color(0xffB8A696)
                                                      : null,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ListTile(
                                                  dense: false,
                                                  visualDensity:
                                                      const VisualDensity(
                                                          vertical: -4),
                                                  title: Center(
                                                    child: Text(
                                                      chapters[index]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: index ==
                                                                  controller
                                                                      .selectedIndex
                                                              ? themeData
                                                                  ?.whiteColor
                                                              : themeData
                                                                  ?.blackColor,
                                                          fontSize: index ==
                                                                  controller
                                                                      .selectedIndex
                                                              ? 12.sp
                                                              : 12.sp,
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
                                                                  chapters[
                                                                      index],
                                                                  controller
                                                                      .versesAMH));

                                                          int page = detailController
                                                              .navigateToSpecificBookDetailView(
                                                                  controller
                                                                      .newTestamentBook[
                                                                          controller
                                                                              .selectedNewTestamentBookIndex]
                                                                      .id!,
                                                                  chapters[
                                                                      index]);
                                                          detailController
                                                              .pageController
                                                              ?.jumpToPage(
                                                                  page);
                                                          detailController
                                                              .update();
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
                                                                  chapters[
                                                                      index],
                                                                  controller
                                                                      .versesAMH));
                                                        }
                                                        int page = detailController
                                                            .navigateToSpecificBookDetailView(
                                                                controller
                                                                    .oldTestamentBook[
                                                                        controller
                                                                            .selectedOldTestamentBookIndex]
                                                                    .id!,
                                                                chapters[
                                                                    index]);
                                                        detailController
                                                            .pageController
                                                            ?.jumpToPage(page);
                                                        detailController
                                                            .update();
                                                        Get.toNamed("/detail");
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
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
          ),
        ],
      ),
    );
  }
}
