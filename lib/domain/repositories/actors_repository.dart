import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsRepository {

  Future<List<Actor>> getActorsByMovie({ required String movieID });

}