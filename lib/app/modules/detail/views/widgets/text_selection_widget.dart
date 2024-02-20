import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:bible_book_app/app/modules/detail/views/widgets/highlight_color.dart';
import 'package:bible_book_app/app/modules/home/views/widgets/exit_confirmation_dialogue.dart';
import 'package:bible_book_app/app/utils/helpers/get_and_set_highlight_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

void textSelectionOptions(
    BuildContext context, int id, String tableName, Verses? verse) {
  final DetailController detailController = Get.find<DetailController>();
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25))),
    context: context,
    builder: (BuildContext context) {
      return GetBuilder<DetailController>(
        init: DetailController(),
        initState: (_) {},
        builder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    "Text Selection Options",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: themeData?.grayTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 5),
                  child: Divider(
                    color: themeData?.grayTextColor.withOpacity(0.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Text(
                    "Basic Options",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: themeData?.grayTextColor,
                        fontWeight: FontWeight.bold),
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
                              await share(
                                  "test share", "test subject", context);
                            },
                            icon: const Icon(Icons.share)),
                        const Text("Share")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              copyToClipboard('Text to Copy');
                            },
                            icon: const Icon(Icons.copy)),
                        const Text("Copy")
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10,bottom: 10),
                  child: Text(
                    "Highlight Options",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: themeData?.grayTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
                          int color =
                              setHighlightColor(HighlightColors.highlightGreen);
                          await DatabaseService()
                              .updateHighlight(id, color, tableName);
                          detailController.isRowSelected = false;
                          verse?.highlight = color;
                          detailController.update();
                        },
                        child: const CircleAvatar(
                          backgroundColor: HighlightColors.highlightGreen,
                           radius: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color = setHighlightColor(
                              HighlightColors.highlightYellow);
                          await DatabaseService()
                              .updateHighlight(id, color, tableName);
                          detailController.isRowSelected = false;
                          verse?.highlight = color;
                          detailController.update();
                        },
                        child: const CircleAvatar(
                          backgroundColor: HighlightColors.highlightYellow,
                           radius: 25,
                        ),
                      ),
                       const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color = setHighlightColor(
                              HighlightColors.highlightOrange);
                          await DatabaseService()
                              .updateHighlight(id, color, tableName);
                          detailController.isRowSelected = false;
                          verse?.highlight = color;
                          detailController.update();
                        },
                        child: const CircleAvatar(
                          backgroundColor: HighlightColors.highlightOrange,
                           radius: 25,
                        ),
                      ),
                       const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color =
                              setHighlightColor(HighlightColors.highlightRed);
                          await DatabaseService()
                              .updateHighlight(id, color, tableName);
                          detailController.isRowSelected = false;
                          verse?.highlight = color;
                          detailController.update();
                        },
                        child: const CircleAvatar(
                          backgroundColor: HighlightColors.highlightRed,
                           radius: 25,
                        ),
                      ),
                       const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color =
                              setHighlightColor(HighlightColors.highlightBlue);
                          await DatabaseService()
                              .updateHighlight(id, color, tableName);
                          detailController.isRowSelected = false;
                          verse?.highlight = color;
                          detailController.update();
                        },
                        child: const CircleAvatar(
                          backgroundColor: HighlightColors.highlightBlue,
                           radius: 25,
                        ),
                      ),
                       const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          int color =
                              setHighlightColor(HighlightColors.highlightPink);
                          await DatabaseService()
                              .updateHighlight(id, color, tableName);
                          detailController.isRowSelected = false;
                          verse?.highlight = color;
                          detailController.update();
                        },
                        child: const CircleAvatar(
                          backgroundColor: HighlightColors.highlightPink,
                          radius: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
}

Future<void> share(String text, String subject, BuildContext context) async {
  final box = context.findRenderObject() as RenderBox?;
  await Share.share(
    text,
    subject: subject,
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
}
