import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:page_flip/page_flip.dart';

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
                    const SizedBox(
                      height: 40,
                    ),
                    // Text(
                    //   "ምዕራፍ ${book[0].chapter}",
                    //   style: const TextStyle(
                    //     fontSize: 17.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    SizedBox(
                      height: 800,
                      child: ListView.builder(
                        itemCount: book.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index == 0
                                    ? Row(
                                        children: <Widget>[
                                          Text(
                                            index == 0
                                                ? '${book[index].chapter}'
                                                : '',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 50.0,
                                              fontWeight: FontWeight.normal,
                                              color: themeData?.primaryColor,
                                            ),
                                          ),
                                          Text(
                                            '${index + 1} ',
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Color.fromARGB(
                                                  255, 146, 45, 38),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${book[index].verseText}',
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                                if (index != 0)
                                  RichText(
                                    text: TextSpan(
                                      text: '${index + 1} ',
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 146, 45, 38),
                                      ),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: '${book[index].verseText}',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                book[index].para == "q1" ||
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
