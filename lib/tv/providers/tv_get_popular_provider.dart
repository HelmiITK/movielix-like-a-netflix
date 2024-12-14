import 'package:flutter/material.dart';
import 'package:movielix/tv/models/tv_model.dart';
import 'package:movielix/tv/repositories/tv_repositories.dart';

class TvGetPopularProvider with ChangeNotifier {
  final TvRepositories _tvRepositories;

  TvGetPopularProvider(this._tvRepositories);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<TvModel> _tvs = [];
  List<TvModel> get tvs => _tvs;

  // Discover Movie or Popular Movie
  Future<void> getPopular(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _tvRepositories.getPopular();

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));

      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      _tvs.clear();
      _tvs.addAll(response.results);
      _isLoading = false;
      notifyListeners();
      return null;
    });
  }
}
