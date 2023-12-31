import 'dart:io';
import 'package:bible_book_app/app/data/models/bible/book.dart';
import 'package:bible_book_app/app/data/models/bible/versesAMH.dart';
import 'package:bible_book_app/app/data/models/bible/versesNIV.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Future<void> copyDatabase() async {
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.sqlite');

    // Check if the database file already exists
    bool exists = await databaseExists(path);

    if (!exists) {
      // Create the parent directory if it doesn't exist
      await Directory(dirname(path)).create(recursive: true);

      // Copy the database file from assets to the device
      ByteData data = await rootBundle.load('assets/db/bible.sqlite');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }
  }

  Future<List<Book>> readBookDatabase() async {
    List<Book> books = [];
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.sqlite');

    // Open the database
    Database database = await openDatabase(path);

    // Query the database
    List<Map<String, dynamic>> rows =
        await database.rawQuery('SELECT * FROM books');

    // Process the retrieved data
    for (Map<String, dynamic> row in rows) {
      final book = Book(
        chapters: row["chapters"],
        id: row["_id"],
        name: row["name"],
        nameGeez: row["nameGeez"],
        testament: row["testament"],
        title: row["title"],
        titleGeez: row["titleGeez"],
        titleGeezShort: row["titleGeezShort"],
      );

      books.add(book);
    }

    // Close the database
    await database.close();

    //return result
    return books;
  }

  Future<List<VersesAMH>> readVersesAMHDatabase() async {
    List<VersesAMH> versesAMH = [];
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.sqlite');

    // Open the database
    Database database = await openDatabase(path);

    // Query the database
    List<Map<String, dynamic>> rows =
        await database.rawQuery('SELECT * FROM versesAMH');

    // Process the retrieved data
    for (Map<String, dynamic> row in rows) {
      final verseAMH = VersesAMH(
        book: row["book"],
        chapter: row["chapter"],
        para: row["para"],
        verseLocation: row["verseLocation"],
        verseNumber: row["verseNumber"],
        verseText: row["verseText"],
      );

      versesAMH.add(verseAMH);
    }

    // Close the database
    await database.close();

    //return result
    return versesAMH;
  }

  Future<List<VersesNIV>> readVersesNIVDatabase() async {
    List<VersesNIV> versesNIV = [];
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bible.sqlite');

    // Open the database
    Database database = await openDatabase(path);

    // Query the database
    List<Map<String, dynamic>> rows =
        await database.rawQuery('SELECT * FROM versesNIV');

    // Process the retrieved data
    for (Map<String, dynamic> row in rows) {
      final verseNIV = VersesNIV(
        book: row["book"],
        chapter: row["chapter"],
        para: row["para"],
        verseLocation: row["verseLocation"],
        verseNumber: row["verseNumber"],
        verseText: row["verseText"],
      );

      versesNIV.add(verseNIV);
    }

    // Close the database
    await database.close();

    //return result
    return versesNIV;
  }
}
