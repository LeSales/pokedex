import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pokemons = PokemonRepository.pokemons;
  List<Pokemon> selecionados = [];

  dynamicAppBar() {
    if (selecionados.isEmpty) {
      return AppBar(
        title: Text('Pokédex'),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionados = [];
            });
          },
        ),
        title: Text((selecionados.length == 1)
            ? '${selecionados.length} selecionado'
            : '${selecionados.length} selecionados'),
      );
    }
  }

  showButtons() {
    if (selecionados.isNotEmpty) {
      return Stack(
        children: [
          Align(
            alignment: Alignment(-0.8, 1),
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {},
              icon: Icon(Icons.remove_red_eye_outlined),
              label: Text(
                'VISTO',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(1, 1),
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {},
              icon: Icon(Icons.catching_pokemon),
              label: Text(
                'GOTCHA!',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: dynamicAppBar(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int pokemon) {
          return ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            leading: (selecionados.contains(pokemons[pokemon]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Image.asset(pokemons[pokemon].icon),
                    width: 40,
                  ),
            title: Text(pokemons[pokemon].name),
            trailing: Text(pokemons[pokemon].type1),
            selected: selecionados.contains(pokemons[pokemon]),
            selectedTileColor: Colors.red[50],
            onLongPress: () {
              setState(() {
                (selecionados.contains(pokemons[pokemon]))
                    ? selecionados.remove(pokemons[pokemon])
                    : selecionados.add(pokemons[pokemon]);
              });
            },
            onTap: () {
              (selecionados.isEmpty)
                  ? print("To do: go to description")
                  : setState(() {
                      (selecionados.contains(pokemons[pokemon]))
                          ? selecionados.remove(pokemons[pokemon])
                          : selecionados.add(pokemons[pokemon]);
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
