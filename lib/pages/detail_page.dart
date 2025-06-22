// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:secondd_ui/model/jsonmodel.dart';
// import 'package:secondd_ui/model/jsonmodel.dart';
import 'package:secondd_ui/model/movieresponse.dart';
import 'package:secondd_ui/pages/youtube_player.dart';
import 'package:secondd_ui/service/movie_service.dart';
import 'package:secondd_ui/widget/retry_pop.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.ids});
  final double ids;
  @override
  State<DetailPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Center(child: Text("Detail", textAlign: TextAlign.center)),
      //   // backgroundColor: Colors.transparent,
      //   foregroundColor: Colors.white,
      // ),
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: FutureBuilder(
        future: MovieService().fetchMovieDetails(widget.ids.toInt()),
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
          } else if (snapshot.hasData) {
            MovieDetailsResponse movieDetailsResponse = snapshot.data!;
            // You may need to adjust how you access movie details here
            var movieDetails = movieDetailsResponse.movie;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 300,
                    color: Colors.black,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          "https://image.tmdb.org/t/p/w500/${movieDetails.backdropPath}",
                          // height: 200,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,

                              colors: [Colors.transparent, Colors.black],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movieDetails.title,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${movieDetails.runtime} min ● ${movieDetails.releaseDate} ",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  Text(
                                    " ${movieDetails.voteAverage}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Chip(
                          label: Text(
                            movieDetails.genres.isNotEmpty
                                ? movieDetails.genres[0].name
                                : "Genre",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: Colors.blue[100],
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(width: 8),
                        Chip(
                          label: Text(
                            movieDetails.genres.isNotEmpty
                                ? movieDetails.genres[1].name
                                : "Genre",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: Colors.blue[100],
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action when the button is pressed
                        // print("Watch Now button pressed");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => YoutubePlayerVideo(
                                  movieId: widget.ids.toInt(),
                                  videoId: '${movieDetailsResponse.movie.id}',
                                ),
                          ),
                        );
                      },

                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,

                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      child: Text("Watch Now"),
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      movieDetails.overview,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Cast",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FutureBuilder(
                          future: MovieService().fetchMovieCast(
                            movieDetails.id,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "No cast found",
                                  style: TextStyle(fontSize: 10),
                                ),
                              );
                            } else if (snapshot.hasData) {
                              List<Cast> castResponse = snapshot.data!;

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children:
                                    castResponse.take(3).map((cast) {
                                      return Container(
                                        width: 100,
                                        padding: EdgeInsets.all(20),
                                        alignment: Alignment.center,

                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                "https://image.tmdb.org/t/p/w500/${cast.profilePath}",
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              cast.name,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'as ${cast.character}',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[400],
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Related Movies",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  FutureBuilder<MovieResponse>(
                    future: MovieService().fetchSimilarMovies(movieDetails.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "No related movies found",
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        MovieResponse similarMovies = snapshot.data!;
                        return GridView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          itemBuilder: (context, index) {
                            var movie = similarMovies.results[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DetailPage(
                                          ids: movie.id.toDouble(),
                                        ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      movie.title,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.results.isEmpty) {
                        return Center(
                          child: Text(
                            "No related movies found",
                            style: TextStyle(fontSize: 10),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
