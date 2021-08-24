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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pokédex'),
        ),
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
                (selecionados.length == 0)
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
        ));
  }
}
