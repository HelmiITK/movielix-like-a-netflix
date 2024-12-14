import 'package:dartz/dartz.dart';
import 'package:movielix/tv/models/detail_model.dart';
import 'package:movielix/tv/models/tv_model.dart';

abstract class TvRepositories {
  Future<Either<String, TvResponseModel>> getPopular({int page = 1});
  Future<Either<String, DetailTvResponseModel>> getTvDetail(int seriesId);
}
