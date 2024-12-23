// // PROVIDER FOR SEARCH MOVIE
// import 'package:flutter/material.dart';
// import 'package:movielix/movie/models/movie_model.dart';
// import 'package:movielix/movie/repositories/movie_repositories.dart';

// class MovieGetSearchProvider with ChangeNotifier {
//   final MovieRepositories _movieRepositories;

//   MovieGetSearchProvider(this._movieRepositories);

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   final List<MovieModel> _searchResults = [];
//   List<MovieModel> get searchResults => _searchResults;

//   Future<void> searchMovies(String query, BuildContext context) async {
//     _isLoading = true;
//     notifyListeners();

//     final result = await _movieRepositories.getMovieBySearch(query);

//     result.fold((errorMessage) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(errorMessage),
//       ));
//       _isLoading = false;
//       notifyListeners();
//       return;
//     }, (response) {
//       _searchResults.clear();
//       _searchResults.addAll(response.results);
//       _isLoading = false;
//       notifyListeners();
//       return null;
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:movielix/movie/models/movie_model.dart';
import 'package:movielix/movie/repositories/movie_repositories.dart';

class MovieGetSearchProvider with ChangeNotifier {
  final MovieRepositories _movieRepositories;

  MovieGetSearchProvider(this._movieRepositories);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _searchResults = [];
  List<MovieModel> get searchResults => _searchResults;

  final List<String> _recommendations = [];
  List<String> get recommendations => _recommendations;

  Future<void> searchMovies(String query, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepositories.getMovieBySearch(query);

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      _searchResults.clear();
      _searchResults.addAll(response.results);
      _isLoading = false;
      notifyListeners();
      return null;
    });
  }

  void updateRecommendations(String query) async {
    if (query.isEmpty) {
      _recommendations.clear();
    } else {
      // Panggil API untuk mendapatkan rekomendasi berdasarkan query
      final result = await _movieRepositories.getMovieBySearch(query);

      result.fold((errorMessage) {
        // Jika terjadi kesalahan, tidak menampilkan rekomendasi apa pun
        _recommendations.clear();
      }, (response) {
        // Ambil judul film dari hasil pencarian dan tambahkan ke rekomendasi
        _recommendations.clear();
        _recommendations.addAll(
          response.results
              .map((movie) => movie.title)
              .take(5), // Batasi 5 hasil
        );
      });
    }
    notifyListeners();
  }
}
