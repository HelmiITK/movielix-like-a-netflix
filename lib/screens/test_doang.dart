import 'package:flutter/material.dart';
import 'package:movielix/app_constants.dart';
import 'package:movielix/movie/providers/movie_get_discover_provider.dart';
import 'package:provider/provider.dart';

class TestDoang extends StatelessWidget {
  const TestDoang({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie DB'),
      ),
      body: Consumer<MovieGetDiscoverProvider>(builder: (_, provider, __) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.movies.isNotEmpty) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = provider.movies[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Menampilkan gambar backdrop
                    if (movie.backdropPath != null) // Cek apakah path tersedia
                      Image.network(
                        '${AppConstants.imageUrlW500}${movie.backdropPath}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.broken_image,
                          size: 50,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            movie.overview,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const Center(
          child: Text("Not Found Discover Movie"),
        );
      }),
    );
  }
}
