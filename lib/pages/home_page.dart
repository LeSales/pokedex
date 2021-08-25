import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pages/favorites_page.dart';
import 'package:pokedex/pages/pokemon_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
  }

  setCurrentPage(page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          PokemonPage(),
          FavoritesPage(),
        ],
        onPageChanged: setCurrentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
        ],
        onTap: (page) {
          pageController.animateToPage(
            page,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
