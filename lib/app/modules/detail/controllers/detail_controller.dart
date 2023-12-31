import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
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

  getAMHBookChapters(
    int book,
    List<VersesAMH> versesAMH,
  ) {

    List<VersesAMH> bookContents =
        versesAMH.where((element) => element.book == book).toList();
  
  }
}
