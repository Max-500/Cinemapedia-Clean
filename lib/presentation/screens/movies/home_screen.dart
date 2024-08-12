import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar:  BottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

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