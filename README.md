# 🎬 Flutter Movie Trailer App

A beautiful Flutter movie application that fetches and displays data from [The Movie Database (TMDB)](https://www.themoviedb.org/). It includes features like movie search, trending/popular listings, detailed pages, cast lists, offline detection, and retry logic.

## ✨ Features

- 🔍 Search movies with real-time TMDB API results
- 🎞 View trending and popular movies
- 📽 Movie details with cast & overview
- 📶 Detect and respond to network connectivity changes
- 🔁 Automatic retry and refresh on connection restoration
- 🖼 Carousel and horizontal scrolling layouts

## 🛠 Technologies Used

- Flutter
- Dart
- [http](https://pub.dev/packages/http) – API calls
- [connectivity_plus](https://pub.dev/packages/connectivity_plus) – Internet connection handling
- [carousel_slider](https://pub.dev/packages/carousel_slider) – Movie slider
- [youtube_player_flutter](https://pub.dev/packages/youtube_player_flutter) – Embedded YouTube player
- [flutter_bloc] (optional if using for state management)

## 📦 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/yourusername/flutter-movie-app.git
cd flutter-movie-app
````

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Add your TMDB API key

Replace the value of `apiKey` in `lib/service/movie_service.dart`:

```dart
const String apiKey = 'YOUR_TMDB_API_KEY';
```

### 4. Run the app

```bash
flutter run
```

## 🔌 API

This app uses the following TMDB API endpoints:

* `GET /movie/now_playing`
* `GET /movie/popular`
* `GET /movie/{id}`
* `GET /search/movie`
* `GET /movie/{id}/credits`

## 🧠 Project Structure

```
lib/
├── main.dart
├── models/
│   └── movie.dart, movie_detail.dart, cast.dart
├── pages/
│   └── home_page.dart, detail_page.dart, search_page.dart
├── service/
│   └── movie_service.dart
├── widgets/
│   └── movie_card.dart, cast_list.dart, retry_overlay.dart
```

## ⚠️ Known Issues

* Ensure stable internet for API testing
* TMDB API has rate limits

## 📄 License

This project is licensed under the MIT License.

---

> Built with ❤️ using Flutter and TMDB API.
