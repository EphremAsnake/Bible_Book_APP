import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
import 'package:bible_book_app/app/data/models/text_viewer/text_viewer.dart';
import 'package:bible_book_app/app/utils/helpers/text_viewer/text_viewer_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  DetailView({Key? key}) : super(key: key);
  final themeData = Get.find<ThemeController>().themeData.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: TextViewerPage(
            textViewer: TextViewer.asset(
              'assets/books/exodus/exodus.1.txt',
              highLightColor: Colors.yellow,
              focusColor: themeData!.primaryColor.withOpacity(0.7),
              ignoreCase: true,
            ),
            showSearchAppBar: true,
          ),
        ));
  }
}
