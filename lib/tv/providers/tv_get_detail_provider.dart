import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:movielix/tv/models/detail_model.dart';
import 'package:movielix/tv/repositories/tv_repositories.dart';

class TvGetDetailProvider with ChangeNotifier {
  final TvRepositories _tvRepositories;
  final logger = Logger();

  TvGetDetailProvider(this._tvRepositories);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DetailTvResponseModel? _tvDetail;
  DetailTvResponseModel? get tvDetail => _tvDetail;

  // Fetch Tv Detail by ID
  Future<void> getTvDetail(BuildContext context, int seriesId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _tvRepositories.getTvDetail(seriesId);

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));

      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      logger.d("API Response: $response");
      _tvDetail = response;
      _isLoading = false;
      notifyListeners();
      return null;
    });
  }
}
