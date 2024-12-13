import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';

class MovieState extends ChangeNotifier {
  final ApiService apiService;

  List<Movie> movies = [];
  bool isLoading = false;

  MovieState(this.apiService) {
    fetchMovies(); // Викликаємо при ініціалізації
  }

  Future<void> fetchMovies() async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await apiService.fetchPopularMovies();
      movies = data.map((json) => Movie.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      movies = []; // Якщо помилка, залишаємо порожній список
      print('Error fetching movies: $e'); // Додано для діагностики
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
