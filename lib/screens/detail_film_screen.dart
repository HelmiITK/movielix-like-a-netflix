import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielix/movie/providers/movie_get_detail_provider.dart';
import 'package:movielix/movie/providers/movie_get_video_provider.dart';
import 'package:provider/provider.dart';

class DetailMovie extends StatefulWidget {
  final int movieId; // Tambahkan parameter movieId di sini
  const DetailMovie({super.key, required this.movieId});

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  bool isExpanded = false;
  // bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    // Memanggil provider untuk fetch data detail movie
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieGetDetailProvider>(context, listen: false)
          .getMovieDetail(context, widget.movieId); // Kirim movieId ke provider

      // Panggil getMovieVideo dengan ID film yang sudah tersedia
      Provider.of<MovieGetVideoProvider>(context, listen: false)
          .getMovieVideo(context, widget.movieId);
    });
  }

  // void toggleFavorite() {
  //   setState(() {
  //     isFavorite = !isFavorite;
  //   });
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         isFavorite ? "Added to Favorites" : "Removed from Favorites",
  //       ),
  //       duration: const Duration(seconds: 1),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 17, 0),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  // 'Detail ${widget.movieId}',
                  'Detail Movie',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 255, 17, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // IconButton(
            //   icon: Icon(
            //     isFavorite ? Icons.favorite : Icons.favorite_border,
            //     color: const Color.fromARGB(255, 255, 17, 0),
            //   ),
            //   onPressed: toggleFavorite,
            // ),
            Image.asset(
              'assets/icons/Movielix_icon.png',
              width: 60,
              height: 60,
            ),
          ],
        ),
      ),
      body: Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }

          final movieDetail = provider.movieDetail;
          if (movieDetail == null) {
            return const Center(
              child: Text(
                'Failed to load movie details.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          List<String> words = movieDetail.overview.split(' ');

          String displayedText = isExpanded
              ? movieDetail.overview
              : '${words.take(25).join(' ')}...';

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Movie
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 12, right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath}',
                      fit: BoxFit.cover,
                      height: 230,
                      width: double.infinity,
                    ),
                  ),
                ),

                // konten detail
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movieDetail.title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Release Date dan Genre
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Release
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(
                                    width: 5), // Spasi antara ikon dan teks
                                Text(
                                  movieDetail.releaseDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            // Genre
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      movieDetail.genres.map<Widget>((genre) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 17, 0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 2,
                                          ),
                                        ),
                                        child: Text(
                                          genre.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 1),

                      // Average Rating
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_rate_rounded,
                              color: Colors.amber,
                              size: 30,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              movieDetail.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '(${movieDetail.voteCount.toString()})',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 190, 190, 190),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Color.fromARGB(255, 226, 28, 13)),

                      // Overview
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            text: displayedText,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: isExpanded ? " Read Some" : " Read More",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 17, 0),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Divider(color: Color.fromARGB(255, 226, 28, 13)),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 8,
                        ),
                        child: Center(
                          child: Text(
                            "Detail film ini hanya bersifat informasi, bukan untuk streaming.",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<MovieGetVideoProvider>(
                builder: (_, movieProvider, __) {
                  // Ambil movieId dari provider
                  final movieId = movieProvider.movieVideo;
                  return ElevatedButton.icon(
                    onPressed: () {
                      if (movieId != null) {
                        Navigator.pushNamed(
                          context,
                          '/trailer_movie',
                          arguments: movieId.id,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Movie ID not available")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 17, 0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 80,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    icon: const Icon(
                      Icons.play_arrow_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: Text(
                      'Watch Trailer',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
