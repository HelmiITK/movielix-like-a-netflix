import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:movielix/movie/models/detail_model.dart';
import 'package:movielix/movie/repositories/movie_repositories.dart';

class MovieGetDetailProvider with ChangeNotifier {
  final MovieRepositories _movieRepositories;
  final logger = Logger();

  MovieGetDetailProvider(this._movieRepositories);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DetailMovieResponseModel? _movieDetail;
  DetailMovieResponseModel? get movieDetail => _movieDetail;

  // Fetch Movie Detail by ID
  Future<void> getMovieDetail(BuildContext context, int movieId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepositories.getMovieDetail(movieId);

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));

      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      logger.d("API Response: $response");
      _movieDetail = response;
      _isLoading = false;
      notifyListeners();
      return null;
    });
  }
}
