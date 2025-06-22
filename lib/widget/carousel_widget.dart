import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:secondd_ui/model/movieresponse.dart';
import 'package:secondd_ui/service/movie_service.dart';

class CarouselWidget extends StatelessWidget {
  CarouselWidget({super.key});

  // final widths = MediaQuery.of(context).size.width;
  final MovieService movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movieService.fetchMovies("now_playing"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final MovieResponse movieResponse = snapshot.data!;
          return CarouselSlider.builder(
            itemCount: 5,
            itemBuilder: (context, index, realIndex) {
              final movie = movieResponse.results[index];
              return buildImage(movie, index);
            },
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              height: 200,
              aspectRatio: 9 / 16,
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

Widget buildImage(movie, int index) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.black,
    ),
    width: double.infinity,
    child: Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 400,
          child: Image.network(
            "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [Colors.transparent, Colors.black.withOpacity(.3)],
            // ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                movie.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // Text(
              //   "movie description",
              //   style: TextStyle(
              //     fontSize: 12,
              //     fontWeight: FontWeight.w300,
              //     color: Colors.white,
              //   ),
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Text(
                    movie.voteAverage.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
