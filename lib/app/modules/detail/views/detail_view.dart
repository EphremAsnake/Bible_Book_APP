import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/modules/detail/views/amharic_keyboard.dart';
import 'package:bible_book_app/app/modules/detail/views/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_flip/page_flip.dart';
import 'package:sizer/sizer.dart';
import '../controllers/detail_controller.dart';

// ignore: must_be_immutable
class DetailView extends GetView<DetailController> {
  DetailView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  final DataGetterAndSetter getterAndSetterController =
      Get.find<DataGetterAndSetter>();
  final _controller = GlobalKey<PageFlipWidgetState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // List<Verses> selectedVerses = getterAndSetterController.verseAMHListFor    update();Book;
    // int defaultIndex = data.indexOf(selectedVerses);
    // String chapterText = "";

    // String title = "";
    // for (int i = 0; i < data.length; i++) {
    //   if (data[i].para == "mt1") {
    //     print(data[i].para);
    //     title = data[i].verseText!;
    //   } else {
    //     chapterText = "$chapterText ${i + 1} ${data[i].verseText}";
    //   }
    // }
    return GetBuilder<DetailController>(
      init: DetailController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: Drawer(
            width: 90.w,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 15, bottom: 10),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.white, width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              focusNode: controller.focusNode,
                              controller: controller.searchController,
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (controller.isAmharicKeyboardVisible ==
                                    false) {
                                  controller.makeAmharicKeyboardVisible();
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'ፍልግ',
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
                                border: InputBorder.none,
                                suffixIcon: Container(
                                  margin: const EdgeInsets.all(4.0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      controller.searchResultVerses =
                                          await controller.search(
                                              BibleType: "AMHNIV",
                                              searchType: controller
                                                  .selectedSearchTypeOptions,
                                              searchPlace: controller
                                                  .selectedSearchPlaceOptions,
                                              query: controller
                                                  .searchController.text);
                                      controller.update();
                                    },
                                  ),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
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

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showBookSelectionMenu(context);
                        },
                        child: Container(
                          height: 38,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                            color: themeData
                                ?.primaryColor, // Set the background color of the title
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'አማርኛ 1954',
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
                      DropdownButton<String>(
                        value: controller.selectedSearchTypeOptions,
                        items:
                            controller.searchTypeOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.setSelectedSearchTypeOptions(newValue!);
                        },
                      ),
                      DropdownButton<String>(
                        value: controller.selectedSearchPlaceOptions,
                        items:
                            controller.searchPlaceOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.setSelectedSearchPlaceOptions(newValue!);
                        },
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Visibility(
                  visible: controller.searchResultVerses.isNotEmpty,
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.searchResultVerses.length,
                      itemBuilder: (context, index) {
                        String verseText =
                            controller.searchResultVerses[index].verseText ??
                                "";
                        String searchText = controller.searchController.text;
                        List<TextSpan> textSpans = [];
                        int start = 0;
                        while (start < verseText.length) {
                          int index = verseText.indexOf(searchText, start);
                          if (index == -1) {
                            textSpans.add(TextSpan(
                                text: verseText.substring(start),
                                style: const TextStyle(color: Colors.black)));
                            break;
                          }
                          textSpans.add(
                            TextSpan(
                                text: verseText.substring(start, index),
                                style: const TextStyle(color: Colors.black)),
                          );
                          textSpans.add(TextSpan(
                            text: verseText.substring(
                                index, index + searchText.length),
                            style: const TextStyle(color: Colors.red),
                          ));

                          start = index + searchText.length;
                        }

                        return RichText(
                          text: TextSpan(children: textSpans),
                        );
                      },
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
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
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
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: themeData
                      ?.primaryColor, // Set the background color of the title
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'አማርኛ 1954',
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
                    _scaffoldKey.currentState?.openEndDrawer();
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
                  if (value == 'option1') {
                    // Perform action for option 1
                  } else if (value == 'option2') {
                    // Perform action for option 2
                  } else if (value == 'option3') {
                    // Perform action for option 3
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'option1',
                      child: Text('Settings'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'option2',
                      child: Text('About'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'option3',
                      child: Text('Privacy Policy'),
                    ),
                  ];
                },
              ),
            ],
          ),
          drawer: CustomDrawer(
              themeData: themeData,
              getterAndSetterController: getterAndSetterController),
          body: SafeArea(
            child: PageFlipWidget(
              key: _controller,
              backgroundColor: Colors.white,
              lastPage: Container(
                  color: Colors.white,
                  child: const Center(child: Text('Last Page!'))),
              initialIndex: 0,
              children: <Widget>[
                for (var i = 0; i < controller.allVerses.length; i++)
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "ምዕራፍ ${controller.allVerses[i][0].chapter}",
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontFamily: "Abyssinica",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // AmharicKeyboard(),
                        InteractiveViewer(
                          boundaryMargin: const EdgeInsets.all(20.0),
                          minScale: 0.1,
                          maxScale: 3.0,
                          child: SizedBox(
                            height: 800,
                            child: ListView.builder(
                              itemCount: controller.allVerses.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 3),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      index == 0
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  index == 0
                                                      ? '${controller.allVerses[i][index].chapter}'
                                                      : '',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: "Abyssinica",
                                                    fontSize: 50.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        themeData?.primaryColor,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              '${controller.allVerses[i][index].verseNumber}፤   ',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    146,
                                                                    45,
                                                                    38),
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: controller
                                                              .allVerses[i]
                                                                  [index]
                                                              .verseText,
                                                          style: const TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "Abyssinica"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      if (index != 0)
                                        RichText(
                                          text: TextSpan(
                                            text:
                                                '${controller.allVerses[i][index].verseNumber}፤   ',
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 146, 45, 38),
                                            ),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    '${controller.allVerses[i][index].verseText}',
                                                style: TextStyle(
                                                  fontFamily: "Abyssinica",
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: controller
                                                                  .allVerses[i]
                                                                      [index]
                                                                  .para ==
                                                              "q1" ||
                                                          controller
                                                                  .allVerses[i]
                                                                      [index]
                                                                  .para ==
                                                              "q2"
                                                      ? FontStyle.italic
                                                      : FontStyle.normal,
                                                  color: Colors.black,
                                                ),
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
                      ],
                    ),
                  ),
              ],
            ),
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
              topLeft: Radius.circular(80),
              topRight: Radius.circular(80),
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
                        getterAndSetterController.versesAMH =
                            await DatabaseService().changeBibleType("AMHNIV");
                        getterAndSetterController.update();
                        controller.allVerses =
                            getterAndSetterController.groupedBookList();
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
                        getterAndSetterController.versesAMH =
                            await DatabaseService().changeBibleType("AMHKJV");
                        getterAndSetterController.update();
                        controller.allVerses =
                            getterAndSetterController.groupedBookList();

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
                        getterAndSetterController.versesAMH =
                            await DatabaseService().changeBibleType("ENGNIV");
                        getterAndSetterController.update();
                        controller.allVerses =
                            getterAndSetterController.groupedBookList();

                        var data = controller.allVerses;
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
                        getterAndSetterController.versesAMH =
                            await DatabaseService().changeBibleType("ENGKJV");
                        getterAndSetterController.update();
                        controller.allVerses =
                            getterAndSetterController.groupedBookList();
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
