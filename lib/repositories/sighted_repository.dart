import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedex/databases/db_firestore.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/services/auth_service.dart';

class SightedRepository extends ChangeNotifier {
  List<Pokemon> _list = [];
  late FirebaseFirestore db;
  late AuthService auth;

  SightedRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readFavorites();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readFavorites() async {
    if (auth.usuario != null && _list.isEmpty) {
      final snapshot =
          await db.collection('users/${auth.usuario!.uid}/sighted').get();

      snapshot.docs.forEach((doc) {
        Pokemon pokemon = PokemonRepository.pokemons
            .firstWhere((pokemon) => pokemon.name == doc.get('name'));
        _list.add(pokemon);
        notifyListeners();
      });
    }
  }

  UnmodifiableListView<Pokemon> get list => UnmodifiableListView(_list);

  saveAll(List<Pokemon> pokemons) {
    pokemons.forEach((pokemon) async {
      if (!_list.any((current) => current.name == pokemon.name)) {
        _list.add(pokemon);
        await db
            .collection('users/${auth.usuario!.uid}/sighted')
            .doc(pokemon.name)
            .set({
          'id': pokemon.id,
          'icon': pokemon.icon,
          'name': pokemon.name,
          'type1': pokemon.type1,
          'type2': pokemon.type2,
          'total': pokemon.total,
          'hp': pokemon.hp,
          'attack': pokemon.attack,
          'defense': pokemon.defense,
          'spAtk': pokemon.spAtk,
          'spDef': pokemon.spDef,
          'speed': pokemon.speed,
          'legendary': pokemon.legendary,
        });
      }
    });
    notifyListeners();
  }

  remove(Pokemon pokemon) async {
    await db
        .collection('users/${auth.usuario!.uid}/sighted')
        .doc(pokemon.name)
        .delete();
    _list.remove(pokemon);
    notifyListeners();
  }
}
