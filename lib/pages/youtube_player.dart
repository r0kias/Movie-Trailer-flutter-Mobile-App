import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secondd_ui/service/movie_service.dart';
import 'package:secondd_ui/widget/retry_pop.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerVideo extends StatefulWidget {
  const YoutubePlayerVideo({
    super.key,
    required this.videoId,
    required this.movieId,
  });
  final String videoId;
  final int movieId;

  @override
  State<YoutubePlayerVideo> createState() => _YoutubePlayerVideoState();
}

class _YoutubePlayerVideoState extends State<YoutubePlayerVideo> {
  @override
  void initState() {
    super.initState();

    // Lock orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Revert back to portrait orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Youtube Player"),
      //   backgroundColor: Colors.transparent,
      // ),
      body: FutureBuilder(
        future: MovieService().fetchMovieVideos(widget.movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RetryPop()),
              );
            });
            return Center(child: SizedBox.shrink());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No videos available"));
          } else {
            final video = snapshot.data!.firstWhere(
              (v) => v.type == "Trailer" || v.type == "Teaser",
              orElse: () => snapshot.data!.first,
            );
            if (video.key.isEmpty) {
              return Center(child: Text("No valid video key found"));
            }
            final youtubeUrl = YoutubePlayer.convertUrlToId(video.key);
            final controller = YoutubePlayerController(
              initialVideoId: youtubeUrl ?? widget.videoId,
              flags: YoutubePlayerFlags(autoPlay: true, mute: false),
            );

            return YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            );
          }
        },
      ),
    );
  }
}
