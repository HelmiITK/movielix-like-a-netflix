import 'package:flutter/material.dart';
import 'package:movielix/movie/models/genre_model.dart';
import 'package:movielix/movie/repositories/movie_repositories.dart';

class MovieGetGenresProvider with ChangeNotifier {
  final MovieRepositories _movieRepositories;

  MovieGetGenresProvider(this._movieRepositories);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<Genre> _genres = [];
  List<Genre> get genres => _genres;

  // Get Movie Genres
  Future<void> getGenres(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepositories.getGenres();

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));

      _isLoading = false;
      notifyListeners();
    }, (response) {
      _genres.clear();
      _genres.addAll(response.genres);
      _isLoading = false;
      notifyListeners();
    });
  }
}
