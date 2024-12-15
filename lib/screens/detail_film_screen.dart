import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielix/movie/providers/movie_get_detail_provider.dart';
// import 'package:movielix/movie/providers/movie_get_genres_provider.dart';
import 'package:provider/provider.dart';

class DetailMovie extends StatefulWidget {
  final int movieId; // Tambahkan parameter movieId di sini
  const DetailMovie({super.key, required this.movieId});

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    // Memanggil provider untuk fetch data detail movie
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieGetDetailProvider>(context, listen: false)
          .getMovieDetail(context, widget.movieId); // Kirim movieId ke provider
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<MovieGetGenresProvider>(context, listen: false)
    //       .getGenres(context); // Kirim movieId ke provider
    // });
  }

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
                  'Detail ${widget.movieId}',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 255, 17, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border,
                  color: Color.fromARGB(255, 255, 17, 0)),
              onPressed: () {},
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
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 12,
                    right: 12,
                  ),
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
                            // Genre
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 17, 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                  child: const Text(
                                    'Sci-Fi',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 17, 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                  child: const Text(
                                    'Action',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 17, 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                  child: const Text(
                                    'Drama',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
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
                      const Divider(color: Colors.red),

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

                      // Caster
                      // const Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: Text(
                      //     "Cast",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: castData.map((cast) {
                      //       return Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      //         child: SizedBox(
                      //           width: 100,
                      //           child: ElevatedButton(
                      //             onPressed: () {},
                      //             style: ElevatedButton.styleFrom(
                      //               padding: const EdgeInsets.all(8.0),
                      //               backgroundColor: Colors.transparent,
                      //               side: const BorderSide(
                      //                 color: Color.fromARGB(226, 224, 5, 5),
                      //                 width: 1,
                      //               ),
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(14),
                      //               ),
                      //             ),
                      //             child: Column(
                      //               children: [
                      //                 // Menampilkan foto pemeran
                      //                 ClipRRect(
                      //                   borderRadius: BorderRadius.circular(50),
                      //                   child: Image.network(
                      //                     cast['imageUrl']!,
                      //                     width: 50,
                      //                     height: 50,
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(height: 8),
                      //                 // Menampilkan nama pemeran
                      //                 Text(
                      //                   cast['name']!,
                      //                   style: const TextStyle(
                      //                     color: Colors.white,
                      //                   ),
                      //                   maxLines: 1,
                      //                   overflow: TextOverflow.ellipsis,
                      //                   textAlign: TextAlign.center,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
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
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/trailer_movie',
                    // arguments: castData,
                  );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
