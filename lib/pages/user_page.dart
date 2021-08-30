import 'package:flutter/material.dart';
import 'package:pokedex/services/auth_service.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _MyPokemonsPageState createState() => _MyPokemonsPageState();
}

class _MyPokemonsPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: OutlinedButton(
            onPressed: () => {
              context.read<AuthService>().logout(),
            },
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
