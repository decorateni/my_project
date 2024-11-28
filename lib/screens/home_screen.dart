import 'package:flutter/material.dart';
import '../repository/shared_prefs_user_repository.dart';
import '../services/api_service.dart';
import '../models/movie.dart';

class HomeScreen extends StatefulWidget {
  final SharedPrefsUserRepository userRepository;

  const HomeScreen({
    required this.userRepository,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> popularMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = fetchMovies();
  }

  Future<List<Movie>> fetchMovies() async {
    final apiService = ApiService();
    final moviesData = await apiService.fetchPopularMovies();

    // Явно приводимо кожен елемент до типу Map<String, dynamic>
    return moviesData
        .map((movie) => Movie.fromJson(movie as Map<String, dynamic>))
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await widget.userRepository.clearUserData();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: popularMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load movies: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies available.'));
          }

          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: movie.posterPath != null
                    ? Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: 50,
                  fit: BoxFit.cover,
                )
                    : const Icon(Icons.movie),
                title: Text(movie.title),
                subtitle: Text('Rating: ${movie.voteAverage}'),
              );
            },
          );
        },
      ),
    );
  }
}
