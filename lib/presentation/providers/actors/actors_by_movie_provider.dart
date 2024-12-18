import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final getActorsCallback = ref.watch(actorRepositoryProvider).getActorsByMovie;
  return ActorsByMovieNotifier(getActorsCallback: getActorsCallback);
});

typedef GetActorsCallback = Future<List<Actor>>Function({ required String movieID });
class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActorsCallback;

  ActorsByMovieNotifier({required this.getActorsCallback}):super({});

  Future<void> loadActors(String movieID) async {
    if(state[movieID] != null) return;
    final actors = await getActorsCallback(movieID: movieID);

    state = {
      ...state, movieID: actors
    };
  }

}