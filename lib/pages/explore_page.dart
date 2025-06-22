import 'package:flutter/material.dart';
import 'package:secondd_ui/model/movieresponse.dart';
import 'package:secondd_ui/widget/moviecard.dart';
import 'package:secondd_ui/service/movie_service.dart';
import 'package:secondd_ui/widget/retry_pop.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            category.isNotEmpty
                ? Text(category)
                : Text('Explore', style: TextStyle(fontSize: 12)),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: MovieService().fetchMovies(category),
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
              MovieResponse movieResponse = snapshot.data!;
              return GridView.builder(
                itemCount: movieResponse.results.length,
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
      ),
    );
  }
}
