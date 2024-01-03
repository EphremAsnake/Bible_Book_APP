import 'dart:convert';
import 'dart:io';
import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/data/models/bible/book.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:flutter/services.dart';
import 'package:bible_book_app/app/core/http_client/http_service.dart';
import 'package:bible_book_app/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:bible_book_app/app/core/shared_controllers/master_data_http_attribuites.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndex = -1;
  int selectedOldTestamentBookIndex = -1;
  int selectedNewTestamentBookIndex = -1;
  final cacheStateHandler = ApiStateHandler<List<Book>>();
  var httpService = Get.find<HttpService>();
  List<Book> oldTestamentBook = [];
  List<Book> newTestamentBook = [];
  List<VersesAMH> versesAMH = [];
  List<VersesAMH> selectedVersesAMH = [];

  @override
  void onInit() {
    readBibleData();

    super.onInit();
  }

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  void updateOldTestamentSelectedBookIndex(int index) {
    selectedOldTestamentBookIndex = index;
    selectedNewTestamentBookIndex = -1;
    update();
  }

  void updateNewTestamentSelectedBookIndex(int index) {
    selectedNewTestamentBookIndex = index;
    selectedOldTestamentBookIndex = -1;
    update();
  }

  Future<void> updateJsonFile() async {
    try {
      dynamic response =
          await httpService.sendHttpRequest(MasterDataHttpAttributes());

      if (response.statusCode == 200) {
        // Decode the JSON response
        final jsonData = jsonDecode(response.body);

        // Convert the JSON data to a string
        final jsonString = jsonEncode(jsonData);
        // Write the JSON string to the asset file
        await writeJsonToFile(jsonString);
      } else {}
    } catch (ex) {
      HandleHttpException().getExceptionString(ex);
    }
  }

  Future<void> writeJsonToFile(String jsonString) async {
    final file = File('assets/bible_list.json');
    await file.writeAsString(jsonString);
  }

  void readBibleData() async {
    cacheStateHandler.setLoading();
    await DatabaseService().copyDatabase();
    List<Book> books = await DatabaseService().readBookDatabase();
    var amh = await DatabaseService().readVersesAMHDatabase();
    var niv = await DatabaseService().readVersesNIVDatabase();
    versesAMH.addAll(amh);

    try {
      // final String jsonString =
      //     await rootBundle.loadString('assets/bible_list.json');
      // final Map
      //
      //
      //
      //
      //
      //String, dynamic> jsonData = jsonDecode(jsonString);
      // final Bible bibles = Bible.fromJson(jsonData);

      //default iterating over the list of bible index 0 nd version index of 0
      for (int k = 0; k < books.length; k++) {
        if (books[k].testament == "OT") {
          oldTestamentBook.add(books[k]);
        } else if (books[k].testament == "NT") {
          newTestamentBook.add(books[k]);
        }
      }
      cacheStateHandler.setSuccess(books);
      update();
    } catch (ex) {
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      cacheStateHandler.setError(errorMessage);
      update();
    }
  }

  getAMHBookChapters(
    int book,
    int chapter,
    List<VersesAMH> versesAMH,
  ) {
    List<VersesAMH> verseAMHForBook = versesAMH
        .where((element) => element.book == book && element.chapter == chapter)
        .toList();
    return verseAMHForBook;
  }
}
