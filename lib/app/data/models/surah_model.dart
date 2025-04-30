import 'package:quran_kareem/app/data/models/ayah_model.dart';

class SurahModel {
  final int number;
  final String name;
  final String latinName;
  final int numberOfVerses;
  final String placeOfRevelation;
  final String meaning;
  final String description;
  final Map<String, dynamic> audioFull;
  final List<AyahModel>? ayah;

  SurahModel({
    required this.number,
    required this.name,
    required this.latinName,
    required this.numberOfVerses,
    required this.placeOfRevelation,
    required this.meaning,
    required this.description,
    required this.audioFull,
    this.ayah,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
    number: json['nomor'],
    name: json['nama'],
    latinName: json['namaLatin'],
    numberOfVerses: json['jumlahAyat'],
    placeOfRevelation: json['tempatTurun'],
    meaning: json['arti'],
    description: json['deskripsi'],
    audioFull: json['audioFull'],
    ayah:
        json['ayat'] != null
            ? (json['ayat'] as List<dynamic>)
                .map((e) => AyahModel.fromJson(e))
                .toList()
            : null,
  );

  Map<String, dynamic> toJson() {
    return {
      'nomor': number,
      'nama': name,
      'namaLatin': latinName,
      'jumlahAyat': numberOfVerses,
      'tempatTurun': placeOfRevelation,
      'arti': meaning,
      'deskripsi': description,
      'audioFull': audioFull,
      'ayah': ayah,
    };
  }

  factory SurahModel.empty() {
    return SurahModel(
      number: 0,
      name: '',
      latinName: '',
      numberOfVerses: 0,
      placeOfRevelation: '',
      meaning: '',
      description: '',
      audioFull: {},
      ayah: null,
    );
  }
}

class ListSurahResponse {
  final int code;
  final String message;
  final List<SurahModel> data;

  ListSurahResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ListSurahResponse.fromJson(Map<String, dynamic> json) {
    return ListSurahResponse(
      code: json['code'],
      message: json['message'],
      data:
          (json['data'] as List<dynamic>)
              .map((e) => SurahModel.fromJson(e))
              .toList(),
    );
  }
}

class SurahResponse {
  final int code;
  final String message;
  final SurahModel data;

  SurahResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SurahResponse.fromJson(Map<String, dynamic> json) {
    return SurahResponse(
      code: json['code'],
      message: json['message'],
      data: SurahModel.fromJson(json['data']),
    );
  }
}
