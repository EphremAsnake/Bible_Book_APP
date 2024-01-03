import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/theme_controller.dart';
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
    List<String> books = [
      getterAndSetterController.selectedVersesAMH[0].para!,
      getterAndSetterController.selectedVersesAMH[1].para!,
      getterAndSetterController.selectedVersesAMH[2].para!,
      getterAndSetterController.selectedVersesAMH[3].para!,
    ];
    return Scaffold(
      body: SafeArea(
        child: PageFlipWidget(
          key: _controller,
          backgroundColor: Colors.white,
          lastPage: Container(
              color: Colors.white,
              child: const Center(child: Text('Last Page!'))),
          children: books.map<Widget>(
            (book) {
              return FutureBuilder(
                future: controller.loadBook(book),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
