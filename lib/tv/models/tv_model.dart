// class TvResponseModel {
//     final int page;
//     final List<TvModel> results;
//     final int totalPages;
//     final int totalResults;

//     TvResponseModel({
//         required this.page,
//         required this.results,
//         required this.totalPages,
//         required this.totalResults,
//     });

//     factory TvResponseModel.fromJson(Map<String, dynamic> json) => TvResponseModel(
//         page: json["page"],
//         results: List<TvModel>.from(json["results"].map((x) => TvModel.fromJson(x))),
//         totalPages: json["total_pages"],
//         totalResults: json["total_results"],
//     );
// }

// class TvModel {
//     // final bool adult;
//     final String? backdropPath;
//     final List<int> genreIds;
//     final int id;
//     final List<String> originCountry;
//     // final String originalLanguage;
//     final String originalName;
//     final String overview;
//     final double popularity;
//     final String? posterPath;
//     final DateTime firstAirDate;
//     final String name;
//     final double voteAverage;
//     final int voteCount;

//     TvModel({
//         // required this.adult,
//         required this.backdropPath,
//         required this.genreIds,
//         required this.id,
//         required this.originCountry,
//         // required this.originalLanguage,
//         required this.originalName,
//         required this.overview,
//         required this.popularity,
//         required this.posterPath,
//         required this.firstAirDate,
//         required this.name,
//         required this.voteAverage,
//         required this.voteCount,
//     });

//     factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
//         // adult: json["adult"],
//         backdropPath: json["backdrop_path"],
//         genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
//         id: json["id"],
//         originCountry: List<String>.from(json["origin_country"].map((x) => x)),
//         // originalLanguage: json["original_language"],
//         originalName: json["original_name"],
//         overview: json["overview"],
//         popularity: json["popularity"]?.toDouble(),
//         posterPath: json["poster_path"],
//         firstAirDate: DateTime.parse(json["first_air_date"]),
//         name: json["name"],
//         voteAverage: json["vote_average"]?.toDouble(),
//         voteCount: json["vote_count"],
//     );
// }

class TvResponseModel {
  final int page;
  final List<TvModel> results;
  final int totalPages;
  final int totalResults;

  TvResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvResponseModel.fromJson(Map<String, dynamic> json) =>
      TvResponseModel(
        page: json["page"],
        results:
            List<TvModel>.from(json["results"].map((x) => TvModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class TvModel {
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;

  TvModel({
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalName: json["original_name"],
        overview: json["overview"],
        popularity:
            (json["popularity"] != null) ? json["popularity"].toDouble() : 0.0,
        posterPath: json["poster_path"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        name: json["name"],
        voteAverage: (json["vote_average"] != null)
            ? json["vote_average"].toDouble()
            : 0.0,
        voteCount: json["vote_count"],
      );
}
