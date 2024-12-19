import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/searchs/search_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextStyle? subtitleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10 ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon( Icons.movie_outlined, color: colors.primary, ),
              Text('Cinemapedia', style: subtitleStyle,),

              const Spacer(),

              IconButton(
                onPressed: () => showSearch(
                  query: ref.read(searchQueryProvider.notifier).state,
                  context: context,
                  delegate: SearchMovieDelegate(
                    initialMovies: ref.read(searchedMoviesProvider),
                    callback: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery
                  )
                ).then((movie) {
                 if(movie == null) return; 
                 if(context.mounted) context.push('/movie/${movie.id}');
                }), 
                icon: const Icon(Icons.search_outlined))
            ],
          ),
        ),
      )
    );
  }
}