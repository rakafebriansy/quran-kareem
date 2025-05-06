class BookmarkModel {
  final int surahNumber;
  final int ayahNumber;

  BookmarkModel({required this.surahNumber, required this.ayahNumber});

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
    surahNumber: json['surahNumber'],
    ayahNumber: json['ayahNumber'],
  );

  Map<String, dynamic> toJson() {
    return {'surahNumber': surahNumber, 'ayahNumber': ayahNumber};
  }
}
