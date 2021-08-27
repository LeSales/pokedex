import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pages/favorites_page.dart';
import 'package:pokedex/pages/my_pokemons_page.dart';
import 'package:pokedex/pages/pokemon_page.dart';
import 'package:pokedex/pages/sighted_page.dart';
import 'package:pokedex/pages/user_page.dart';

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
          MyPokemonsPage(),
          FavoritesPage(),
          SightedPage(),
          UserPage(),
        ],
        onPageChanged: setCurrentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Todos',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokémons',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: 'Vistos',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Config',
            backgroundColor: Colors.red,
          ),
        ],
        onTap: (page) {
          pageController.animateToPage(
            page,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: Colors.white,
      ),
    );
  }
}
