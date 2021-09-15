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

    List<QueryResult> types;

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

    showTypes(List<QueryResult>? types) {
      types!.forEach((element) {
        Text(element.data!["pokemon_v2_type"]["name"]);
      });
    }

    return Query(
        options: QueryOptions(
          document: gql(queries.searchByName(query)),
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
                              itemCount:
                                  result.data!["pokemon_v2_pokemon"].length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    print("mostra pokemon");
                                    showDetails(
                                      poke = Pokemon(
                                        name: result.data!["pokemon_v2_pokemon"]
                                            [index]['name'],
                                        id: result.data!["pokemon_v2_pokemon"]
                                            [index]['id'],
                                        img:
                                            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${result.data!["pokemon_v2_pokemon"][index]['id']}.png",
                                        type: result.data!["pokemon_v2_pokemon"]
                                            [index]['pokemon_v2_pokemontypes'],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Stack(
                                      children: <Widget>[
                                        Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Image.network(
                                                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${result.data!["pokemon_v2_pokemon"][index]['id']}.png",
                                                  height: 100,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    return Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 30,
                                                              vertical: 25),
                                                      child: Icon(
                                                        Icons.search_off,
                                                        size: 40,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      result.data![
                                                              "pokemon_v2_pokemon"]
                                                          [index]['name'],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(result.data![
                                                                        "pokemon_v2_pokemon"]
                                                                    [index][
                                                                'pokemon_v2_pokemontypes'][0]
                                                            [
                                                            "pokemon_v2_type"]['name'])
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                PopupMenuButton(
                                                  icon: Icon(Icons.more_vert),
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      child: ListTile(
                                                        title: Text('Visto'),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          sighted.saveAll(
                                                            poke = Pokemon(
                                                              name: result.data![
                                                                      "pokemon_v2_pokemon"]
                                                                  [
                                                                  index]['name'],
                                                              id: result.data![
                                                                      "pokemon_v2_pokemon"]
                                                                  [index]['id'],
                                                              img:
                                                                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${result.data!["pokemon_v2_pokemon"][index]['id']}.png",
                                                              type: result.data![
                                                                          "pokemon_v2_pokemon"]
                                                                      [index][
                                                                  'pokemon_v2_pokemontypes'],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      child: ListTile(
                                                        title:
                                                            Text('Favoritar'),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          favorites.saveAll(
                                                            poke = Pokemon(
                                                              name: result.data![
                                                                      "pokemon_v2_pokemon"]
                                                                  [
                                                                  index]['name'],
                                                              id: result.data![
                                                                      "pokemon_v2_pokemon"]
                                                                  [index]['id'],
                                                              img:
                                                                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${result.data!["pokemon_v2_pokemon"][index]['id']}.png",
                                                              type: result.data![
                                                                          "pokemon_v2_pokemon"]
                                                                      [index][
                                                                  'pokemon_v2_pokemontypes'],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      child: ListTile(
                                                        title: Text('Gotcha!'),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          myPokemons.saveAll(
                                                            poke = Pokemon(
                                                              name: result.data![
                                                                      "pokemon_v2_pokemon"]
                                                                  [
                                                                  index]['name'],
                                                              id: result.data![
                                                                      "pokemon_v2_pokemon"]
                                                                  [index]['id'],
                                                              img:
                                                                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${result.data!["pokemon_v2_pokemon"][index]['id']}.png",
                                                              type: result.data![
                                                                          "pokemon_v2_pokemon"]
                                                                      [index][
                                                                  'pokemon_v2_pokemontypes'],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
