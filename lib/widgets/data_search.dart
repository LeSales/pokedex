import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

class DataSearch extends SearchDelegate<String> {
  List<Pokemon> pokemons = [];
  late List<Pokemon> searchList = [];

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
                child: Text('icon')
                /*SizedBox(
                                        child: Image.network(
                                          pokes.list[index].icon,
                                        ),
                                        width: 40,
                                      )*/
                , //Image.network(suggestionList[index].icon),
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
