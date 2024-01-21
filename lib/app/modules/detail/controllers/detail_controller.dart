import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
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

  makeAmharicKeyboardVisible(){
    isAmharicKeyboardVisible = true;
    update();
  }

  makeAmharicKeyboardInVisible(){
    isAmharicKeyboardVisible = false;
    update();
  }
}
