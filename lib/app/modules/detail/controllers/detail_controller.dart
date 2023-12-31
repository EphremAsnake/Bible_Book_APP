import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<String> loadBook(String fileName) async {
    return await rootBundle.loadString('assets/books/exodus/$fileName');
  }
}
