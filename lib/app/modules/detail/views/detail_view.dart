import 'package:bible_book_app/app/core/cache/shared_pereferance_storage.dart';
import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/modules/detail/views/amharic_keyboard.dart';
import 'package:bible_book_app/app/modules/detail/views/widgets/drawer.dart';
import 'package:bible_book_app/app/modules/home/controllers/home_controller.dart';
import 'package:bible_book_app/app/modules/home/views/widgets/exit_confirmation_dialogue.dart';
import 'package:bible_book_app/app/modules/home/views/widgets/home_ad.dart';
import 'package:bible_book_app/app/utils/keys/keys.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/detail_controller.dart';

// ignore: must_be_immutable
class DetailView extends GetView<DetailController> {
  DetailView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  final DataGetterAndSetter getterAndSetterController =
      Get.find<DataGetterAndSetter>();
  final HomeController homeController = Get.find<HomeController>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      builder: (_) {
        controller.getSelectedBookName();

        return WillPopScope(
          onWillPop: () async {
            showExitConfirmationDialog(context);
            return false;
          },
          child: Scaffold(
            key: controller.scaffoldKey,
            endDrawer: Drawer(
              width: 90.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 45, bottom: 8),
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(color: Colors.white, width: 1.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                style: TextStyle(
                                    color: themeData?.primaryColor,
                                    fontSize: 13),
                                showCursor: true,
                                cursorColor: themeData?.primaryColor,
                                focusNode: controller.focusNode,
                                controller: controller.searchController,
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (controller.isAmharicKeyboardVisible ==
                                      false) {
                                    controller.makeAmharicKeyboardVisible();
                                  }
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'search'.tr,
                                  hintStyle:
                                      TextStyle(color: themeData?.primaryColor),
                                  labelStyle:
                                      TextStyle(color: themeData?.primaryColor),
                                  border: InputBorder.none,
                                  suffixIcon: Container(
                                    margin: const EdgeInsets.all(0.0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        color: themeData?.primaryColor,
                                        size: 26,
                                      ),
                                      onPressed: () async {
                                        if (controller
                                            .searchController.text.isNotEmpty) {
                                          await EasyLoading.show(
                                              status:
                                                  'Searching Please Wait...');
                                          controller.isLoading = true;
                                          controller.update();
                                          controller.searchResultVerses =
                                              await controller.search(
                                                  BibleType: controller
                                                      .selectedBookTypeOptions,
                                                  searchType: controller
                                                      .selectedSearchTypeOptions,
                                                  searchPlace: controller
                                                      .selectedSearchPlaceOptions,
                                                  query: controller
                                                      .searchController.text);
                                          controller.isAmharicKeyboardVisible =
                                              false;

                                          if (controller
                                              .searchResultVerses.isEmpty) {
                                            Get.snackbar(
                                              'info'.tr,
                                              'no_search_results'.tr,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            );
                                          }
                                          EasyLoading.dismiss();
                                          controller.update();
                                        }
                                      },
                                    ),
                                  ),
                                  prefixIcon: controller
                                          .searchController.text.isNotEmpty
                                      ? Container(
                                          margin: const EdgeInsets.all(0.0),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: themeData?.primaryColor,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              controller.clearSearchBar();
                                            },
                                          ),
                                        )
                                      : null,
                                ),
                                onChanged: (value) {
                                  // setState(() {
                                  //   _searchQuery = value;
                                  // });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 1, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton<String>(
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            value: controller.selectedBookTypeOptions,
                            items:
                                controller.bookTypeOptions.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              controller.setSelectedBookTypeOptions(newValue!);
                            },
                            borderRadius: BorderRadius.circular(10),
                          ),
                          DropdownButton<String>(
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            value: controller.selectedSearchTypeOptions,
                            items: controller.searchTypeOptions
                                .map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              controller
                                  .setSelectedSearchTypeOptions(newValue!);
                            },
                          ),
                          DropdownButton<String>(
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            value: controller.selectedSearchPlaceOptions,
                            items: controller.searchPlaceOptions
                                .map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              controller
                                  .setSelectedSearchPlaceOptions(newValue!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: controller.searchResultVerses.isEmpty,
                      child: const Expanded(child: SizedBox())),

                  Visibility(
                    visible: controller.searchResultVerses.isNotEmpty,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'searchResult'.tr,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: themeData?.blackColor,
                                ),
                              ),
                              TextSpan(
                                text: '${controller.searchResultVerses.length}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: themeData?.primaryColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        )),
                  ),

                  Visibility(
                    visible: controller.searchResultVerses.isNotEmpty,
                    child: Expanded(
                      child: RawScrollbar(
                        thumbColor: themeData?.primaryColor,
                        controller: _scrollController,
                        thickness: 12.0,
                        trackVisibility: true,
                        thumbVisibility: true,
                        interactive: true,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: controller.searchResultVerses.length,
                          itemBuilder: (context, i) {
                            String verseText =
                                controller.searchResultVerses[i].verseText ??
                                    "";
                            String searchText =
                                controller.searchController.text;
                            List<TextSpan> textSpans = [];
                            int start = 0;
                            while (start < verseText.length) {
                              int index = verseText.indexOf(searchText, start);
                              if (index == -1) {
                                textSpans.add(TextSpan(
                                    text: verseText.substring(start),
                                    style:
                                        const TextStyle(color: Colors.black)));
                                break;
                              }
                              textSpans.add(
                                TextSpan(
                                    text:
                                        "${controller.searchResultVerses[i].verseNumber} ${verseText.substring(start, index)}",
                                    style:
                                        const TextStyle(color: Colors.black)),
                              );
                              textSpans.add(TextSpan(
                                text: verseText.substring(
                                    index, index + searchText.length),
                                style: const TextStyle(color: Colors.red),
                              ));

                              start = index + searchText.length;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 4),
                              child: GestureDetector(
                                onTap: () {
                                  detailController
                                      .navigateToSpecificBookDetailView(
                                          controller
                                              .searchResultVerses[i].book!,
                                          controller
                                              .searchResultVerses[i].chapter!);
                                },
                                child: Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.getBookName(controller.searchResultVerses[i].book!)} ${controller.searchResultVerses[i].chapter}:${controller.searchResultVerses[i].verseNumber}",
                                          style: TextStyle(
                                              color: themeData!.primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        RichText(
                                          text: TextSpan(children: textSpans),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: controller.isAmharicKeyboardVisible,
                      child: AmharicKeyboard()),
                  // Drawer content below the search field...
                ],
              ),
            ),
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Color(0xff7B5533),
                  statusBarIconBrightness: Brightness.light),
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  controller.scaffoldKey.currentState?.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: themeData?.primaryColor,
                ),
              ),
              title: GestureDetector(
                onTap: () {
                  showBookSelectionMenu(context);
                },
                child: Container(
                  height: 30,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    color: themeData
                        ?.primaryColor, // Set the background color of the title
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.selectedBook,
                        style: TextStyle(
                          color: themeData
                              ?.whiteColor, // Set the text color of the title
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 18,
                        color: themeData?.whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      controller.scaffoldKey.currentState?.openEndDrawer();
                    },
                    icon: Icon(
                      Icons.search,
                      color: themeData?.primaryColor,
                    )),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: themeData?.primaryColor,
                  ),
                  onSelected: (value) {
                    // Handle menu item selection
                    if (value == 'settings') {
                      Get.toNamed("/settings");
                    } else if (value == 'about') {
                      Get.toNamed("/about");
                    } else if (value == 'privacy_policy') {}
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'settings',
                        child: Text('settings'.tr),
                      ),
                      PopupMenuItem<String>(
                        value: 'about',
                        child: Text('about'.tr),
                      ),
                      // PopupMenuItem<String>(
                      //   value: 'privacy_policy',
                      //   child: Text('privacy_policy'.tr),
                      // ),
                    ];
                  },
                ),
              ],
            ),
            onEndDrawerChanged: (isOpen) {
              if (isOpen == false) {
                controller.searchController.clear();
                controller.searchResultVerses.clear();
              }
            },
            drawer: CustomDrawer(
                themeData: themeData,
                getterAndSetterController: getterAndSetterController),
            body: controller.pageController != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HomeAD(),
                      const SizedBox(height: 5),
                      Expanded(
                        child: ExpandablePageView.builder(
                          controller: controller.pageController,
                          physics: const ClampingScrollPhysics(),
                          itemCount: controller.allVerses.length,
                          animationCurve: Curves.easeIn,
                          onPageChanged: (value) {
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              //scroll to top
                              controller.readerScrollController.animateTo(
                                0.0, // Scroll to the top
                                duration: const Duration(
                                    milliseconds:
                                        500), // Adjust the duration as needed
                                curve: Curves
                                    .easeInOut, // Use a different curve if desired
                              );
                            });
                            //detach the scroll controller and re initialize
                            controller.detachScrollController();
                          },
                          itemBuilder: (context, i) {
                            controller.setPreviousPageNumber(i);
                            // WidgetsBinding.instance.addPostFrameCallback((_) {
                            //   homeController.setSelectedBookAndChapterForDrawer(
                            //       controller.allVerses[i][0].book!,
                            //       controller.allVerses[i][0].chapter!,
                            //       "OT");
                            //   controller.callbackExecuted = true;
                            // });
                            return Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Column(
                                    children: [
                                      Text(
                                        controller.selectedBook
                                                .contains("English")
                                            ? '${controller.getBookTitle(controller.allVerses[i][0].book!)} | Chapter ${controller.allVerses[i][0].chapter}'
                                            : '${controller.getBookTitle(controller.allVerses[i][0].book!)} | ምዕራፍ ${controller.allVerses[i][0].chapter}',
                                        style: TextStyle(
                                          fontSize: 12.5.sp,
                                          fontFamily: "Abyssinica",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: SizedBox(
                                          height: 70.h,
                                          child: SingleChildScrollView(
                                            child: ListView.builder(
                                              controller: controller
                                                  .readerScrollController,
                                              itemCount: controller
                                                  .allVerses[i].length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 14.0,
                                                      vertical: 3),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      index == 0
                                                          ? Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: <Widget>[
                                                                Text(
                                                                  index == 0
                                                                      ? '${controller.allVerses[i][index].chapter}'
                                                                      : '',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Abyssinica",
                                                                    fontSize:
                                                                        50.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: themeData
                                                                        ?.primaryColor,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text: controller.selectedBook.contains("1954")
                                                                              ? '${controller.allVerses[i][index].verseNumber}፤  '
                                                                              : controller.selectedBook.contains("አዲሱ")
                                                                                  ? '${controller.allVerses[i][index].verseNumber}'
                                                                                  : '${controller.allVerses[i][index].verseNumber}  ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                10.0.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: const Color.fromARGB(
                                                                                255,
                                                                                146,
                                                                                45,
                                                                                38),
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text: controller
                                                                              .allVerses[i][index]
                                                                              .verseText,
                                                                          style: TextStyle(
                                                                              fontSize: 12.5.sp,
                                                                              color: Colors.black,
                                                                              fontFamily: "Abyssinica"),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                      if (index != 0)
                                                        RichText(
                                                          text: TextSpan(
                                                            text: controller
                                                                    .selectedBook
                                                                    .contains(
                                                                        "1954")
                                                                ? '${controller.allVerses[i][index].verseNumber}፤  '
                                                                : controller
                                                                        .selectedBook
                                                                        .contains(
                                                                            "አዲሱ")
                                                                    ? '${controller.allVerses[i][index].verseNumber}'
                                                                    : '${controller.allVerses[i][index].verseNumber}  ',
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  146, 45, 38),
                                                            ),
                                                            children: <InlineSpan>[
                                                              TextSpan(
                                                                text:
                                                                    '${controller.allVerses[i][index].verseText}',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Abyssinica",
                                                                    fontSize:
                                                                        12.5.sp,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
            floatingActionButton: controller.hidePageNavigators == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: FloatingActionButton(
                          onPressed: () {
                            controller.pageController?.previousPage(
                                duration: const Duration(milliseconds: 1),
                                curve: Curves.linear);
                            //scroll to top
                            controller.readerScrollController.animateTo(
                              0.0, // Scroll to the top
                              duration: const Duration(
                                  milliseconds:
                                      500), // Adjust the duration as needed
                              curve: Curves
                                  .easeInOut, // Use a different curve if desired
                            );
                          },
                          elevation: 2,
                          heroTag: "prev",
                          backgroundColor: Colors.white,
                          mini: true,
                          child: Icon(
                            Icons.chevron_left,
                            color: themeData?.primaryColor,
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          controller.pageController?.nextPage(
                              duration: const Duration(milliseconds: 1),
                              curve: Curves.linear);
                          //scroll to top
                          controller.readerScrollController.animateTo(
                            0.0, // Scroll to the top
                            duration: const Duration(
                                milliseconds:
                                    500), // Adjust the duration as needed
                            curve: Curves
                                .easeInOut, // Use a different curve if desired
                          );
                        },
                        mini: true,
                        backgroundColor: Colors.white,
                        elevation: 2,
                        heroTag: "next",
                        child: Icon(
                          Icons.chevron_right,
                          color: themeData?.primaryColor,
                        ),
                      ),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }

  Future<dynamic> showBookSelectionMenu(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 247, 247, 247),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          height: 290,
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    child: ListTile(
                      onTap: () async {
                        Get.back();
                        await EasyLoading.show(
                            status: 'Changing Please Wait...');
                        controller.isLoading = true;
                        controller.update();
                        SharedPreferencesStorage sharedPreferencesStorage =
                            SharedPreferencesStorage();
                        getterAndSetterController.versesAMH =
                            await DatabaseService().changeBibleType("AMHKJV");
                        getterAndSetterController.update();
                        controller.allVerses.assignAll(
                            getterAndSetterController.groupedBookList());

                        //saving selected book to local storage
                        sharedPreferencesStorage.saveStringData(
                            Keys.selectedBookKey, "አማርኛ 1954");

                        //set selected book Name
                        controller.setSelectedBook("አማርኛ 1954");

                        //scroll to top
                        controller.readerScrollController.animateTo(
                          0.0, // Scroll to the top
                          duration: const Duration(
                              milliseconds:
                                  500), // Adjust the duration as needed
                          curve: Curves
                              .easeInOut, // Use a different curve if desired
                        );
                        EasyLoading.dismiss();
                        controller.isLoading = false;

                        Get.snackbar(
                          'info'.tr,
                          'changed_to_amh_1954'.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                        );

                        controller.update();
                      },
                      title: const Text('አማርኛ 1954'),
                      leading: Image.asset(
                        "assets/images/bible.png",
                        height: 32.sp,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      onTap: () async {
                        Get.back();
                        await EasyLoading.show(
                            status: 'Changing Please Wait...');
                        controller.isLoading = true;
                        controller.update();
                        SharedPreferencesStorage sharedPreferencesStorage =
                            SharedPreferencesStorage();
                        getterAndSetterController.versesAMH =
                            await DatabaseService().changeBibleType("AMHNIV");
                        getterAndSetterController.update();
                        controller.allVerses.assignAll(
                            getterAndSetterController.groupedBookList());
                        //saving selected book to local storage
                        sharedPreferencesStorage.saveStringData(
                            Keys.selectedBookKey, "አዲሱ መደበኛ ትርጉም");
                        //set selected book Name
                        controller.setSelectedBook("አዲሱ መደበኛ ትርጉም");

                        //scroll to top
                        controller.readerScrollController.animateTo(
                          0.0, // Scroll to the top
                          duration: const Duration(
                              milliseconds:
                                  500), // Adjust the duration as needed
                          curve: Curves
                              .easeInOut, // Use a different curve if desired
                        );
                        EasyLoading.dismiss();
                        controller.isLoading = false;
                        Get.snackbar(
                          'info'.tr,
                          'changed_to_amh_new'.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                        );
                        controller.update();
                      },
                      title: const Text('አዲሱ መደበኛ ትርጉም'),
                      leading: Image.asset(
                        "assets/images/bible.png",
                        height: 32.sp,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      onTap: () async {
                        Get.back();
                        await EasyLoading.show(
                            status: 'Changing Please Wait...');
                        controller.isLoading = true;
                        controller.update();
                        SharedPreferencesStorage sharedPreferencesStorage =
                            SharedPreferencesStorage();
                        getterAndSetterController.versesAMH =
                            await DatabaseService().changeBibleType("ENGNIV");
                        getterAndSetterController.update();
                        controller.allVerses.assignAll(
                            getterAndSetterController.groupedBookList());
                        //saving selected book to local storage
                        sharedPreferencesStorage.saveStringData(
                            Keys.selectedBookKey, "English NIV");

                        //set selected book Name
                        controller.setSelectedBook("English NIV");

                        //scroll to top
                        controller.readerScrollController.animateTo(
                          0.0, // Scroll to the top
                          duration: const Duration(
                              milliseconds:
                                  500), // Adjust the duration as needed
                          curve: Curves
                              .easeInOut, // Use a different curve if desired
                        );
                        EasyLoading.dismiss();
                        controller.isLoading = false;
                        Get.snackbar(
                          'info'.tr,
                          'changed_to_eng_niv'.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                        );
                        controller.update();
                      },
                      title: const Text('English NIV'),
                      leading: Image.asset(
                        "assets/images/bible.png",
                        height: 32.sp,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      onTap: () async {
                        Get.back();
                        await EasyLoading.show(
                            status: 'Changing Please Wait...');

                        controller.isLoading = true;
                        controller.update();
                        SharedPreferencesStorage sharedPreferencesStorage =
                            SharedPreferencesStorage();
                        getterAndSetterController.versesAMH =
                            await DatabaseService().changeBibleType("ENGKJV");
                        getterAndSetterController.update();
                        controller.allVerses.assignAll(
                            getterAndSetterController.groupedBookList());

                        //saving selected book to local storage
                        sharedPreferencesStorage.saveStringData(
                            Keys.selectedBookKey, "English KJV");
                        //set selected book Name
                        controller.setSelectedBook("English KJV");

                        //scroll to top
                        controller.readerScrollController.animateTo(
                          0.0, // Scroll to the top
                          duration: const Duration(
                              milliseconds:
                                  500), // Adjust the duration as needed
                          curve: Curves
                              .easeInOut, // Use a different curve if desired
                        );

                        EasyLoading.dismiss();
                        controller.isLoading = false;
                        Get.snackbar(
                          'info'.tr,
                          'changed_to_eng_kjv'.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                        );
                        controller.update();
                      },
                      title: const Text('English KJV'),
                      leading: Image.asset(
                        "assets/images/bible.png",
                        height: 32.sp,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
