import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movielix/app_constants.dart';
import 'package:movielix/movie/models/detail_model.dart';
import 'package:movielix/movie/models/genre_model.dart';
import 'package:movielix/movie/models/movie_model.dart';
import 'package:movielix/movie/repositories/movie_repositories.dart';

class MovieRepositoriesImpl implements MovieRepositories {
  final Dio _dio;

  MovieRepositoriesImpl(this._dio);

  // DISCOVER MOVIE
  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get Discover movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get discover movies');
    }
  }

  // UPCOMING MOVIE
  @override
  Future<Either<String, MovieResponseModel>> getUpcoming({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/upcoming',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error fetching upcoming movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on fetching upcoming movies');
    }
  }

  // GENRE MOVIE
  @override
  Future<Either<String, GenreResponseModel>> getGenres() async {
    try {
      final result = await _dio.get('/genre/movie/list');

      if (result.statusCode == 200 && result.data != null) {
        final model = GenreResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error fetching genres');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on fetching genres');
    }
  }

  // DETAIL MOVIE
  // @override
  // Future<Either<String, DetailMovieResponseModel>> getMovieDetail(
  //     int movieId) async {
  //   try {
  //     final result = await _dio.get('/movie/$movieId');

  //     if (result.statusCode == 200 && result.data != null) {
  //       final model = DetailMovieResponseModel.fromJson(result.data);
  //       return Right(model);
  //     }

  //     return const Left('Error fetching movie details');
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       return Left(e.response.toString());
  //     }
  //     return const Left('Another error on fetching movie details');
  //   }
  // }

  @override
  Future<Either<String, DetailMovieResponseModel>> getMovieDetail(
      int movieId) async {
    try {
      final response = await _dio
          .get('${AppConstants.baseUrl}/movie/$movieId', queryParameters: {
        'api_key': AppConstants.apiKey,
      });

      // Check if the response contains valid data
      if (response.data == null) {
        return const Left('Failed to load movie details. Data is null.');
      }

      // If a required field like title is missing, handle the error
      if (response.data['title'] == null || response.data['overview'] == null) {
        return const Left('Incomplete movie details. Missing required fields.');
      }

      // Parse the response to the model
      return Right(DetailMovieResponseModel.fromJson(response.data));
    } catch (e) {
      return Left('Failed to fetch movie details: $e');
    }
  }
}
