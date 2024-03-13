import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:bible_book_app/app/modules/detail/views/widgets/highlight_color.dart';
import 'package:bible_book_app/app/modules/home/views/widgets/exit_confirmation_dialogue.dart';
import 'package:bible_book_app/app/utils/helpers/get_and_set_highlight_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

Widget textSelectionOptions(BuildContext context, List<Verses> selectedVerses,
    Verses? verse, int index) {
  final DetailController detailController = Get.find<DetailController>();
  final themeData = Get.find<ThemeController>().themeData.value;
  return GetBuilder<DetailController>(
    init: DetailController(),
    initState: (_) {},
    builder: (_) {
      return Container(
        padding: const EdgeInsets.only(bottom: 5, top: 15, left: 5, right: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (verse?.highlight != 0) {
                        for (int i = 0;
                            i < detailController.selectedVerses.length;
                            i++) {
                          await DatabaseService().updateHighlight(
                              selectedVerses[i].book!,
                              selectedVerses[i].chapter!,
                              selectedVerses[i].verseNumber,
                              0,
                              detailController.selectedBook);
                        }
                        detailController.selectedRowIndex = [];
                        detailController.selectedVerses = [];
                        detailController.showSelectionMenu = false;
                        verse?.highlight = 0;
                        detailController.update();
                      } else {
                        detailController.selectedRowIndex = [];
                        detailController.selectedVerses = [];
                        detailController.showSelectionMenu = false;
                        detailController.update();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 201, 200, 200),
                          radius: 20,
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                      onTap: () async {
                        int color =
                            setHighlightColor(HighlightColors.highlightGreen);
                        for (int i = 0;
                            i < detailController.selectedVerses.length;
                            i++) {
                          await DatabaseService().updateHighlight(
                              selectedVerses[i].book!,
                              selectedVerses[i].chapter!,
                              selectedVerses[i].verseNumber,
                              color,
                              detailController.selectedBook);
                          selectedVerses[i].highlight = color;
                        }
                        detailController.update();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey, // Set the color of the border
                            width: 1.0, // Set the width of the border
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundColor: HighlightColors.highlightGreen,
                          radius: 20,
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int color =
                          setHighlightColor(HighlightColors.highlightYellow);
                      for (int i = 0;
                          i < detailController.selectedVerses.length;
                          i++) {
                        await DatabaseService().updateHighlight(
                            selectedVerses[i].book!,
                            selectedVerses[i].chapter!,
                            selectedVerses[i].verseNumber,
                            color,
                            detailController.selectedBook);
                        selectedVerses[i].highlight = color;
                      }
                      detailController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: HighlightColors.highlightYellow,
                        radius: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int color =
                          setHighlightColor(HighlightColors.highlightOrange);
                      for (int i = 0;
                          i < detailController.selectedVerses.length;
                          i++) {
                        await DatabaseService().updateHighlight(
                            selectedVerses[i].book!,
                            selectedVerses[i].chapter!,
                            selectedVerses[i].verseNumber,
                            color,
                            detailController.selectedBook);
                        selectedVerses[i].highlight = color;
                      }

                      detailController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: HighlightColors.highlightOrange,
                        radius: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int color =
                          setHighlightColor(HighlightColors.highlightRed);
                      for (int i = 0;
                          i < detailController.selectedVerses.length;
                          i++) {
                        await DatabaseService().updateHighlight(
                            selectedVerses[i].book!,
                            selectedVerses[i].chapter!,
                            selectedVerses[i].verseNumber,
                            color,
                            detailController.selectedBook);
                        selectedVerses[i].highlight = color;
                      }

                      detailController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: HighlightColors.highlightRed,
                        radius: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int color =
                          setHighlightColor(HighlightColors.highlightBlue);
                      for (int i = 0;
                          i < detailController.selectedVerses.length;
                          i++) {
                        await DatabaseService().updateHighlight(
                            selectedVerses[i].book!,
                            selectedVerses[i].chapter!,
                            selectedVerses[i].verseNumber,
                            color,
                            detailController.selectedBook);
                        selectedVerses[i].highlight = color;
                      }

                      detailController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: HighlightColors.highlightBlue,
                        radius: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int color =
                          setHighlightColor(HighlightColors.highlightPink);
                      for (int i = 0;
                          i < detailController.selectedVerses.length;
                          i++) {
                        await DatabaseService().updateHighlight(
                            selectedVerses[i].book!,
                            selectedVerses[i].chapter!,
                            selectedVerses[i].verseNumber,
                            color,
                            detailController.selectedBook);
                        selectedVerses[i].highlight = color;
                      }

                      detailController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: HighlightColors.highlightPink,
                        radius: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int color =
                          setHighlightColor(HighlightColors.highlightDarkGreen);
                      for (int i = 0;
                          i < detailController.selectedVerses.length;
                          i++) {
                        await DatabaseService().updateHighlight(
                            selectedVerses[i].book!,
                            selectedVerses[i].chapter!,
                            selectedVerses[i].verseNumber,
                            color,
                            detailController.selectedBook);
                        selectedVerses[i].highlight = color;
                      }

                      detailController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: HighlightColors.highlightDarkGreen,
                        radius: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int color = setHighlightColor(
                          HighlightColors.highlightDarkYellow);
                      for (int i = 0;
                          i < detailController.selectedVerses.length;
                          i++) {
                        await DatabaseService().updateHighlight(
                            selectedVerses[i].book!,
                            selectedVerses[i].chapter!,
                            selectedVerses[i].verseNumber,
                            color,
                            detailController.selectedBook);
                        selectedVerses[i].highlight = color;
                      }

                      detailController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: HighlightColors.highlightDarkYellow,
                        radius: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int color =
                          setHighlightColor(HighlightColors.highlightDarkTeal);
                      for (int i = 0;
                          i < detailController.selectedVerses.length;
                          i++) {
                        await DatabaseService().updateHighlight(
                            selectedVerses[i].book!,
                            selectedVerses[i].chapter!,
                            selectedVerses[i].verseNumber,
                            color,
                            detailController.selectedBook);
                        selectedVerses[i].highlight = color;
                      }

                      detailController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: HighlightColors.highlightDarkTeal,
                        radius: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int color =
                          setHighlightColor(HighlightColors.highlightBrown);
                      for (int i = 0;
                          i < detailController.selectedVerses.length;
                          i++) {
                        await DatabaseService().updateHighlight(
                            selectedVerses[i].book!,
                            selectedVerses[i].chapter!,
                            selectedVerses[i].verseNumber,
                            color,
                            detailController.selectedBook);
                        selectedVerses[i].highlight = color;
                      }

                      detailController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: HighlightColors.highlightBrown,
                        radius: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int color =
                          setHighlightColor(HighlightColors.highlightLightRed);
                      for (int i = 0;
                          i < detailController.selectedVerses.length;
                          i++) {
                        await DatabaseService().updateHighlight(
                            selectedVerses[i].book!,
                            selectedVerses[i].chapter!,
                            selectedVerses[i].verseNumber,
                            color,
                            detailController.selectedBook);
                        selectedVerses[i].highlight = color;
                      }

                      detailController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: HighlightColors.highlightLightRed,
                        radius: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 1),
              child: Divider(
                color: themeData!.grayTextColor.withOpacity(0.5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          String textToCopy = "";
                          if (detailController.selectedBook
                              .contains("English")) {
                            textToCopy =
                                "\"${verse!.verseText!}\" — ${detailController.getBookTitle(verse.book!)} ${verse.chapter}:${verse.verseNumber}";
                          } else {
                            textToCopy =
                                "\"${verse!.verseText!}\" — ${detailController.getBookTitle(verse.book!)} ${verse.chapter}፥${verse.verseNumber}";
                          }
                          await share(textToCopy, "Share", context);
                        },
                        icon: Icon(
                          Icons.share,
                          color: themeData.verseColor,
                        )),
                    Text(
                      "Share",
                      style: TextStyle(color: themeData.verseColor),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          String textToCopy = "";
                          if (detailController.selectedBook
                              .contains("English")) {
                            textToCopy =
                                "\"${verse!.verseText!}\" — ${detailController.getBookTitle(verse.book!)} ${verse.chapter}:${verse.verseNumber}";
                          } else {
                            textToCopy =
                                "\"${verse!.verseText!}\" — ${detailController.getBookTitle(verse.book!)} ${verse.chapter}፥${verse.verseNumber}";
                          }

                          copyToClipboard(textToCopy);
                        },
                        icon: Icon(
                          Icons.copy,
                          color: themeData.verseColor,
                        )),
                    Text(
                      "Copy",
                      style: TextStyle(color: themeData.verseColor),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    },
  );
}

void copyToClipboard(String text) {
  final DetailController detailController = Get.find<DetailController>();
  Clipboard.setData(ClipboardData(text: text));
  Fluttertoast.showToast(
      msg: "Copied!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: themeData?.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
  detailController.selectedRowIndex = [];
  detailController.update();
  Get.back();
}

Future<void> share(String text, String subject, BuildContext context) async {
  final DetailController detailController = Get.find<DetailController>();
  final box = context.findRenderObject() as RenderBox?;
  await Share.share(
    text,
    subject: subject,
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
  detailController.selectedRowIndex = [];
  detailController.update();
  Get.back();
}
