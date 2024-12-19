import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final searchMoviesCallback = ref.read(movieRepositoryProvider).searchMovies;
  return SearchedMoviesNotifier(searchMoviesCallback: searchMoviesCallback, ref: ref);
});

typedef SearchMoviesCallback = Future<List<Movie>> Function({ required String query });
class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMoviesCallback;
  final Ref ref;

  SearchedMoviesNotifier({required this.searchMoviesCallback, required this.ref}):super([]);

  Future<List<Movie>> searchMoviesByQuery({required String query}) async {
    ref.read(searchQueryProvider.notifier).update((state) => query);
    final movies = await searchMoviesCallback(query: query);
    state = movies;
    return movies;
  }

}