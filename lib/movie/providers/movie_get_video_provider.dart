import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:movielix/movie/models/video_model.dart';
import 'package:movielix/movie/repositories/movie_repositories.dart';

class MovieGetVideoProvider with ChangeNotifier {
  final MovieRepositories _movieRepositories;
  final logger = Logger();

  MovieGetVideoProvider(this._movieRepositories);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  VideoMovieResponseModel? _movieVideo;
  VideoMovieResponseModel? get movieVideo => _movieVideo;

  // Method to clear the movie video data
  void clearMovieVideo() {
    _movieVideo = null;
    notifyListeners(); // Notifies listeners that the data is cleared
  }

  // Fetch Movie Video (e.g., Trailer) by ID
  Future<void> getMovieVideo(BuildContext context, int movieId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepositories.getMovieVideo(movieId);

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));

      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      logger.d("API Response: $response");
      _movieVideo = response;
      _isLoading = false;
      notifyListeners();
      return null;
    });
  }
}
