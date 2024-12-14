import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movielix/tv/models/detail_model.dart';
import 'package:movielix/tv/models/tv_model.dart';
import 'package:movielix/tv/repositories/tv_repositories.dart';

class TvRepositoriesImpl implements TvRepositories {
  final Dio _dio;

  TvRepositoriesImpl(this._dio);


  // TV POPULAR
  @override
  Future<Either<String, TvResponseModel>> getPopular({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/tv/popular',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get Discover tvs');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get discover tvs');
    }
  }

  // DETAIL TV
@override
Future<Either<String, DetailTvResponseModel>> getTvDetail(int seriesId) async {
  try {
    final result = await _dio.get(
      '/tv/$seriesId', // Endpoint URL
    );

    if (result.statusCode == 200 && result.data != null) {
      final model = DetailTvResponseModel.fromJson(result.data);
      return Right(model);
    }

    return const Left('Error getting TV detail');
  } on DioException catch (e) {
    if (e.response != null) {
      return Left(e.response.toString());
    }
    return const Left('Another error occurred while fetching TV detail');
  }
}

}
