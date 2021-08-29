import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

// ignore: must_be_immutable
class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;

  PokemonDetail({Key? key, required this.pokemon}) : super(key: key);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.pokemon.name}'),
      ),
      body: Container(),
    );
  }
}
