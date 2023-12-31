import 'dart:convert';

class VersesAMH {
  int? book;
  int? chapter;
  int? verseNumber;
  String? para;
  String? verseText;
  String? verseLocation;
  VersesAMH({
    this.book,
    this.chapter,
    this.verseNumber,
    this.para,
    this.verseText,
    this.verseLocation,
  });
  

  VersesAMH copyWith({
    int? book,
    int? chapter,
    int? verseNumber,
    String? para,
    String? verseText,
    String? verseLocation,
  }) {
    return VersesAMH(
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
      verseNumber: verseNumber ?? this.verseNumber,
      para: para ?? this.para,
      verseText: verseText ?? this.verseText,
      verseLocation: verseLocation ?? this.verseLocation,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(book != null){
      result.addAll({'book': book});
    }
    if(chapter != null){
      result.addAll({'chapter': chapter});
    }
    if(verseNumber != null){
      result.addAll({'verseNumber': verseNumber});
    }
    if(para != null){
      result.addAll({'para': para});
    }
    if(verseText != null){
      result.addAll({'verseText': verseText});
    }
    if(verseLocation != null){
      result.addAll({'verseLocation': verseLocation});
    }
  
    return result;
  }

  factory VersesAMH.fromMap(Map<String, dynamic> map) {
    return VersesAMH(
      book: map['book']?.toInt(),
      chapter: map['chapter']?.toInt(),
      verseNumber: map['verseNumber']?.toInt(),
      para: map['para'],
      verseText: map['verseText'],
      verseLocation: map['verseLocation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VersesAMH.fromJson(String source) => VersesAMH.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VersesAMH(book: $book, chapter: $chapter, verseNumber: $verseNumber, para: $para, verseText: $verseText, verseLocation: $verseLocation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is VersesAMH &&
      other.book == book &&
      other.chapter == chapter &&
      other.verseNumber == verseNumber &&
      other.para == para &&
      other.verseText == verseText &&
      other.verseLocation == verseLocation;
  }

  @override
  int get hashCode {
    return book.hashCode ^
      chapter.hashCode ^
      verseNumber.hashCode ^
      para.hashCode ^
      verseText.hashCode ^
      verseLocation.hashCode;
  }
}
