import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/repositories/sighted_repository.dart';
import 'package:provider/provider.dart';

class SightedPage extends StatefulWidget {
  const SightedPage({Key? key}) : super(key: key);

  @override
  _SightedPageState createState() => _SightedPageState();
}

class _SightedPageState extends State<SightedPage> {
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
        title: Text('Vistos'),
      ),
      body: Container(
        child: Consumer<SightedRepository>(builder: (context, sighted, child) {
          return sighted.list.isEmpty
              ? ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Ainda não há Pokémons vistos'),
                )
              : ListView.builder(
                  itemCount: sighted.list.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        showDetails(sighted.list[index]);
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
                                      sighted.list[index].img,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          sighted.list[index].name,
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
                                              Provider.of<SightedRepository>(
                                                context,
                                                listen: false,
                                              ).remove(sighted.list[index]);
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
        }),
      ),
    );
  }
}
