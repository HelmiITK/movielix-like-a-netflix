import 'package:flutter/material.dart';
import 'package:movielix/movie/models/movie_model.dart';
import 'package:movielix/movie/repositories/movie_repositories.dart';

class MovieGetUpcomingProvider with ChangeNotifier {
  final MovieRepositories _movieRepositories;

  MovieGetUpcomingProvider(this._movieRepositories);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  // Upcoming Movie
  Future<void> getUpcoming(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepositories.getUpcoming();

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));

        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
