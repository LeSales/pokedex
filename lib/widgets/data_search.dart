import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

class DataSearch extends SearchDelegate<String> {
  List<Pokemon> pokemons = [
    new Pokemon(
      id: 1,
      icon: 'images/bullbasaur.png',
      name: 'Bulbasaur',
      type1: 'Grass',
      type2: 'Poison',
      total: '318',
      hp: 45,
      attack: 49,
      defense: 49,
      spAtk: 65,
      spDef: 65,
      speed: 45,
      legendary: false,
    ),
    new Pokemon(
      id: 4,
      icon: 'images/charmander.png',
      name: 'Sharmander',
      type1: 'Fire',
      type2: '',
      total: '309',
      hp: 39,
      attack: 52,
      defense: 43,
      spAtk: 60,
      spDef: 50,
      speed: 65,
      legendary: false,
    ),
    new Pokemon(
      id: 9,
      icon: 'images/squirtle.png',
      name: 'Squirtle',
      type1: 'Water',
      type2: '',
      total: '314',
      hp: 44,
      attack: 48,
      defense: 65,
      spAtk: 50,
      spDef: 64,
      speed: 43,
      legendary: false,
    ),
  ];

  late List<Pokemon> searchList;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Pokemon> suggestionList = query.isEmpty
        ? searchList
        : pokemons
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => (suggestionList.isNotEmpty)
          ? ListTile(
              leading: SizedBox(
                child: Image.asset(suggestionList[index].icon),
                width: 40,
              ),
              title: Text(suggestionList[index].name),
            )
          : ListTile(
              leading: SizedBox(
                child: Icon(Icons.search_off),
                width: 40,
              ),
              title: Text('Nenhum Pokémon encontrado'),
            ),
      itemCount: suggestionList.length,
    );
  }
}
