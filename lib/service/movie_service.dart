import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:secondd_ui/model/constant.dart';
import 'package:secondd_ui/model/jsonmodel.dart';
import 'package:secondd_ui/model/movieresponse.dart';

class MovieService {
  final String baseUrl = 'https://api.themoviedb.org/3/movie/';
  final String apiKey = Constant.api; // Replace with your TMDB API key

  Future<MovieResponse> fetchMovies(String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl$category?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return MovieResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieResponse> fetchSimilarMovies(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl$id/similar?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return MovieResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieResponse> fetchTrendingMovies() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return MovieResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieDetailsResponse> fetchMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrl$movieId?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return MovieDetailsResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<MovieResponse> fetchGenre() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey',
      ),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return MovieResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<MovieVideo>> fetchMovieVideos(int movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrl$movieId/videos?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final videoResponse = MovieVideoResponse.fromJson(jsonData);
      return videoResponse.results;
    } else {
      throw Exception('Failed to load movie videos');
    }
  }

  Future<List<SearchResult>> searchMovies(String query) async {
    final response = await http
        .get(
          Uri.parse(
            'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query',
          ),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['results'] as List;
      return results.map((e) => SearchResult.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<List<Cast>> fetchMovieCast(int movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrl$movieId/credits?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final castResponse = CastResponse.fromJson(jsonData);
      return castResponse.cast;
    } else {
      throw Exception('Failed to load movie cast');
    }
  }
}
