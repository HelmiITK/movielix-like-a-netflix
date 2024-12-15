import 'package:flutter/material.dart';
import 'package:movielix/movie/providers/movie_get_search_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 163, 17, 7),
      automaticallyImplyLeading: false,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // icon app
            Row(
              children: [
                Image.asset(
                  'assets/icons/Movielix_icon.png',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 2),
                const Text(
                  "Movielix",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            // Search Bar with Interactive Logic
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Show search dialog when tapped
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.grey[900],
                        title: const Text(
                          "Search Movie",
                          style: TextStyle(color: Colors.white),
                        ),
                        content: TextField(
                          controller: searchController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Enter movie name...",
                            hintStyle: TextStyle(color: Colors.white54),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              final query = searchController.text.trim();
                              if (query.isNotEmpty) {
                                // Trigger search and navigate
                                context
                                    .read<MovieGetSearchProvider>()
                                    .searchMovies(query, context);
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.pushNamed(context, '/search_results');
                              }
                            },
                            child: const Text('Search',
                                style: TextStyle(color: Colors.red)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Search here ...",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white70),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
