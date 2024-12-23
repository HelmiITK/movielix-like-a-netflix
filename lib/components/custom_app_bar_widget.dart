// import 'package:flutter/material.dart';
// import 'package:movielix/movie/providers/movie_get_search_provider.dart';
// import 'package:provider/provider.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController searchController = TextEditingController();

//     return AppBar(
//       backgroundColor: const Color.fromARGB(255, 163, 17, 7),
//       automaticallyImplyLeading: false,
//       title: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 0.1),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // icon app
//             Row(
//               children: [
//                 Image.asset(
//                   'assets/icons/Movielix_icon.png',
//                   width: 60,
//                   height: 60,
//                 ),
//                 const SizedBox(width: 2),
//                 const Text(
//                   "Movielix",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//               ],
//             ),
//             // Search Bar with Interactive Logic
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   // Show search dialog when tapped
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         backgroundColor: Colors.grey[900],
//                         title: const Text(
//                           "Search Movie",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         content: TextField(
//                           controller: searchController,
//                           style: const TextStyle(color: Colors.white),
//                           decoration: const InputDecoration(
//                             hintText: "Enter movie name...",
//                             hintStyle: TextStyle(color: Colors.white54),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.red),
//                             ),
//                           ),
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop(); // Close the dialog
//                             },
//                             child: const Text('Cancel',
//                                 style: TextStyle(color: Colors.white)),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               final query = searchController.text.trim();
//                               if (query.isNotEmpty) {
//                                 // Trigger search and navigate
//                                 context
//                                     .read<MovieGetSearchProvider>()
//                                     .searchMovies(query, context);
//                                 Navigator.of(context).pop(); // Close the dialog
//                                 Navigator.pushNamed(context, '/search_results');
//                               }
//                             },
//                             child: const Text('Search',
//                                 style: TextStyle(color: Colors.red)),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   height: 35,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(15.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         spreadRadius: 1,
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       )
//                     ],
//                   ),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Search here ...",
//                         style: TextStyle(
//                           fontSize: 15.0,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white70,
//                         ),
//                       ),
//                       Icon(
//                         Icons.search,
//                         color: Colors.white,
//                         size: 30.0,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

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
            // Icon app
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
            // Search Bar
            Expanded(
              child: Container(
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  // color:
                  //     const Color.fromARGB(255, 92, 0, 0),
                  borderRadius: BorderRadius.circular(15.0),
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
                        controller: searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Search here ...",
                          contentPadding: EdgeInsets.only(
                            top: 11,
                            bottom: 9,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300,
                          ),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (query) {
                          if (query.trim().isNotEmpty) {
                            // Trigger search
                            context
                                .read<MovieGetSearchProvider>()
                                .searchMovies(query.trim(), context);
                            Navigator.pushNamed(context, '/search_results');
                          }
                        },
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(
                        bottom: 9,
                        top: 1,
                        left: 20,
                      ),
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        final query = searchController.text.trim();
                        if (query.isNotEmpty) {
                          // Trigger search
                          context
                              .read<MovieGetSearchProvider>()
                              .searchMovies(query, context);
                          Navigator.pushNamed(context, '/search_results');
                        }
                      },
                    ),
                  ],
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
