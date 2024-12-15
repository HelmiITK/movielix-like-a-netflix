// PROVIDER FOR SEARCH MOVIE
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
}
