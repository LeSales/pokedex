import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonRepository extends ChangeNotifier {
  static List<Pokemon> pokemons = [];

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: HttpLink('https://beta.pokeapi.co/graphql/v1beta'),
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    ),
  );
}
