import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:movielix/app_constants.dart';
import 'package:movielix/components/custom_app_bar_widget.dart';
import 'package:movielix/components/bottom_navigation_bar_widget.dart';
import 'package:movielix/movie/models/genre_model.dart';
import 'package:movielix/movie/providers/movie_get_discover_provider.dart';
import 'package:movielix/movie/providers/movie_get_genres_provider.dart';
import 'package:movielix/movie/providers/movie_get_upcoming_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndexPopular = 0;
  int _currentIndexUpcoming = 0;

  @override
  void initState() {
    super.initState();
    // Memanggil provider untuk fetch data saat widget dimulai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieGetDiscoverProvider>(context, listen: false)
          .getDiscover(context);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieGetUpcomingProvider>(context, listen: false)
          .getUpcoming(context);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieGetGenresProvider>(context, listen: false)
          .getGenres(context);
    });
  }

  final logger = Logger();
  int itemsToShow = 5;
  bool showAll = false;

  // List<String> imageUrlsHorror = [
  //   'https://cdn1-production-images-kly.akamaized.net/CfG5YvE5rrLlkLCGtdyRSKYhUWA=/800x450/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/38122/original/the-conjuring-130729b.jpg',
  //   'https://montasefilm.com/wp-content/uploads/2021/06/946346-h.jpg',
  //   'https://images.bisnis.com/posts/2024/10/05/1805135/jadwal_film_kuasa_gelap_di_bioskop_1728139951.jpg',
  //   'https://i.ytimg.com/vi/XY7falovJiI/maxresdefault.jpg',
  //   'https://thumbor.prod.vidiocdn.com/GEScqrxjbielTjEiQy22QLpvuyE=/640x360/filters:quality(75)/vidio-web-prod-video/uploads/video/image/8188423/ep-01-kena-gigi-uang-kembali-7be194.jpg',
  //   'https://www.screengeek.net/wp-content/uploads/2018/11/annabelle-3.jpg',
  //   'https://film-authority.com/wp-content/uploads/2023/07/insidious-the-red-door-2023-ending-explained-64a7c098e40e153535670-900-e1689066995159.webp',
  //   'https://kilasjatim.com/wp-content/uploads/2023/09/film-the-nun-2.jpg',
  // ];

  // List<String> imageUrlsAction = [
  //   'https://cdn1-production-images-kly.akamaized.net/CfG5YvE5rrLlkLCGtdyRSKYhUWA=/800x450/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/38122/original/the-conjuring-130729b.jpg',
  //   'https://montasefilm.com/wp-content/uploads/2021/06/946346-h.jpg',
  //   'https://images.bisnis.com/posts/2024/10/05/1805135/jadwal_film_kuasa_gelap_di_bioskop_1728139951.jpg',
  //   'https://i.ytimg.com/vi/XY7falovJiI/maxresdefault.jpg',
  //   'https://thumbor.prod.vidiocdn.com/GEScqrxjbielTjEiQy22QLpvuyE=/640x360/filters:quality(75)/vidio-web-prod-video/uploads/video/image/8188423/ep-01-kena-gigi-uang-kembali-7be194.jpg',
  //   'https://www.screengeek.net/wp-content/uploads/2018/11/annabelle-3.jpg',
  //   'https://film-authority.com/wp-content/uploads/2023/07/insidious-the-red-door-2023-ending-explained-64a7c098e40e153535670-900-e1689066995159.webp',
  //   'https://kilasjatim.com/wp-content/uploads/2023/09/film-the-nun-2.jpg',
  // ];

  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigasi ke halaman yang sesuai berdasarkan index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/TvSeries');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  // nilai default genre filtering
  int selectedGenre = 28;
  String selectedGenreName = "Action";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MOVIE POPULER HEADER
              Container(
                margin:
                    const EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
                child: Text(
                  "Movie Popular",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Discover Movie
              Consumer<MovieGetDiscoverProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  }

                  if (provider.movies.isEmpty) {
                    return const Center(
                      child: Text(
                        'No movies found.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.8,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndexPopular = index;
                            });
                          },
                        ),
                        items: provider.movies.take(5).map((movie) {
                          final backdropPath = movie.backdropPath;

                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  // Arahkan ke halaman detail dengan ID movie
                                  Navigator.pushNamed(
                                    context,
                                    '/detail_movie', // Rute detail movie
                                    arguments: movie
                                        .id, // Kirim id movie sebagai argument
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    backdropPath != null
                                        ? '${AppConstants.imageUrlW500}$backdropPath'
                                        : 'https://via.placeholder.com/500x200',
                                    width: 350,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: provider.movies
                            .take(5)
                            .toList()
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () => setState(
                                () => _currentIndexPopular = entry.key),
                            child: Container(
                              width: 6.5,
                              height: 6.5,
                              margin: const EdgeInsets.only(
                                  top: 20, right: 8, left: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndexPopular == entry.key
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),

              // Upcoming Movie
              Consumer<MovieGetUpcomingProvider>(
                builder: (_, provider, __) {
                  if (provider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  }

                  if (provider.movies.isEmpty) {
                    return const Center(
                      child: Text(
                        'No movies found.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          "Upcoming InsyaAllah",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 100.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.33,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndexUpcoming = index;
                            });
                          },
                        ),
                        items: provider.movies.take(5).map((movie) {
                          final backdropPath = movie.backdropPath;
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/detail_movie',
                                    arguments: movie.id,
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    backdropPath != null
                                        ? '${AppConstants.imageUrlW500}$backdropPath'
                                        : 'https://via.placeholder.com/500x200',
                                    width: 350,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: provider.movies
                            .take(5)
                            .toList()
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () => setState(
                                () => _currentIndexUpcoming = entry.key),
                            child: Container(
                              width: 5.0,
                              height: 5.0,
                              margin: const EdgeInsets.only(
                                  top: 20, right: 6, left: 6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndexUpcoming == entry.key
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),

              // Genres filter
              Consumer<MovieGetGenresProvider>(builder: (_, genreProvider, __) {
                if (genreProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  );
                }

                if (genreProvider.genres.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Genres Found.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                // Update nama genre berdasarkan ID
                selectedGenreName = genreProvider.genres
                    .firstWhere(
                      (genre) => genre.id == selectedGenre,
                      orElse: () => Genre(
                          id: 0,
                          name: "Unknown"), // Default jika tidak ditemukan
                    )
                    .name;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Button Filter by Genre
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        "Genre",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: genreProvider.genres.map((genre) {
                          return GenreButton(
                            label: genre.name,
                            isSelected: genre.id == selectedGenre,
                            onTap: () {
                              // Update state dan rebuild UI
                              setState(() {
                                selectedGenre = genre.id;
                              });
                              logger.d('Selected Genre: $selectedGenre');
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Menampilkan berdasarkan opsi genre yang akan dipilih
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        // 'Genre ID: $selectedGenre',
                        // 'Genre : $selectedGenreName [$selectedGenre]',
                        'Genre: $selectedGenreName',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Consumer<MovieGetDiscoverProvider>(
                        builder: (_, providerByFilter, __) {
                      if (providerByFilter.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (providerByFilter.movies.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Genres Found.',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      // Filter movie berdasarkan genre ID yang dipilih
                      final filteredMovies = providerByFilter.movies
                          .where((movie) {
                            return movie.genreIds.contains(selectedGenre);
                          })
                          .take(20)
                          .toList();

                      // logika jika by filter not found for result
                      if (filteredMovies.isEmpty) {
                        return const Center(
                          heightFactor: 5,
                          child: Text(
                            'Movie by genre not found.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: filteredMovies.length,
                        itemBuilder: (context, index) {
                          final moviesByFilter = filteredMovies[index];
                          final posterPath = moviesByFilter.posterPath;
                          final voteAverage = moviesByFilter.voteAverage;
                          final originalName = moviesByFilter.originalTitle;
                          final movieId = moviesByFilter.id;

                          return GestureDetector(
                            onTap: () {
                              // Navigasi ke halaman detail dengan movie.id
                              Navigator.pushNamed(
                                context, '/detail_movie', // Rute detail movie
                                arguments: movieId,
                              );
                            },
                            child: Card(
                              color: Colors.grey[900],
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(8.0),
                                      bottom: Radius.circular(8.0),
                                    ),
                                    child: Image.network(
                                      '${AppConstants.imageUrlW500}$posterPath',
                                      width: double.infinity,
                                      height: 280,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            voteAverage.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      color: Colors.black.withOpacity(0.7),
                                      child: Text(
                                        originalName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                );
              }),
            ],
          ),
        ),
      ),

      // NAVIGATION BAR
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}

class GenreButton extends StatelessWidget {
  final String label;
  final bool isSelected; // Menentukan apakah ini genre yang dipilih
  final VoidCallback onTap;

  const GenreButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.red[700]
              : Colors.red[900], // Warna berubah jika dipilih
          borderRadius: BorderRadius.circular(13),
          border: isSelected
              ? Border.all(
                  color: Colors.white,
                  width: 2) // Tambahkan border untuk highlight
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
