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
                    return Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        leading: SizedBox(
                          child: Image.network(
                            sighted.list[index].img,
                            fit: BoxFit.contain,
                          ),
                          height: 200,
                        ),
                        title: Center(
                          child: Text(
                            sighted.list[index].name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        trailing: Container(
                          margin: EdgeInsets.only(bottom: 3),
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: PopupMenuButton(
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
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          showDetails(sighted.list[index]);
                        },
                      ),
                    );
                  },
                );
        }),
      ),
    );
  }
}
