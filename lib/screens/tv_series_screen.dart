// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielix/app_constants.dart';
import 'package:movielix/components/bottom_navigation_bar_widget.dart';
import 'package:movielix/components/custom_app_bar_widget.dart';
import 'package:movielix/tv/providers/tv_get_popular_provider.dart';
import 'package:provider/provider.dart';

class TvSeries extends StatefulWidget {
  const TvSeries({super.key});

  @override
  State<TvSeries> createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  // int _currentIndexTv = 0;

  @override
  void initState() {
    super.initState();
    // Memanggil provider untuk fetch data saat widget dimulai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TvGetPopularProvider>(context, listen: false)
          .getPopular(context);
    });
  }

  int _selectedIndex = 1;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                heightFactor: 1.3,
                child: Text(
                  "Tv Series ",
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 218, 24, 10),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Consumer<TvGetPopularProvider>(
                builder: (_, provider, __) {
                  if (provider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  }

                  if (provider.tvs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No tvs found.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  // Ambil data dari provider
                  final tvSeries = provider.tvs.take(20).toList();

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
                    itemCount: tvSeries.length,
                    itemBuilder: (context, index) {
                      final series = tvSeries[index];
                      final posterPath = series.posterPath;
                      final voteAverage = series.voteAverage;
                      final originalName = series.originalName;
                      final seriesId =
                          series.id; // Ambil TV Series ID untuk navigasi

                      return GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman detail dengan seriesId
                          Navigator.pushNamed(
                            context,
                            '/detail_movie', // Rute detail movie
                            arguments: seriesId,
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
                              // Rating di atas gambar di sisi kiri
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
                              // Nama TV Series di bawah gambar
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
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
