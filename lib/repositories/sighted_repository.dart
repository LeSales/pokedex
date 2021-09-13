import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedex/databases/db_firestore.dart';
import 'package:pokedex/models/pokemon.dart';
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
        Pokemon pokemon = Pokemon(
          name: doc.get('name'),
          id: doc.get('id'),
          img: doc.get('img'),
          //type: doc.get('type'),
          obs: doc.get('obs'),
        );
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
          .collection('users/${auth.usuario!.uid}/sighted')
          .doc(pokemon.name)
          .set({
        'name': pokemon.name,
        'id': pokemon.id,
        'img': pokemon.img,
        'obs': pokemon.obs,
      });
    }
    notifyListeners();
  }

  saveObs(Pokemon pokemon) async {
    await db
        .collection('users/${auth.usuario!.uid}/sighted')
        .doc(pokemon.name)
        .set({
      'name': pokemon.name,
      'id': pokemon.id,
      'img': pokemon.img,
      'obs': pokemon.obs,
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
