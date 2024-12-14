import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movielix/app_constants.dart';
import 'package:movielix/firebase_options.dart';
import 'package:movielix/movie/providers/movie_get_detail_provider.dart';
import 'package:movielix/movie/providers/movie_get_discover_provider.dart';
import 'package:movielix/movie/providers/movie_get_genres_provider.dart';
import 'package:movielix/movie/providers/movie_get_upcoming_provider.dart';
import 'package:movielix/movie/repositories/movie_repositories.dart';
import 'package:movielix/movie/repositories/movie_repositories_impl.dart';
import 'package:movielix/screens/detail_film_screen.dart';
import 'package:movielix/screens/detail_tv_screen.dart';
import 'package:movielix/screens/forgot_password_screen.dart';
import 'package:movielix/screens/home_screen.dart';
import 'package:movielix/screens/login_screen.dart';
import 'package:movielix/screens/profile_screen.dart';
import 'package:movielix/screens/register_screen.dart';
import 'package:movielix/screens/search_results_screen.dart';
import 'package:movielix/screens/splash_screen.dart';
import 'package:movielix/screens/test_doang.dart';
// import 'package:movielix/screens/trailer_movie_screen.dart';
import 'package:movielix/screens/tv_series_screen.dart';
import 'package:movielix/tv/providers/tv_get_detail_provider.dart';
import 'package:movielix/tv/providers/tv_get_popular_provider.dart';
import 'package:movielix/tv/repositories/tv_repositories.dart';
import 'package:movielix/tv/repositories/tv_repositories_impl.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Pastikan widget diinisialisasi terlebih dahulu
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Konfigurasi Firebase
  );

  // API TMDB
  final dioOptions = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    queryParameters: {'api_key': AppConstants.apiKey},
  );
  final Dio dio = Dio(dioOptions);
  final MovieRepositories movieRepositories = MovieRepositoriesImpl(dio);
  final TvRepositories tvRepositories = TvRepositoriesImpl(dio);

  runApp(MyApp(
    movieRepositories: movieRepositories,
    tvRepositories: tvRepositories,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.movieRepositories,
    required this.tvRepositories,
  });

  final MovieRepositories movieRepositories;
  final TvRepositories tvRepositories;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieGetDiscoverProvider(movieRepositories),
        ),
        ChangeNotifierProvider(
          create: (_) => MovieGetUpcomingProvider(movieRepositories),
        ),
        ChangeNotifierProvider(
          create: (_) => TvGetPopularProvider(tvRepositories),
        ),
        ChangeNotifierProvider(
          create: (_) => MovieGetGenresProvider(movieRepositories),
        ),
        ChangeNotifierProvider(
          create: (_) => MovieGetDetailProvider(movieRepositories),
        ),
        ChangeNotifierProvider(
          create: (_) => TvGetDetailProvider(tvRepositories),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const SplashScreen(),
          '/register': (context) => const Register(),
          '/login_account': (context) => const Login(),
          '/forgot_password': (context) => const ForgotPassword(),
          '/home': (context) => const HomeScreen(),
          // '/detail_movie': (context) => const DetailMovie(),

          '/detail_movie': (context) {
            // Ambil argument yang dikirim sebagai ID movie
            final movieId = ModalRoute.of(context)!.settings.arguments as int;

            // Pastikan mengirim movieId ke DetailMovie
            return DetailMovie(movieId: movieId);
          },

          '/detail_tv': (context) {
            final seriesId = ModalRoute.of(context)!.settings.arguments as int;
            return DetailTvScreen(seriesId: seriesId);
          },

          '/TvSeries': (context) => const TvSeries(),
          '/profile': (context) => const Profile(),
          // '/trailer_movie': (context) => const TrailerMovie(),
          '/search_results': (context) => const SearchResults(),

          '/test': (context) => const TestDoang(),
        },
      ),
    );
  }
}
