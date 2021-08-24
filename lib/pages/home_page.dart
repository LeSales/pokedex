import 'package:flutter/material.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokemons = PokemonRepository.pokemons;

    return Scaffold(
        appBar: AppBar(
          title: Text('Pokédex'),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int pokemon) {
            return ListTile(
              leading: Image.asset(pokemons[pokemon].icon),
              title: Text(pokemons[pokemon].name),
              trailing: Text(pokemons[pokemon].type1),
            );
          },
          padding: EdgeInsets.all(16),
          separatorBuilder: (_, __) => Divider(),
          itemCount: pokemons.length,
        ));
  }
}
