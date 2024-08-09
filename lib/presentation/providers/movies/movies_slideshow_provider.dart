import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<List<Movie>> moviesSlideShowProvider = Provider((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if( nowPlayingMovies.isEmpty ) return [];

  return nowPlayingMovies.sublist(0, 7);
});