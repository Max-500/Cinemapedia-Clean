import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB movie) => Movie(
      adult: movie.adult,
      backdropPath: movie.backdropPath != '' ? 
        'https://image.tmdb.org/t/p/w500${ movie.backdropPath }' : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
      genreIds: movie.genreIds.map((e) => e.toString()).toList(),
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      popularity: movie.popularity,
      posterPath: movie.posterPath != '' ? 
      'https://image.tmdb.org/t/p/w500${ movie.posterPath }' : 'no-poster',
      releaseDate: movie.releaseDate,
      title: movie.title,
      video: movie.video,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount);

  static Movie movieDetailsToEntity(MovieDetails movieDetails) => Movie(
    adult: movieDetails.adult, 
    backdropPath: movieDetails.backdropPath != '' ? 
        'https://image.tmdb.org/t/p/w500${ movieDetails.backdropPath }' : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg', 
    genreIds: movieDetails.genres.map((e) => e.name).toList(), 
    id: movieDetails.id, 
    originalLanguage: movieDetails.originalLanguage, 
    originalTitle: movieDetails.originalTitle, 
    overview: movieDetails.overview, 
    popularity: movieDetails.popularity, 
    posterPath: movieDetails.posterPath != '' ? 
      'https://image.tmdb.org/t/p/w500${ movieDetails.posterPath }' : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg', 
    releaseDate: movieDetails.releaseDate, 
    title: movieDetails.title, 
    video: movieDetails.video, 
    voteAverage: movieDetails.voteAverage, 
    voteCount: movieDetails.voteCount
  );
}
