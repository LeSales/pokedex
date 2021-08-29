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

  /* showDetails(Pokemon pokemon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PokemonDetail(
          pokemon: pokemon,
        ),
      ),
    );
  } */

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
    favorites = context.watch<FavoritesRepository>();
    myPokemons = context.watch<MyPokemonsRepository>();
    sighted = context.watch<SightedRepository>();

    return Query(
        options: QueryOptions(
          document: gql(queries.searchByName(query)),
        ),
        builder: (QueryResult? result, {fetchMore, refetch}) {
          return Container(
            child: Column(
              children: [
                if (result!.isLoading)
                  Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: result.data!["pokemon_v2_pokemon"].length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  leading: Text('icon')
                                  /*SizedBox(
                                          child: Image.network(
                                            pokes.list[index].icon,
                                          ),
                                          width: 40,
                                        )*/
                                  ,
                                  title: Row(
                                    children: [
                                      Text(
                                        result.data!["pokemon_v2_pokemon"]
                                            [index]['name'],
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
                                                          "pokemon_v2_pokemon"]
                                                      [index]['name'],
                                                  id: result.data![
                                                          "pokemon_v2_pokemon"]
                                                      [index]['id'],
                                                  height: result.data![
                                                          "pokemon_v2_pokemon"]
                                                      [index]['height'],
                                                  weight: result.data![
                                                          "pokemon_v2_pokemon"]
                                                      [index]['weight'],
                                                  /*  type: result.data![
                                                              "pokemon_v2_pokemon"]
                                                          [index][
                                                      'pokemon_v2_pokemontypes'], */
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
                                                          "pokemon_v2_pokemon"]
                                                      [index]['name'],
                                                  id: result.data![
                                                          "pokemon_v2_pokemon"]
                                                      [index]['id'],
                                                  height: result.data![
                                                          "pokemon_v2_pokemon"]
                                                      [index]['height'],
                                                  weight: result.data![
                                                          "pokemon_v2_pokemon"]
                                                      [index]['weight'],
                                                  /*  type: result.data![
                                                              "pokemon_v2_pokemon"]
                                                          [index][
                                                      'pokemon_v2_pokemontypes'], */
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
                                                          "pokemon_v2_pokemon"]
                                                      [index]['name'],
                                                  id: result.data![
                                                          "pokemon_v2_pokemon"]
                                                      [index]['id'],
                                                  height: result.data![
                                                          "pokemon_v2_pokemon"]
                                                      [index]['height'],
                                                  weight: result.data![
                                                          "pokemon_v2_pokemon"]
                                                      [index]['weight'],
                                                  /*  type: result.data![
                                                              "pokemon_v2_pokemon"]
                                                          [index][
                                                      'pokemon_v2_pokemontypes'], */
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
                                    /* showDetails(
                                      poke = Pokemon(
                                        name: result.data!['generation'][index]
                                            ['name'],
                                        id: result.data!['generation'][index]
                                            ['id'],
                                      ),
                                    ); */
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
}
