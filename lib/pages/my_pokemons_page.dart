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
                      return GestureDetector(
                        onTap: () {
                          showDetails(myPokemons.list[index]);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Stack(
                            children: <Widget>[
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Image.network(
                                        myPokemons.list[index].img,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            myPokemons.list[index].name,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      PopupMenuButton(
                                        icon: Icon(Icons.more_vert),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: ListTile(
                                              title: Text('Remover'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                Provider.of<
                                                    MyPokemonsRepository>(
                                                  context,
                                                  listen: false,
                                                ).remove(
                                                    myPokemons.list[index]);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
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
