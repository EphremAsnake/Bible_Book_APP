import 'package:bible_book_app/app/core/http_client/http_service.dart';
import 'package:bible_book_app/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:bible_book_app/app/core/shared_controllers/database_service.dart';
import 'package:bible_book_app/app/data/models/bible/book.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:bible_book_app/app/utils/helpers/api_state_handler.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

class DataGetterAndSetter extends GetxController {
  int selectedIndex = -1;
  int selectedOldTestamentBookIndex = -1;
  int selectedNewTestamentBookIndex = -1;
  final cacheStateHandler = ApiStateHandler<List<Book>>();
  var httpService = Get.find<HttpService>();
  List<Book> oldTestamentBook = [];
  List<Book> newTestamentBook = [];
  List<Verses> versesAMH = [];
  List<Verses> selectedVersesAMH = [];
  List<Verses> verseAMHListForBook = [];

  getAMHBookChapters(
    int book,
    int chapter,
    List<Verses> versesAMH,
  ) {
    List<Verses> verseAMHForBook = versesAMH
        .where((element) => element.book == book && element.chapter == chapter)
        .toList();
    List<Verses> verseTitle = versesAMH
        .where((element) =>
            element.book == book &&
            element.chapter == chapter - 1 &&
            element.para == "mt1")
        .toList();
    List<Verses> verseAMHListForBookList = [
      ...verseAMHForBook,
      ...verseTitle
    ];
    verseAMHListForBook.addAll(verseAMHListForBookList);
    return verseAMHListForBook;
  }

  getNextBookChapter(
    int book,
    int chapter,
    int index,
  ) {
    Verses nextVerseForBook = selectedVersesAMH[index + 1];
    return nextVerseForBook;
  }

  getPreviousBookChapter(
    int book,
    int chapter,
    int index,
  ) {
    Verses previousVerseForBook = selectedVersesAMH[index - 1];
    return previousVerseForBook;
  }

  groupedBookList() {
    versesAMH.removeWhere((e) => e.para == "mt1");
    var groupedVerses = groupBy(
        versesAMH, (Verses verse) => '${verse.book}-${verse.chapter}');
    List<List<Verses>> groupedVerseList = groupedVerses.values.toList();
    return groupedVerseList;
  }

  Future<void> readData() async {
    cacheStateHandler.setLoading();
    await DatabaseService().copyDatabase();
    List<Book> books = await DatabaseService().readBookDatabase();
    var amh = await DatabaseService().readVersesAMHDatabase();
    versesAMH.addAll(amh);
   
    try {
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
}
