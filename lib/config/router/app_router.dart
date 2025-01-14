import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/home_tabs/categories_view.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {

  AppRouter();

  //* Navigator Keys
  static final rootNavigator = GlobalKey<NavigatorState>();
  static final homeNavigator = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: rootNavigator,
    routes: [
      
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => HomeScreen(navigationShell: navigationShell),
        branches: [

          StatefulShellBranch(
            navigatorKey: homeNavigator,
            routes: [
              GoRoute(path: '/', name: HomeScreen.name, builder: (context, state) => const HomeView()),
            ]
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(path: '/categorias', name: 'Categorias', builder: (context, state) => const CategoriesView()),
            ]
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(path: '/favoritos', name: 'Favoritos', builder: (context, state) => const FavoritesView())
            ]
          )
      
        ]
      ),

      GoRoute(
        path: '/movie/:id',
        name: MovieScreen.name, 
        builder: (context, state) => MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id')
      )
    ]
  );
}