// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:logging/logging.dart';

// class TrailerMovie extends StatefulWidget {
//   const TrailerMovie({super.key});

//   @override
//   State<TrailerMovie> createState() => _TrailerMovieState();
// }

// class _TrailerMovieState extends State<TrailerMovie> {
//   final videoURL = "https://www.youtube.com/watch?v=zkJZ9H0Xp3k";
//   YoutubePlayerController? _controller;
//   final _logger = Logger('TrailerMovie');

//   @override
//   void initState() {
//     super.initState();
//     final videoID = YoutubePlayer.convertUrlToId(videoURL);
//     if (videoID != null) {
//       _controller = YoutubePlayerController(
//         initialVideoId: videoID,
//         flags: const YoutubePlayerFlags(autoPlay: false),
//       );
//     } else {
//       _logger.severe('Error: Video ID could not be extracted from the URL.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         iconTheme: const IconThemeData(
//           color: Color.fromARGB(255, 255, 17, 0),
//         ),
//         title: Padding(
//           padding: const EdgeInsets.only(
//             right: 25,
//           ),
//           child: Center(
//             child: Text(
//               'Trailer',
//               style: GoogleFonts.poppins(
//                 color: const Color.fromARGB(255, 255, 17, 0),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: _controller != null
//           ? SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     YoutubePlayer(
//                       controller: _controller!,
//                       showVideoProgressIndicator: true,
//                     ),
//                     const SizedBox(height: 20),
//                     const Divider(color: Colors.red),
//                     const SizedBox(height: 20),
//                     ElevatedButton.icon(
//                       onPressed: () async {
//                         const url =
//                             'https://www.youtube.com/watch?v=zkJZ9H0Xp3k';
//                         if (await canLaunch(url)) {
//                           await launch(url);
//                         } else {
//                           throw 'Could not launch $url';
//                         }
//                       },
//                       icon: const Icon(
//                         Icons.play_arrow,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                       label: Text(
//                         'Watch on Youtube',
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 255, 17, 0),
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : Center(
//               child: Text(
//                 'Error loading video. Please check the video URL.',
//                 style: GoogleFonts.poppins(
//                   color: Colors.red,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//     );
//   }
// }
