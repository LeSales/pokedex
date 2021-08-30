import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/repositories/favorites_repository.dart';
import 'package:pokedex/repositories/my_pokemons_repository.dart';
import 'package:pokedex/repositories/sighted_repository.dart';
import 'package:pokedex/widgets/data_search.dart';
import 'package:provider/provider.dart';

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
  late List<Pokemon> pokemons;

  late Pokemon poke;

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

    int caugthCount = myPokemons.list.length;
    int favoritesCount = favorites.list.length;
    int sightedCount = sighted.list.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/pokedex.png'), fit: BoxFit.contain),
        ),
        child: Align(
          alignment: Alignment(-0.6, 0.5),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pokémons'),
                Text('Capturados: $caugthCount'),
                Text('Vistos: $sightedCount'),
                Text('Favoritos: $favoritesCount'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
