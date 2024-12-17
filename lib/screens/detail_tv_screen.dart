import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:movielix/app_constants.dart';
import 'package:movielix/tv/providers/tv_get_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailTvScreen extends StatefulWidget {
  final int seriesId; // Tambahkan parameter movieId di sini
  const DetailTvScreen({super.key, required this.seriesId});

  @override
  State<DetailTvScreen> createState() => _DetailTvScreenState();
}

class _DetailTvScreenState extends State<DetailTvScreen> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    // Bersihkan cache gambar sebelum load detail TV baru
    imageCache.clear();
    imageCache.clearLiveImages();

    // Memanggil provider untuk fetch data detail movie
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TvGetDetailProvider>(context, listen: false)
          .getTvDetail(context, widget.seriesId); // Kirim movieId ke provider
    });
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
                  // 'Detail TV ${widget.seriesId}',
                  'Detail TV Series',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 255, 17, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // IconButton(
            //   icon: const Icon(Icons.favorite_border,
            //       color: Color.fromARGB(255, 255, 17, 0)),
            //   onPressed: () {},
            // ),
            Image.asset(
              'assets/icons/Movielix_icon.png',
              width: 60,
              height: 60,
            ),
          ],
        ),
      ),
      body: Consumer<TvGetDetailProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }

          final tvDetail = provider.tvDetail;

          if (tvDetail == null) {
            return const Center(
              child: Text(
                'Failed to load tv details.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Tv
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 12,
                    right: 12,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${tvDetail.backdropPath}',
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
                          tvDetail.name,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Release Date
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                  tvDetail.firstAirDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0],
                                  style: const TextStyle(
                                    color: Colors.grey,
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
                              tvDetail.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '(${tvDetail.voteCount.toString()})',
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
                            text: tvDetail.overview,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),

                      // Teks tambahan di bawah deskripsi
                      const Divider(color: Color.fromARGB(255, 226, 28, 13)),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8.0),
                        child: Center(
                          child: Text(
                            "Detail acara TV ini hanya bersifat informasi, bukan untuk streaming.",
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
    );
  }
}
