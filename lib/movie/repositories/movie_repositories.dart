import 'package:dartz/dartz.dart';
import 'package:movielix/movie/models/detail_model.dart';
import 'package:movielix/movie/models/genre_model.dart';
import 'package:movielix/movie/models/movie_model.dart';
import 'package:movielix/movie/models/video_model.dart';

abstract class MovieRepositories {
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
  Future<Either<String, MovieResponseModel>> getUpcoming({int page = 1});
  Future<Either<String, GenreResponseModel>> getGenres();
  Future<Either<String, DetailMovieResponseModel>> getMovieDetail(int movieId);
  Future<Either<String, MovieResponseModel>> getMovieBySearch(String query, {int page = 1});
  Future<Either<String, VideoMovieResponseModel>> getMovieVideo(int movieId);

}
