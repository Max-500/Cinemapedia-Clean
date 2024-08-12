import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {

  final MoviesDataSource dataSource;

  MovieRepositoryImpl({required this.dataSource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) => dataSource.getNowPlaying();
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) => dataSource.getPopular();
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) => dataSource.getTopRated();
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) => dataSource.getUpcoming();

}