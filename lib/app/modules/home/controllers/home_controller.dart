import 'dart:convert';

import 'package:bible_book_app/app/core/http_client/http_service.dart';
import 'package:bible_book_app/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:bible_book_app/app/core/shared_controllers/master_data_http_attribuites.dart';
import 'package:bible_book_app/app/data/models/bible/bible.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndex = -1;
  int selectedOldTestamentBookIndex = -1;
  int selectedNewTestamentBookIndex = -1;
  final cacheStateHandler = ApiStateHandler<List<Bible>>();
  var httpService = Get.find<HttpService>();
  List<Book> oldTestamentBook = [];
  List<Book> newTestamentBook = [];

  @override
  void onInit() {
    readBibleData();
    super.onInit();
  }

  get rootBundle => null;

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
    final file = await rootBundle.loadString('assets/bible_list.json');
    await file.writeAsString(jsonString);
  }

  void readBibleData() async {
    cacheStateHandler.setLoading();
    try {
      final String jsonString =
          await rootBundle.loadString('assets/bible_list.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> bibleList = jsonData['bibles'];
      // Map each JSON object to a Bible model
      final List<Bible> bibles =
          bibleList.map((json) => Bible.fromJson(json)).toList();
      for(int i = 0; i < bibles.length; i++) {
        if(bibles[i].bibles[0].versions[0].books[0].testament == Testament.OLD){
          oldTestamentBook.add(bibles[i].bibles[0].versions[0].books[0]);
        }
        else if(bibles[i].bibles[0].versions[0].books[0].testament == Testament.NEW){
          newTestamentBook.add(bibles[i].bibles[0].versions[0].books[0]);
        }
      
      }
      cacheStateHandler.setSuccess(bibles);
      update();
    } catch (ex) {
      // Update state with error message
      String errorMessage = await HandleHttpException().getExceptionString(ex);
      cacheStateHandler.setError(errorMessage);
      update();
    }
  }
}
