import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/repositories/my_pokemons_repository.dart';
import 'package:provider/provider.dart';

class MyPokemonsPage extends StatefulWidget {
  const MyPokemonsPage({Key? key}) : super(key: key);

  @override
  _MyPokemonsPageState createState() => _MyPokemonsPageState();
}

class _MyPokemonsPageState extends State<MyPokemonsPage> {
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
        title: Text('Meus Pokémons'),
      ),
      body: Container(
        child: Consumer<MyPokemonsRepository>(
          builder: (context, myPokemons, child) {
            return myPokemons.list.isEmpty
                ? ListTile(
                    leading: Icon(Icons.catching_pokemon),
                    title: Text('Ainda não possui Pokémons'),
                  )
                : ListView.builder(
                    itemCount: myPokemons.list.length,
                    itemBuilder: (_, index) {
                      return Card(
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          leading: SizedBox(
                            child: Image.network(
                              myPokemons.list[index].img,
                              fit: BoxFit.contain,
                            ),
                            height: 200,
                          ),
                          title: Center(
                            child: Text(
                              myPokemons.list[index].name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          trailing: Container(
                            margin: EdgeInsets.only(bottom: 3),
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            child: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: ListTile(
                                    title: Text('Remover'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Provider.of<MyPokemonsRepository>(
                                        context,
                                        listen: false,
                                      ).remove(myPokemons.list[index]);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            showDetails(myPokemons.list[index]);
                          },
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
