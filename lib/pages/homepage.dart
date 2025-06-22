// import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:secondd_ui/model/movieresponse.dart';
import 'package:secondd_ui/pages/detail_page.dart';
import 'package:secondd_ui/pages/explore_page.dart';
// import 'package:secondd_ui/pages/moviedetail.dart';
import 'package:secondd_ui/pages/search_page.dart';
import 'package:secondd_ui/service/movie_service.dart';
// import 'package:secondd_ui/widget/carousel_widget.dart';
import 'package:secondd_ui/widget/moviecard.dart';
import 'package:secondd_ui/widget/retry_pop.dart';
// import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // final latestMovie = ["movie1", "movie2", "movie3", "movie4", "movie5"];
  final MovieService movieService = MovieService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(
          "Movie trailer",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

        actions: [
          GestureDetector(
            onTap: () {
              SearchPage();
            },
            child: SizedBox(
              width: 44,
              height: 44,

              // decoration: BoxDecoration(color: Colors.red[600]),
              child: Icon(Icons.search, size: 24, color: Colors.white),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            setState(() {
              movieService.fetchTrendingMovies();
              movieService.fetchMovies('upcoming');
              movieService.fetchMovies('popular');
            });
          });
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Trending",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) {
                    //           return ExplorePage(category: "trending");
                    //         },
                    //       ),
                    //     );
                    //   },
                    //   child: Text(
                    //     "See All",
                    //     style: TextStyle(
                    //       fontSize: 14,
                    //       color: Colors.grey[400],
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // CarouselWidget(),
              FutureBuilder(
                future: movieService.fetchTrendingMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RetryPop(),
                        ),
                      );
                    });
                    // Return a temporary placeholder
                    return const SizedBox.shrink();
                  } else if (snapshot.hasData) {
                    MovieResponse movieResponse = snapshot.data!;
                    return CarouselSlider.builder(
                      itemCount: movieResponse.results.length,
                      itemBuilder: (context, index, realIndex) {
                        var movie = movieResponse.results[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailPage(
                                    ids:
                                        movieResponse.results[index].id
                                            .toDouble(),
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            width: double.infinity,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),

                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/${movie.backdropPath}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.8),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: Text(
                                    movie.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        height: 200,
                        aspectRatio: 9 / 16,
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Upcoming",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ExplorePage(category: 'upcoming');
                            },
                          ),
                        );
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: movieService.fetchMovies("upcoming"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: SizedBox.shrink());
                  } else if (snapshot.hasData) {
                    MovieResponse movieResponse = snapshot.data!;
                    return GridView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        var movie = movieResponse.results[index];
                        return MovieCard(
                          ids: movie.id.toDouble(),
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                          // title: movie.title,
                          // subtitle: movie.overview,
                          // rating: movie.voteAverage,
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Popular",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ExplorePage(category: "popular");
                            },
                          ),
                        );
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: movieService.fetchMovies("popular"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: SizedBox.shrink());
                  } else if (snapshot.hasData) {
                    MovieResponse movieResponse = snapshot.data!;
                    return GridView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        var movie = movieResponse.results[index];
                        return MovieCard(
                          ids: movie.id.toDouble(),
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                          // title: movie.title,
                          // subtitle: movie.overview,
                          // rating: movie.voteAverage,
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void retryResponse(context) {
  var push = Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return SearchPage();
      },
    ),
  );
}
