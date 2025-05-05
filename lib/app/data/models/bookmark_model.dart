class BookmarkModel {
  final int surahNumber;
  final int verseNumber;

  BookmarkModel({
    required this.surahNumber,
    required this.verseNumber,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
    surahNumber: json['surahNumber'],
    verseNumber: json['verseNumber'],
  );

  Map<String, dynamic> toJson() {
    return {
      'surahNumber': surahNumber,
      'verseNumber': verseNumber,
    };
  }
}
