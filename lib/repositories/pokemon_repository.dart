import 'dart:convert';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonRepository extends ChangeNotifier {
  static List<Pokemon> pokemons = [];

  PokemonRepository() {
    fetchPokemonData();
  }

  UnmodifiableListView<Pokemon> get list => UnmodifiableListView(_list);

  late List pokedex;

  void fetchPokemonData() {
    var url = Uri.https("raw.githubusercontent.com",
        "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['pokemon'];
        pokedex.forEach((p) {
          pokemons.add(
            new Pokemon(
              id: p['id'],
              icon: p['img'],
              name: p['name'],
            ),
          );
        });
        notifyListeners();
      }
    });
  }

  List<Pokemon> _list = pokemons;
}
