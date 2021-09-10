import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PokemonRepository extends ChangeNotifier {
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: HttpLink('https://beta.pokeapi.co/graphql/v1beta'),
      //link: HttpLink('https://graphql-pokeapi.vercel.app/api/graphql'),
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    ),
  );
}
