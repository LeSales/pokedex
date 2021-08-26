import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/repositories/favorites_repository.dart';
import 'package:pokedex/repositories/my_pokemons_repository.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/repositories/sighted_repository.dart';
import 'package:provider/provider.dart';

class PokemonPage extends StatefulWidget {
  PokemonPage({Key? key}) : super(key: key);

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final pokemons = PokemonRepository.pokemons;
  List<Pokemon> selected = [];
  late FavoritesRepository favorites;
  late MyPokemonsRepository myPokemons;
  late SightedRepository sighted;

  dynamicAppBar() {
    if (selected.isEmpty) {
      return AppBar(
        title: Text('Todos Pokémons'),
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
      body: ListView.separated(
        itemBuilder: (BuildContext context, int pokemon) {
          return ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            leading: (selected.contains(pokemons[pokemon]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Image.asset(pokemons[pokemon].icon),
                    width: 40,
                  ),
            title: Row(
              children: [
                Text(
                  pokemons[pokemon].name,
                ),
                if (favorites.list.contains(pokemons[pokemon]))
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 10,
                  ),
                if (myPokemons.list.contains(pokemons[pokemon]))
                  Icon(
                    Icons.catching_pokemon,
                    color: Colors.red,
                    size: 10,
                  ),
                if (sighted.list.contains(pokemons[pokemon]))
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.black87,
                    size: 10,
                  )
              ],
            ),
            trailing: Container(
              margin: EdgeInsets.only(bottom: 3),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                pokemons[pokemon].type1,
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            selected: selected.contains(pokemons[pokemon]),
            selectedTileColor: Colors.red[50],
            onLongPress: () {
              setState(() {
                (selected.contains(pokemons[pokemon]))
                    ? selected.remove(pokemons[pokemon])
                    : selected.add(pokemons[pokemon]);
              });
            },
            onTap: () {
              (selected.isEmpty)
                  ? showDetails(pokemons[pokemon])
                  : setState(() {
                      (selected.contains(pokemons[pokemon]))
                          ? selected.remove(pokemons[pokemon])
                          : selected.add(pokemons[pokemon]);
                    });
            },
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: pokemons.length,
      ),
      floatingActionButton: showButtons(),
    );
  }
}
