import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/services/auth_service.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _MyPokemonsPageState createState() => _MyPokemonsPageState();
}

class _MyPokemonsPageState extends State<UserPage> {
  showDetails(Pokemon pokemon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PokemonDetail(
          pokemon: pokemon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: OutlinedButton(
            onPressed: () => context.read<AuthService>().logout(),
            style: OutlinedButton.styleFrom(
              primary: Colors.red,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Sair do App',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
