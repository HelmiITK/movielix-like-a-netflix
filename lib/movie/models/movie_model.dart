// class MovieResponseModel {
//   final int page;
//   final List<MovieModel> results;
//   final int totalPages;
//   final int totalResults;

//   MovieResponseModel({
//     required this.page,
//     required this.results,
//     required this.totalPages,
//     required this.totalResults,
//   });

//   factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
//       MovieResponseModel(
//         page: json["page"],
//         results: List<MovieModel>.from(
//             json["results"].map((x) => MovieModel.fromJson(x))),
//         totalPages: json["total_pages"],
//         totalResults: json["total_results"],
//       );
// }

// class MovieModel {
//   // final bool adult;
//   final String? backdropPath;
//   final List<int> genreIds;
//   final int id;
//   // final OriginalLanguage originalLanguage;
//   final String originalTitle;
//   final String overview;
//   final double popularity;
//   final String posterPath;
//   final DateTime releaseDate;
//   final String title;
//   final bool video;
//   final double voteAverage;
//   final int voteCount;

//   MovieModel({
//     // required this.adult,
//     required this.backdropPath,
//     required this.genreIds,
//     required this.id,
//     // required this.originalLanguage,
//     required this.originalTitle,
//     required this.overview,
//     required this.popularity,
//     required this.posterPath,
//     required this.releaseDate,
//     required this.title,
//     required this.video,
//     required this.voteAverage,
//     required this.voteCount,
//   });

//   factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
//         // adult: json["adult"],
//         backdropPath: json["backdrop_path"],
//         genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
//         id: json["id"],
//         // originalLanguage:
//         //     originalLanguageValues.map[json["original_language"]]!,
//         originalTitle: json["original_title"],
//         overview: json["overview"],
//         popularity: json["popularity"]?.toDouble(),
//         posterPath: json["poster_path"],
//         releaseDate: DateTime.parse(json["release_date"]),
//         title: json["title"],
//         video: json["video"],
//         voteAverage: json["vote_average"]?.toDouble(),
//         voteCount: json["vote_count"],
//       );
// }

// enum OriginalLanguage { en, es, fr, hi }

// final originalLanguageValues = EnumValues({
//   "en": OriginalLanguage.en,
//   "es": OriginalLanguage.es,
//   "fr": OriginalLanguage.fr,
//   "hi": OriginalLanguage.hi
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

class MovieResponseModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MovieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseModel(
      page: json["page"] ?? 1, // Default to 1 if null
      results: json["results"] != null
          ? List<MovieModel>.from(
              json["results"].map((x) => MovieModel.fromJson(x)))
          : [], // Default to empty list if results is null
      totalPages: json["total_pages"] ?? 0, // Default to 0 if null
      totalResults: json["total_results"] ?? 0, // Default to 0 if null
    );
  }
}

class MovieModel {
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath:
          json["backdrop_path"] ?? "", // Default to empty string if null
      genreIds: json["genre_ids"] != null
          ? List<int>.from(json["genre_ids"].map((x) => x))
          : [], // Default to empty list if genre_ids is null
      id: json["id"] ?? 0, // Default to 0 if id is null
      originalTitle: json["original_title"] ??
          "Unknown", // Default if original_title is null
      overview: json["overview"] ??
          "No overview available", // Default if overview is null
      popularity: (json["popularity"] != null)
          ? (json["popularity"]?.toDouble() ?? 0.0)
          : 0.0,
      posterPath: json["poster_path"] ?? "", // Default to empty string if null
      releaseDate: json["release_date"] != null
          ? DateTime.parse(json["release_date"])
          : DateTime.now(), // Default to current date if release_date is null
      title: json["title"] ?? "Unknown", // Default if title is null
      video: json["video"] ?? false, // Default to false if video is null
      voteAverage: (json["vote_average"] != null)
          ? (json["vote_average"]?.toDouble() ?? 0.0)
          : 0.0,
      voteCount: json["vote_count"] ?? 0, // Default to 0 if vote_count is null
    );
  }
}

enum OriginalLanguage { en, es, fr, hi }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.en,
  "es": OriginalLanguage.es,
  "fr": OriginalLanguage.fr,
  "hi": OriginalLanguage.hi
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
