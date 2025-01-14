import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  
  const BottomNavigation({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        navigationShell.goBranch(value, initialLocation: true);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max_outlined), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.label_important_outlined), label: 'Categorias'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined), label: 'Favoritos'),
      ],
    );
  }
}