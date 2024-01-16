import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final DataGetterAndSetter getterAndSetterController =
      Get.find<DataGetterAndSetter>();
  List<List<Verses>> allVerses = [];
  @override
  void onInit() {
    super.onInit();
    loadData();
    allVerses = getterAndSetterController.groupedBookList();
  }

  @override
  Future<String> loadBook(String fileName) async {
    return await rootBundle.loadString('assets/books/exodus/$fileName');
  }

  loadData() async {
    getterAndSetterController.readData();
  }
}
