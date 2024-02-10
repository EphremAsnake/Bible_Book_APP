import 'package:bible_book_app/app/core/cache/shared_pereferance_storage.dart';
import 'package:bible_book_app/app/core/shared_controllers/data_getter_and_setter_controller.dart';
import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/data/models/bible/book.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:bible_book_app/app/modules/detail/views/amharic_keyboard.dart';
import 'package:bible_book_app/app/utils/keys/keys.dart';
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
  String selectedBook = "አማርኛ 1954";
  bool isAmharicKeyboardVisible = true;
  String selectedSearchTypeOptions = 'every_word'.tr;
  String selectedSearchPlaceOptions = 'all'.tr;
  String selectedBookTypeOptions = 'አማርኛ 1954';
  List<Verses> searchResultVerses = [];
  List<Book> books = [];
  List<Book> booksList = [];
  bool hidePageNavigators = false;
  int previousOpenedBookPageNumber = 0;
  int currentPageNumber = 0;
  ScrollController readerScrollController = ScrollController();
  ScrollController drawerScrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PageController? pageController;
  final GlobalKey pageKey = GlobalKey();

  List<String> searchPlaceOptions = [
    'ot'.tr,
    'nt'.tr,
    'all'.tr,
  ];

  List<String> searchTypeOptions = [
    'every_word'.tr,
    'exactly'.tr,
  ];

  List<String> bookTypeOptions = [
    'አማርኛ 1954',
    'አዲሱ መደበኛ ትርጉም',
    'English NIV',
    'English KJV'
  ];

  @override
  void onInit() {
    super.onInit();
    loadData();
    getPreviousPageNumber();
    allVerses.addAll(getterAndSetterController.groupedBookList());
    setInitialSelectedBookTypeOptions();
    getBooks();
    readerScrollController.addListener(() {
      // Check if the scroll controller is actively scrolling
      hidePageNavigators =
          readerScrollController.position.activity?.isScrolling ?? false;
    });
    loadInitialPage();
    update();
  }

  Future<void> loadInitialPage() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    int? pageNo =
        await sharedPreferencesStorage.readIntData(Keys.previousPageNumber);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageNo != null) {
        // Check if the widget is still mounted before creating PageController
        if (Get.isRegistered<DetailController>()) {
          if (pageController == null || !pageController!.hasClients) {
            pageController = PageController(initialPage: pageNo);
            update();
          } else {
            // If the controller already has clients, use animateToPage to navigate
            pageController!.animateToPage(pageNo,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          }
        }
      } else {
        if (Get.isRegistered<DetailController>()) {
          if (pageController == null || !pageController!.hasClients) {
            pageController = PageController(initialPage: 0);
            update();
          } else {
            // If the controller already has clients, use animateToPage to navigate
            pageController!.animateToPage(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          }
        }
      }
    });
  }

  setInitialSelectedBookTypeOptions() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    String? bookName =
        await sharedPreferencesStorage.readStringData(Keys.selectedBookKey);
    if (bookName != null) {
      selectedBookTypeOptions = bookName;
    }
  }

  setPreviousPageNumber(int pageNumber) async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    await sharedPreferencesStorage.saveIntData(
        Keys.previousPageNumber, pageNumber);
  }

  getPreviousPageNumber() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    int? pageNo =
        await sharedPreferencesStorage.readIntData(Keys.previousPageNumber);
    if (pageNo != null) {
      previousOpenedBookPageNumber = pageNo;
    }
    update();
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

  setSelectedBook(String selectedBookName) {
    selectedBook = selectedBookName;
    update();
  }

  getSelectedBookName() async {
    SharedPreferencesStorage sharedPreferencesStorage =
        SharedPreferencesStorage();
    String? bookName =
        await sharedPreferencesStorage.readStringData(Keys.selectedBookKey);
    if (bookName != null) {
      selectedBook = bookName;
    }

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

  setSelectedBookTypeOptions(String newValue) {
    selectedBookTypeOptions = newValue;
    update();
  }

  Future<List<Verses>> search({
    required String BibleType,
    required String searchType,
    required String searchPlace,
    required String query,
  }) async {
    List<Verses> emptyVerses = [];
    if (searchType == 'every_word'.tr) {
      if (searchPlace == 'ot'.tr) {
        return await handleSearch("OT", query, 'contains', BibleType);
      } else if (searchPlace == 'nt'.tr) {
        return await handleSearch("NT", query, 'contains', BibleType);
      } else if (searchPlace == 'all'.tr) {
        return await handleSearch("", query, 'contains', BibleType);
      } else {
        return emptyVerses;
      }
    } else if (searchType == 'exactly'.tr) {
      if (searchPlace == 'ot'.tr) {
        return await handleSearch("OT", query, 'exact', BibleType);
      } else if (searchPlace == 'nt'.tr) {
        return await handleSearch("NT", query, 'exact', BibleType);
      } else if (searchPlace == 'all'.tr) {
        return await handleSearch("", query, 'exact', BibleType);
      } else {
        return emptyVerses;
      }
    } else {
      return emptyVerses;
    }
  }

  Future<List<Verses>> handleSearch(
    String testament,
    String query,
    String searchOption,
    String BibleType,
  ) async {
    if (BibleType == 'አማርኛ 1954') {
      BibleType = "AMHKJV";
    } else if (BibleType == 'አዲሱ መደበኛ ትርጉም') {
      BibleType = "AMHNIV";
    } else if (BibleType == 'English NIV') {
      BibleType = "ENGNIV";
    } else if (BibleType == 'English KJV') {
      BibleType = "ENGKJV";
    }
    List<Verses> verses = await DatabaseService().changeBibleType(BibleType);
    List<Book> oldTestamentBookIDs = [];
    List<Verses> oldTestamentBookVerses = [];
    books = await DatabaseService().readBookDatabase();

    if (testament != "") {
      oldTestamentBookIDs =
          books.where((element) => element.testament == testament).toList();
    } else {
      oldTestamentBookIDs = books;
    }
    for (int i = 0; i < oldTestamentBookIDs.length; i++) {
      //check
      List<Verses> oldTestamentBookVerseTemp = verses
          .where((element) => element.book == oldTestamentBookIDs[i].id)
          .toList();
      oldTestamentBookVerses.addAll(oldTestamentBookVerseTemp);
    }
    if (searchOption == "contains") {
      oldTestamentBookVerses = oldTestamentBookVerses
          .where((verse) => verse.verseText!.contains(query))
          .toList();
      return oldTestamentBookVerses;
    } else if (searchOption == 'exact') {
      List<Verses> searchResults = [];
      for (Verses item in oldTestamentBookVerses) {
        List<String> words = item.verseText!.split(" ");
        if (words.contains(query)) {
          searchResults.add(item);
        }
      }
      return searchResults;
    } else {
      List<Verses> emptyVerses = [];
      return emptyVerses;
    }
  }

  getBookName(int bookId) {
    return books.where((element) => element.id == bookId).first.titleGeez;
  }

  clearSearchBar() {
    searchController.clear();
    update();
  }

  getBooks() async {
    booksList = await DatabaseService().readBookDatabase();
    update();
  }

  getBookTitle(int bookId) {
    if (booksList.isNotEmpty) {
      if (selectedBook.contains("English")) {
        return booksList.where((element) => element.id == bookId).first.title;
      } else {
        return booksList
            .where((element) => element.id == bookId)
            .first
            .titleGeez;
      }
    }
  }

  navigateToSpecificBookDetailView(int bookId, int chapterId) {
    int indexOfBook = 0;
    for (int i = 0; i < allVerses.length; i++) {
      indexOfBook = allVerses[i].indexWhere(
          (element) => element.book == bookId && element.chapter == chapterId);
      if (indexOfBook != -1) {
        indexOfBook = i;
        break;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (indexOfBook != -1) {
        // Check if the widget is still mounted before creating PageController
        if (Get.isRegistered<DetailController>()) {
          if (pageController == null || !pageController!.hasClients) {
            pageController = PageController(initialPage: indexOfBook);
            update();
          } else {
            // If the controller already has clients, use animateToPage to navigate
            pageController!.animateToPage(indexOfBook,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
            scaffoldKey.currentState?.closeDrawer();
            scaffoldKey.currentState?.closeEndDrawer();
            readerScrollController.animateTo(
              0.0, // Scroll to the top
              duration: const Duration(
                  milliseconds: 500), // Adjust the duration as needed
              curve: Curves.easeInOut, // Use a different curve if desired
            );
          }
        }
      }
    });
    return indexOfBook;
  }

  void detachScrollController() {
    readerScrollController = ScrollController();
  }
}
