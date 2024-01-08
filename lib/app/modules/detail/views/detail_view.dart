import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
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

  @override
  Widget build(BuildContext context) {
    List<List<VersesAMH>> data = getterAndSetterController.groupedBookList();
    String chapterText = "";
    // String title = "";
    // for (int i = 0; i < data.length; i++) {
    //   if (data[i].para == "mt1") {
    //     print(data[i].para);
    //     title = data[i].verseText!;
    //   } else {
    //     chapterText = "$chapterText ${i + 1} ${data[i].verseText}";
    //   }
    // }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.menu,
          color: themeData?.primaryColor,
        ),
        title: GestureDetector(
          onTap: () {
            showModalBottomSheet(
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                      child: Column(
                        children: [
                          Card(
                            elevation: 0,
                            child: ListTile(
                              title: const Text('አማርኛ 1954'),
                              leading: Image.asset("assets/images/bible.png",height: 32.sp,),
                              trailing: const Icon(Icons.chevron_right),
                            ),
                          ),
                          Card(
                             elevation: 0,
                            child: ListTile(
                              title: const Text('አዲስ መደበኛ ትርጉም'),
                              leading: Image.asset("assets/images/bible.png",height: 32.sp,),
                              trailing: const Icon(Icons.chevron_right),
                            ),
                          ),
                          Card(
                             elevation: 0,
                            child: ListTile(
                              title: const Text('English NIV'),
                              leading: Image.asset("assets/images/bible.png",height: 32.sp,),
                              trailing: const Icon(Icons.chevron_right),
                            ),
                          ),
                          Card(
                             elevation: 0,
                            child: ListTile(
                              title: const Text('English KJV'),
                              leading: Image.asset("assets/images/bible.png",height: 32.sp,),
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
          },
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: themeData
                  ?.primaryColor, // Set the background color of the title
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'አማርኛ 1954',
                  style: TextStyle(
                    color: Colors.white, // Set the text color of the title
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 2),
                Icon(Icons.arrow_drop_down, size: 18),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
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
                  child: Text('Option 1'),
                ),
                const PopupMenuItem<String>(
                  value: 'option2',
                  child: Text('Option 2'),
                ),
                const PopupMenuItem<String>(
                  value: 'option3',
                  child: Text('Option 3'),
                ),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: PageFlipWidget(
          key: _controller,
          backgroundColor: Colors.white,
          lastPage: Container(
              color: Colors.white,
              child: const Center(child: Text('Last Page!'))),
          initialIndex: 0,
          children: data.map<Widget>(
            (book) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Text(title),

                    // Text(
                    //   "ምዕራፍ ${book[0].chapter}",
                    //   style: const TextStyle(
                    //     fontSize: 17.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(20.0),
                      minScale: 0.1,
                      maxScale: 3.0,
                      child: SizedBox(
                        height: 800,
                        child: ListView.builder(
                          itemCount: book.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  index == 0
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              index == 0
                                                  ? '${book[index].chapter}'
                                                  : '',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: "Abyssinica",
                                                fontSize: 50.0,
                                                fontWeight: FontWeight.normal,
                                                color: themeData?.primaryColor,
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
                                                          '${book[index].verseNumber}፤   ',
                                                      style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 146, 45, 38),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          book[index].verseText,
                                                      style: const TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black,
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
                                        text: '${book[index].verseNumber}፤   ',
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 146, 45, 38),
                                        ),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: '${book[index].verseText}',
                                            style: TextStyle(
                                              fontFamily: "Abyssinica",
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle: book[index].para ==
                                                          "q1" ||
                                                      book[index].para == "q2"
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
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
