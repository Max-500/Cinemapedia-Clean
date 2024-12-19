import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function({ required String query });

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  List<Movie> initialMovies;
  final SearchMoviesCallback callback;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingString = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({required this.callback, required this.initialMovies});

  void clearStreams() {
    debouncedMovies.close();
  }

  void onQueryChanged(String query) {
    isLoadingString.add(true);
    if(_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if(query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }
      final movies = await callback(query: query);

      if (!debouncedMovies.isClosed) {
        debouncedMovies.add(movies);
      }

      initialMovies = movies;
      isLoadingString.add(false);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) => [
    StreamBuilder(
      initialData: false,
      stream: isLoadingString.stream, 
      builder: (context, snapshot) {
        if(snapshot.data ?? false) {
          return  SpinPerfect(
            duration: const Duration(seconds: 20),
            spins: 10,
            infinite: true,
            child: IconButton(onPressed: (){}, icon: const Icon(Icons.refresh_rounded))
          );
        }

        return FadeIn(
          animate: query.isNotEmpty,
          child: IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear_rounded))
        );

      },
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) =>  IconButton(onPressed: () {
    clearStreams();
    close(context, null);
  }, icon: const Icon(Icons.arrow_back_rounded));
  

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
  
  Widget buildResultsAndSuggestions() => StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(movie: movies[index], onMovieSelected: (context, movie) {
           clearStreams();
           close(context, movie); 
          }),
        );
      },
    );
}

typedef OnMovieSelected = Function(BuildContext context, Movie movie);
class _MovieItem extends StatelessWidget {
  final OnMovieSelected onMovieSelected;
  final Movie movie;

  const _MovieItem({required this.onMovieSelected, required this.movie});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final TextStyle? subtitleStyle = Theme.of(context).textTheme.titleMedium;
    final TextStyle? bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: screenWidth * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(movie.posterPath, loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),),
              ),
            ),
      
            const SizedBox(width: 10),
      
            SizedBox(
              width: screenWidth * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: subtitleStyle),
                  
                  movie.overview.length > 100 ? Text('${movie.overview.substring(0, 100)}...') : Text(movie.overview),
      
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(HumanFormats.number(movie.voteAverage, 1), style: bodyMedium!.copyWith(color: Colors.yellow.shade800)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}