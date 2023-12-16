import 'dart:convert';

Bible bibleFromJson(String str) => Bible.fromJson(json.decode(str));

String bibleToJson(Bible data) => json.encode(data.toJson());

class Bible {
  List<BibleElement> bibles;

  Bible({
    required this.bibles,
  });

  factory Bible.fromJson(Map<String, dynamic> json) => Bible(
        bibles: List<BibleElement>.from(
            json["bibles"].map((x) => BibleElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bibles": List<dynamic>.from(bibles.map((x) => x.toJson())),
      };
}

class BibleElement {
  String language;
  List<Version> versions;

  BibleElement({
    required this.language,
    required this.versions,
  });

  factory BibleElement.fromJson(Map<String, dynamic> json) => BibleElement(
        language: json["language"],
        versions: List<Version>.from(
            json["versions"].map((x) => Version.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "versions": List<dynamic>.from(versions.map((x) => x.toJson())),
      };
}

class Version {
  String name;
  String folderPath;
  List<Book> books;
  bool audioSupport;
  String? audioPath;

  Version({
    required this.name,
    required this.folderPath,
    required this.books,
    required this.audioSupport,
    this.audioPath,
  });

  factory Version.fromJson(Map<String, dynamic> json) => Version(
        name: json["name"],
        folderPath: json["folder_path"],
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
        audioSupport: json["audio_support"],
        audioPath: json["audio_path"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "folder_path": folderPath,
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
        "audio_support": audioSupport,
        "audio_path": audioPath,
      };
}

class Book {
  Testament testament;
  int order;
  String name;
  int chapters;
  String folderPath;

  Book({
    required this.testament,
    required this.order,
    required this.name,
    required this.chapters,
    required this.folderPath,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        testament: testamentValues.map[json["testament"]]!,
        order: json["order"],
        name: json["name"],
        chapters: json["chapters"],
        folderPath: json["folder_path"],
      );

  Map<String, dynamic> toJson() => {
        "testament": testamentValues.reverse[testament],
        "order": order,
        "name": name,
        "chapters": chapters,
        "folder_path": folderPath,
      };
}

enum Testament {
  // ignore: constant_identifier_names
  NEW,
  // ignore: constant_identifier_names
  OLD
}

final testamentValues =
    EnumValues({"new": Testament.NEW, "old": Testament.OLD});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
