import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/data/models/bible/book.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:bible_book_app/app/modules/detail/views/amharic_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final DataGetterAndSetter getterAndSetterController =
      Get.find<DataGetterAndSetter>();
  List<List<Verses>> allVerses = [];
  AmharicLetter? selectedAmharicLetter;
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  bool isAmharicKeyboardVisible = true;
  String selectedSearchTypeOptions = 'ሁሉንም ቃላት';
  String selectedSearchPlaceOptions = 'ብሉይ ኪዳን';
  List<Verses> searchResultVerses = [];

  List<String> searchPlaceOptions = [
    'ብሉይ ኪዳን',
    'አዲስ ኪዳን',
    'በሁሉም',
  ];

  List<String> searchTypeOptions = [
    'ሁሉንም ቃላት',
    'እንቅጩን',
  ];

  @override
  void onInit() {
    super.onInit();
    loadData();
    allVerses = getterAndSetterController.groupedBookList();
  }

  Future<String> loadBook(String fileName) async {
    return await rootBundle.loadString('assets/books/exodus/$fileName');
  }

  loadData() async {
    getterAndSetterController.readData();
  }

  setSelectedAmharicLetter(AmharicLetter selectedAmharicLetterType) {
    selectedAmharicLetter = selectedAmharicLetterType;
    update();
  }

  void onKeyPressed(String keyContent) {
    final currentValue = searchController.text;
    final newValue = currentValue + keyContent;
    searchController.text = newValue;
    update();
  }

  void onBackSpaceKeyPressed() {
    final currentValue = searchController.text;
    List<String> oldValue = currentValue.split('');
    if (oldValue.isNotEmpty) {
      oldValue.removeAt(oldValue.length - 1);
      searchController.text = oldValue.join('');
      update();
    }
  }

  makeAmharicKeyboardVisible() {
    isAmharicKeyboardVisible = true;
    update();
  }

  makeAmharicKeyboardInVisible() {
    isAmharicKeyboardVisible = false;
    update();
  }

  setSelectedSearchPlaceOptions(String newValue) {
    selectedSearchPlaceOptions = newValue;
    update();
  }

  setSelectedSearchTypeOptions(String newValue) {
    selectedSearchTypeOptions = newValue;
    update();
  }

  Future<List<Verses>> search({
    required String BibleType,
    required String searchType,
    required String searchPlace,
    required String query,
  }) async {
    List<Verses> emptyVerses = [];
    if (searchType == 'ሁሉንም ቃላት') {
      if (searchPlace == 'ብሉይ ኪዳን') {
        return await handleSearch("OT", query, 'contains', BibleType);
      } else if (searchPlace == 'አዲስ ኪዳን') {
        return await handleSearch("NT", query, 'contains', BibleType);
      } else if (searchPlace == 'በሁሉም') {
        return await handleSearch("", query, 'contains', BibleType);
      } else {
        return emptyVerses;
      }
    } else if (searchType == 'እንቅጩን') {
      if (searchPlace == 'ብሉይ ኪዳን') {
        return await handleSearch("OT", query, 'exact', BibleType);
      } else if (searchPlace == 'አዲስ ኪዳን') {
        return await handleSearch("NT", query, 'exact', BibleType);
      } else if (searchPlace == 'በሁሉም') {
        return await handleSearch("", query, 'exact', BibleType);
      } else {
        return emptyVerses;
      }
    } else {
      return emptyVerses;
    }
  }
}

Future<List<Verses>> handleSearch(
  String testament,
  String query,
  String searchOption,
  String BibleType,
) async {
  List<Verses> verses = await DatabaseService().changeBibleType(BibleType);
  List<Book> oldTestamentBookIDs = [];
  List<Verses> oldTestamentBookVerses = [];
  List<Book> books = await DatabaseService().readBookDatabase();

  if (testament != "") {
    oldTestamentBookIDs =
        books.where((element) => element.testament == testament).toList();
  } else {
    oldTestamentBookIDs = books;
  }
  for (int i = 0; i < oldTestamentBookIDs.length; i++) {
    //check 
    oldTestamentBookVerses = verses
        .where((element) => element.book == oldTestamentBookIDs[i].id)
        .toList();
        
  }
  if (searchOption == "contains") {
    oldTestamentBookVerses
        .where((verse) => RegExp(r'\b' + RegExp.escape(query) + r'\b')
            .hasMatch(verse.verseText!))
        .toList();
    return oldTestamentBookVerses;
  } else if (searchOption == 'exact') {
    oldTestamentBookVerses
        .where((element) => element.verseText! == query)
        .toList();
    return oldTestamentBookVerses;
  } else {
    List<Verses> emptyVerses = [];
    return emptyVerses;
  }
}

List<String> searchItems(List<String> items, String searchTerm) {
  List<String> searchResults = [];

  for (String item in items) {
    RegExp regex = RegExp(r'\b' + searchTerm + r'\b');
    if (regex.hasMatch(item)) {
      searchResults.add(item);
    }
  }

  return searchResults;
}
