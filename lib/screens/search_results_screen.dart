import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielix/app_constants.dart';
// import 'package:movielix/components/custom_app_bar_widget.dart';
import 'package:movielix/movie/providers/movie_get_search_provider.dart';
import 'package:provider/provider.dart';
import 'package:movielix/movie/models/movie_model.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<MovieGetSearchProvider>(context);
    final isLoading = searchProvider.isLoading;
    final searchResults = searchProvider.searchResults;

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: const CustomAppBar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 163, 17, 7),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
        // centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 2),
                Text(
                  'Search Results',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 180, // Lebar fixed untuk search bar
              child: _buildSearchBar(searchProvider),
            ),
          ],
        ),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : searchResults.isEmpty
              ? const Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: _buildMovieGrid(
                          searchResults), // GridView hasil pencarian
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Hasil pencarian ini hanya bersifat informasi, bukan untuk streaming.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
    );
  }

  /// Membuat GridView untuk dua card per baris
  Widget _buildMovieGrid(List<MovieModel> movies) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Dua card per baris
        crossAxisSpacing: 10, // Jarak horizontal antar card
        mainAxisSpacing: 10, // Jarak vertikal antar card
        childAspectRatio: 0.7, // Rasio tinggi ke lebar card
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _buildMovieCard(
          movie,
          () {
            // Navigasi ke halaman detail
            Navigator.pushNamed(
              context,
              '/detail_movie',
              arguments: movie.id, // Kirimkan ID movie ke halaman detail
            );
          },
        );
      },
    );
  }

  /// Card film dengan navigasi onTap
  Widget _buildMovieCard(MovieModel movie, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Navigasi ke halaman detail
      child: Card(
        color: Colors.grey[900],
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8.0),
                bottom: Radius.circular(8.0),
              ),
              child: movie.posterPath?.isNotEmpty == true
                  ? Image.network(
                      '${AppConstants.imageUrlW500}${movie.posterPath}',
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 280,
                      width: double.infinity,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                      ),
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
                      movie.voteAverage.toString(),
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
                  movie.originalTitle,
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
  }

  Widget _buildSearchBar(MovieGetSearchProvider searchProvider) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              onSubmitted: (query) {
                if (query.trim().isNotEmpty) {
                  searchProvider.searchMovies(query.trim(), context);
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search here...',
                hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  top: 12,
                  bottom: 9,
                  left: 15,
                ),
              ),
            ),
          ),
          IconButton(
            padding: const EdgeInsets.only(
              bottom: 9,
              top: 4,
              left: 5,
            ),
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              final query = _searchController.text.trim();
              if (query.isNotEmpty) {
                searchProvider.searchMovies(query, context);
              }
            },
          ),
        ],
      ),
    );
  }
}

//   // dialog search
//   void _showSearchDialog(
//       BuildContext context, MovieGetSearchProvider searchProvider) {
//     final TextEditingController searchController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.grey[900],
//           title: const Text(
//             'Search Movies',
//             style: TextStyle(color: Colors.white),
//           ),
//           content: TextField(
//             controller: searchController,
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               hintText: 'Enter movie name...',
//               hintStyle: TextStyle(color: Colors.white54),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.red),
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child:
//                   const Text('Cancel', style: TextStyle(color: Colors.white)),
//             ),
//             TextButton(
//               onPressed: () {
//                 final query = searchController.text.trim();
//                 if (query.isNotEmpty) {
//                   searchProvider.searchMovies(query, context);
//                 }
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Search', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
