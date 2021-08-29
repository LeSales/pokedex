import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/repositories/favorites_repository.dart';
import 'package:pokedex/repositories/my_pokemons_repository.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/repositories/sighted_repository.dart';
import 'package:pokedex/widgets/data_search.dart';
import 'package:provider/provider.dart';
import '../graphql/queries.dart' as queries;

class PokemonPage extends StatefulWidget {
  PokemonPage({Key? key}) : super(key: key);
  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  List<Pokemon> selected = [];

  late FavoritesRepository favorites;
  late MyPokemonsRepository myPokemons;
  late SightedRepository sighted;
  List<Pokemon> pokemons = PokemonRepository.pokemons;

  dynamicAppBar() {
    if (selected.isEmpty) {
      return AppBar(
        title: Text('Todos Pokémons'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              clearSelected();
            });
          },
        ),
        title: Text((selected.length == 1)
            ? '${selected.length} selecionado'
            : '${selected.length} selected'),
      );
    }
  }

  clearSelected() {
    setState(() {
      selected = [];
    });
  }
/*
  showButtons() {
    if (selected.isNotEmpty) {
      return Stack(
        children: [
          Align(
            alignment: Alignment(1, 0.75),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                favorites.saveAll(selected);
                clearSelected();
              },
              child: Icon(Icons.star),
            ),
          ),
          Align(
            alignment: Alignment(1, 1),
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                myPokemons.saveAll(selected);
                clearSelected();
              },
              icon: Icon(Icons.catching_pokemon),
              label: Text(
                'GOTCHA!',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(1, 0.5),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                sighted.saveAll(selected);
                clearSelected();
              },
              child: Icon(Icons.remove_red_eye),
            ),
          )
        ],
      );
    } else {
      return null;
    }
  }
  */

  showDetails(Pokemon pokemon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PokemonDetail(
          pokemon: pokemon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    favorites = context.watch<FavoritesRepository>();
    myPokemons = context.watch<MyPokemonsRepository>();
    sighted = context.watch<SightedRepository>();

    return Scaffold(
      appBar: dynamicAppBar(),
      body: Query(
          options: QueryOptions(
            document: gql(queries.gen1),
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
                          itemCount: result.data!["generation"].length,
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
                                          result.data!['generation'][index]
                                              ['name'],
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
                                                    result.data![index]);
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              title: Text('Favoritar'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                favorites.saveAll(
                                                    result.data![index]);
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              title: Text('Gotcha!'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                myPokemons.saveAll(
                                                    result.data![index]);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showDetails(
                                          result.data!['generation'][index]);
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
          }),
      //floatingActionButton: showButtons(),
    );
  }
}
