import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/repositories/favorites_repository.dart';
import 'package:pokedex/repositories/my_pokemons_repository.dart';
import 'package:pokedex/repositories/sighted_repository.dart';
import 'package:provider/provider.dart';
import '../graphql/queries.dart' as queries;

class DataSearch extends SearchDelegate<String> {
  late FavoritesRepository favorites;
  late MyPokemonsRepository myPokemons;
  late SightedRepository sighted;
  late List<Pokemon> pokemons = [];

  late Pokemon poke;

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
    favorites = context.watch<FavoritesRepository>();
    myPokemons = context.watch<MyPokemonsRepository>();
    sighted = context.watch<SightedRepository>();

    showDetails(Pokemon pokemon) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonDetail(
            pokemon: pokemon,
          ),
        ),
      );
    }

    return Query(
        options: QueryOptions(
          document: gql(queries.searchByNameNonOficial(query)),
        ),
        builder: (QueryResult? result, {fetchMore, refetch}) {
          return Container(
            child: Column(
              children: [
                if (result!.isLoading)
                  Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                else
                  Expanded(
                    child: Container(
                      child: (result.data!.isEmpty)
                          ? Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ListTile(
                                      title: Center(
                                          child: Text(
                                              "Nenhum Pokémon encontrado")),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        leading: Image.network(
                                            result.data!["pokemon"]['sprites']
                                                ['front_default']),
                                        title: Row(
                                          children: [
                                            Text(
                                              result.data!["pokemon"]['name'],
                                            ),
                                          ],
                                        ),
                                        trailing: Container(
                                          margin: EdgeInsets.only(bottom: 3),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          child: PopupMenuButton(
                                            icon: Icon(Icons.more_vert),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: ListTile(
                                                  title: Text('Visto'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    sighted.saveAll(
                                                      poke = Pokemon(
                                                        name: result.data![
                                                            "pokemon"]['name'],
                                                        id: result.data![
                                                            "pokemon"]['id'],
                                                        img: result.data![
                                                                    "pokemon"]
                                                                ["sprites"]
                                                            ['front_default'],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              PopupMenuItem(
                                                child: ListTile(
                                                  title: Text('Favoritar'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    favorites.saveAll(
                                                      poke = Pokemon(
                                                        name: result.data![
                                                            "pokemon"]['name'],
                                                        id: result.data![
                                                            "pokemon"]['id'],
                                                        img: result.data![
                                                                    "pokemon"]
                                                                ["sprites"]
                                                            ['front_default'],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              PopupMenuItem(
                                                child: ListTile(
                                                  title: Text('Gotcha!'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    myPokemons.saveAll(
                                                      poke = Pokemon(
                                                        name: result.data![
                                                            "pokemon"]['name'],
                                                        id: result.data![
                                                            "pokemon"]['id'],
                                                        img: result.data![
                                                                    "pokemon"]
                                                                ["sprites"]
                                                            ['front_default'],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          print("mostra pokemon");
                                          showDetails(
                                            poke = Pokemon(
                                              name: result.data!["pokemon"]
                                                  ['name'],
                                              id: result.data!["pokemon"]['id'],
                                              img: result.data!["pokemon"]
                                                  ["sprites"]['front_default'],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
              ],
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListTile(
              title: Center(child: Text("Nenhum Pokémon encontrado")),
            ),
          )
        ],
      ),
    );
  }
}
