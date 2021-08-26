import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:pokedex/models/pokemon.dart';

class SightedRepository extends ChangeNotifier {
  List<Pokemon> _list = [];

  UnmodifiableListView<Pokemon> get list => UnmodifiableListView(_list);

  saveAll(List<Pokemon> pokemons) {
    pokemons.forEach((pokemon) {
      if (!_list.contains(pokemon)) _list.add(pokemon);
    });
    notifyListeners();
  }

  remove(Pokemon pokemon) {
    _list.remove(pokemon);
    notifyListeners();
  }
}
