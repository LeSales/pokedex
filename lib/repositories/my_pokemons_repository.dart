import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedex/databases/db_firestore.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/services/auth_service.dart';

class MyPokemonsRepository extends ChangeNotifier {
  List<Pokemon> _list = [];
  late FirebaseFirestore db;
  late AuthService auth;

  MyPokemonsRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readMyPokemons();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readMyPokemons() async {
    if (auth.usuario != null && _list.isEmpty) {
      final snapshot =
          await db.collection('users/${auth.usuario!.uid}/mypokemons').get();

      snapshot.docs.forEach((doc) {
        Pokemon pokemon = PokemonRepository.pokemons
            .firstWhere((pokemon) => pokemon.name == doc.get(['name']));
        _list.add(pokemon);
        notifyListeners();
      });
    }
  }

  UnmodifiableListView<Pokemon> get list => UnmodifiableListView(_list);

  saveAll(Pokemon pokemon) async {
    if (!_list.any((current) => current.name == pokemon.name)) {
      _list.add(pokemon);
      await db
          .collection('users/${auth.usuario!.uid}/mypokemons')
          .doc(pokemon.name)
          .set({
        'id': pokemon.id,
        'icon': pokemon.icon,
        'name': pokemon.name,
      });
    }
    notifyListeners();
  }

  remove(Pokemon pokemon) async {
    await db
        .collection('users/${auth.usuario!.uid}/mypokemons')
        .doc(pokemon.name)
        .delete();
    _list.remove(pokemon);
    notifyListeners();
  }
}
