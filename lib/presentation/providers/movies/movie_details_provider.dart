import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider = StateNotifierProvider<MoviesMapNotifier, Map<String, Movie>>((ref) {
  final getMovieDetailsCallback = ref.watch(movieRepositoryProvider).getMovieById;
  return MoviesMapNotifier(getMovieCallback: getMovieDetailsCallback);
});

typedef GetMovieCallback = Future<Movie>Function({ required String id });
class MoviesMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovieCallback;

  MoviesMapNotifier({required this.getMovieCallback}):super({});

  Future<void> loadMovie(String movieID) async {
    if(state[movieID] != null) return;
    final movie = await getMovieCallback(id: movieID);

    state = {
      ...state, movieID: movie
    };
  }

}