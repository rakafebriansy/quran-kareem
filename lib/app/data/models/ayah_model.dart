class AyahModel {
  final int number;
  final String arabText;
  final String latinText;
  final String meaning;
  final Map<String, dynamic> audio;

  AyahModel({
    required this.number,
    required this.arabText,
    required this.latinText,
    required this.meaning,
    required this.audio,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) => AyahModel(
    number: json['nomorAyat'],
    arabText: json['teksArab'],
    latinText: json['teksLatin'],
    meaning: json['teksIndonesia'],
    audio: json['audio'],
  );

  Map<String, dynamic> toJson() {
    return {
      'nomorAyat': number,
      'teksArab': arabText,
      'teksLatin': latinText,
      'teksIndonesia': meaning,
      'audio': audio,
    };
  }
}
