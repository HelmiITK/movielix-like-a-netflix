import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:movielix/movie/providers/movie_get_video_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoTrailerScreen extends StatefulWidget {
  final int movieId; // Menyimpan movieId yang diteruskan
  const VideoTrailerScreen({super.key, required this.movieId});

  @override
  State<VideoTrailerScreen> createState() => _VideoTrailerScreenState();
}

class _VideoTrailerScreenState extends State<VideoTrailerScreen> {
  late int movieId;

  @override
  void initState() {
    super.initState();
    movieId = widget.movieId;
    // Memanggil provider untuk fetch data detail movie saat pertama kali layar dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieGetVideoProvider>(context, listen: false)
          .getMovieVideo(context, widget.movieId);
    });
  }

  @override
  void didUpdateWidget(covariant VideoTrailerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Jika movieId berubah, kita akan membersihkan data sebelumnya dan memuat ulang data
    if (widget.movieId != oldWidget.movieId) {
      setState(() {
        movieId = widget.movieId; // Mengupdate movieId jika terjadi perubahan
      });

      // Membersihkan data lama sebelum mengambil data baru
      Provider.of<MovieGetVideoProvider>(context, listen: false)
          .clearMovieVideo();

      // Panggil kembali getMovieVideo dengan ID baru
      Provider.of<MovieGetVideoProvider>(context, listen: false)
          .getMovieVideo(context, widget.movieId);
    }
  }

  // Fungsi untuk meluncurkan URL video YouTube
  Future<void> _launchUrl(String videoKey) async {
    final url = Uri.parse('https://www.youtube.com/watch?v=$videoKey');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
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
                  // 'Video ${widget.movieId}',
                  'Movie Trailer',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 255, 17, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/icons/Movielix_icon.png',
              width: 60,
              height: 60,
            ),
          ],
        ),
      ),
      body: Consumer<MovieGetVideoProvider>(builder: (_, videoProvider, __) {
        if (videoProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        }

        final movieVideo = videoProvider.movieVideo;
        if (movieVideo == null || movieVideo.results.isEmpty) {
          return const Center(
            child: Text(
              'No videos available for this movie.',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Trailer video hanya tersedia di YouTube dan bukan untuk streaming langsung. Tekan tombol play untuk membuka trailer di aplikasi YouTube.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movieVideo.results.length,
                itemBuilder: (context, index) {
                  final video = movieVideo.results[index];
                  return ListTile(
                    title: Text(
                      video.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Type: ${video.type}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow, color: Colors.red),
                      onPressed: () {
                        // Panggil fungsi untuk meluncurkan URL YouTube dengan video key
                        _launchUrl(video.key);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
