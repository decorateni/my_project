import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/movie_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieState = context.watch<MovieState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],git commit -m "2"
      ),
      body: movieState.isLoading
          ? const Center(child: CircularProgressIndicator()) // Стан завантаження
          : movieState.movies.isEmpty
          ? const Center(child: Text('No movies available.')) // Стан відсутності даних
          : ListView.builder(
        itemCount: movieState.movies.length,
        itemBuilder: (context, index) {
          final movie = movieState.movies[index];
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
      ),
    );
  }
}
