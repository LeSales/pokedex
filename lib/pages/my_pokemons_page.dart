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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          leading: SizedBox(
                            child: Image.asset(myPokemons.list[index].icon),
                            width: 40,
                          ),
                          title: Row(
                            children: [
                              Text(
                                myPokemons.list[index].name,
                              ),
                            ],
                          ),
                          trailing: Container(
                            margin: EdgeInsets.only(bottom: 3),
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              myPokemons.list[index].type1,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          onTap: () {
                            showDetails(myPokemons.list[index]);
                          }),
                    );
                  },
                );
        }),
      ),
    );
  }
}
