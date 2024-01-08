import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final DataGetterAndSetter getterAndSetterController =
      Get.find<DataGetterAndSetter>();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }


  Future<String> loadBook(String fileName) async {
    return await rootBundle.loadString('assets/books/exodus/$fileName');
  }

  loadData() async {
    getterAndSetterController.readData();
  }
}
