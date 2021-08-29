import 'dart:convert';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonRepository extends ChangeNotifier {
  static List<Pokemon> pokemons = [];
  late List pokedex;
  List<Pokemon> _list = pokemons;

  PokemonRepository() {
    //fetchPokemonData();
  }

  UnmodifiableListView<Pokemon> get list => UnmodifiableListView(_list);

  void fetchPokemonData() {
    //var url = Uri.https("raw.githubusercontent.com","/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    var url = "https://pokeapi.co/api/v2/pokemon?limit=100&offset=0";
    //Uri.https("https://pokeapi.co/api/v2/", "pokemon?limit=10&offset=0");
    http.get(Uri.parse(url)).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['results'];

        pokedex.forEach((p) {
          pokemons.add(
            new Pokemon(
              //id: p['id'],
              //icon: p['img'],
              name: p['name'],
            ),
          );
        });
        notifyListeners();
      }
    });
  }

  //final HttpLink httplink = HttpLink('https://beta.pokeapi.co/graphql/v1beta');

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: HttpLink('https://beta.pokeapi.co/graphql/v1beta'),
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    ),
  );
}
