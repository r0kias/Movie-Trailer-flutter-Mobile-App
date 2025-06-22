import 'package:secondd_ui/model/jsonmodel.dart';

class MovieResponse {
  final int page;
  final List<Movie> results;

  MovieResponse({required this.page, required this.results});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Movie> movieList = list.map((e) => Movie.fromJson(e)).toList();

    return MovieResponse(page: json['page'], results: movieList);
  }

  get movie => null;

  Map<String, dynamic> toJson() => {
    'page': page,
    'results': results.map((e) => e.toJson()).toList(),
  };
}

class GenreResponse {
  final List<Genre> genres;

  GenreResponse({required this.genres});

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    var list = json['genres'] as List;
    List<Genre> genreList = list.map((e) => Genre.fromJson(e)).toList();

    return GenreResponse(genres: genreList);
  }

  Map<String, dynamic> toJson() => {
    'genres': genres.map((e) => e.toJson()).toList(),
  };
}

class MovieDetailsResponse {
  final MovieDetail movie;

  MovieDetailsResponse({required this.movie});

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailsResponse(movie: MovieDetail.fromJson(json));
  }

  Map<String, dynamic> toJson() => {'movie': movie.toJson()};
}

class MovieVideoResponse {
  final List<MovieVideo> results;

  MovieVideoResponse({required this.results});

  factory MovieVideoResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<MovieVideo> videoList =
        list.map((e) => MovieVideo.fromJson(e)).toList();

    return MovieVideoResponse(results: videoList);
  }

  Map<String, dynamic> toJson() => {
    'results': results.map((e) => e.toJson()).toList(),
  };
}

class SearchResponse {
  final int page;
  final List<SearchResult> results;
  final int totalPages;
  final int totalResults;

  SearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    page: json['page'],
    results: List<SearchResult>.from(
      json['results'].map((item) => SearchResult.fromJson(item)),
    ),
    totalPages: json['total_pages'],
    totalResults: json['total_results'],
  );

  Map<String, dynamic> toJson() => {
    'page': page,
    'results': results.map((x) => x.toJson()).toList(),
    'total_pages': totalPages,
    'total_results': totalResults,
  };
}

class CastResponse {
  final int id;
  final List<Cast> cast;

  CastResponse({required this.id, required this.cast});

  factory CastResponse.fromJson(Map<String, dynamic> json) {
    return CastResponse(
      id: json['id'],
      cast: (json['cast'] as List).map((item) => Cast.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'cast': cast.map((c) => c.toJson()).toList()};
  }
}
