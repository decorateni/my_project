import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '59a1f6391dfb5c9f4e8cd9631dcd8dec';
  static const String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1OWExZjYzOTFkZmI1YzlmNGU4Y2Q5NjMxZGNkOGRlYyIsIm5iZiI6MTczMjc4OTYzNy45OTY2MTM3LCJzdWIiOiI2NzQ4NDQ5NzJmNDNiMTUwYjliMDg5YzIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.ZQA2IUytAGEZ79WoHS7dZ3rXg3R-B1aNt87cW_lTFlk';

  Future<List<dynamic>> fetchPopularMovies() async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['results'] as List<dynamic>; // Явне приведення типу
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
