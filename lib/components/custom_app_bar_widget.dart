import 'package:flutter/material.dart';
import 'package:movielix/movie/providers/movie_get_search_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  CustomAppBarState createState() => CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
    // final provider = context.read<MovieGetSearchProvider>();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 80,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, 35),
          showWhenUnlinked: false,
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: const Color.fromARGB(255, 163, 17, 7),
              child: Consumer<MovieGetSearchProvider>(
                builder: (context, provider, child) {
                  if (provider.recommendations.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    itemCount: provider.recommendations.length,
                    itemBuilder: (context, index) {
                      final recommendation = provider.recommendations[index];
                      return ListTile(
                        title: Text(
                          recommendation,
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          searchController.text = recommendation;
                          provider.searchMovies(recommendation, context);
                          Navigator.pushNamed(context, '/search_results');
                          _removeOverlay();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MovieGetSearchProvider>();

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 163, 17, 7),
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
          Expanded(
            child: CompositedTransformTarget(
              link: _layerLink,
              child: Container(
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
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
                        onChanged: (query) {
                          provider.updateRecommendations(query.trim());
                          if (_overlayEntry == null && query.isNotEmpty) {
                            _showOverlay(context);
                          } else if (query.isEmpty) {
                            _removeOverlay();
                          }
                        },
                        onSubmitted: (query) {
                          if (query.trim().isNotEmpty) {
                            provider.searchMovies(query.trim(), context);
                            Navigator.pushNamed(context, '/search_results');
                            _removeOverlay();
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
                          provider.searchMovies(query, context);
                          Navigator.pushNamed(context, '/search_results');
                          _removeOverlay();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _removeOverlay();
    super.dispose();
  }
}
