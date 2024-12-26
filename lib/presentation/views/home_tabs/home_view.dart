import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
    ref.read( popularMoviesProvider.notifier ).loadNextPage();
    ref.read( upcomingMoviesProvider.notifier ).loadNextPage();
    ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final bool initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies =  ref.watch(topRatedMoviesProvider);

    final slideShowMovies = ref.read(moviesSlideShowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          title: CustomAppbar(),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: slideShowMovies),
                  MoviesHorizontalListview(movies: nowPlayingMovies, title: 'En Cines', subtitle: 'Lunes 20', loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),),
                  MoviesHorizontalListview(movies: popularMovies, title: 'Populares', subtitle: 'Lunes 20', loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),),
                  MoviesHorizontalListview(movies: upcomingMovies, title: 'Proximamente', subtitle: 'Lunes 20', loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),),
                  MoviesHorizontalListview(movies: topRatedMovies, title: 'Mejores Valorados', subtitle: 'Lunes 20', loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),)

                ],
              );
            },
          childCount: 1
          ),
        )
      ],
    );
  }
}