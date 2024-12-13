import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '59a1f6391dfb5c9f4e8cd9631dcd8dec';

  Future<List<dynamic>> fetchPopularMovies() async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey');
    print('Fetching movies from: $url'); // Лог для перевірки
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      print('Fetched movies: ${data['results']}'); // Лог даних
      return data['results'] as List<dynamic>;
    } else {
      throw Exception('Failed to load movies. Status code: ${response.statusCode}');
    }
  }
}
