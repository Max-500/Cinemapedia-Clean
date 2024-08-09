import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max_outlined), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.label_important_outlined), label: 'Categorias'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined), label: 'Favoritos'),
      ],
    );
  }
}