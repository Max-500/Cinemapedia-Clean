import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsDatasource {

  Future<List<Actor>> getActorsByMovie({ required String movieID });

}