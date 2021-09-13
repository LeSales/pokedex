import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/repositories/favorites_repository.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
        title: Text('Favoritos'),
      ),
      body: Container(
        child: Consumer<FavoritesRepository>(
          builder: (context, favorites, child) {
            return favorites.list.isEmpty
                ? ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Ainda não há Pokémons favoritos'),
                  )
                : ListView.builder(
                    itemCount: favorites.list.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          showDetails(favorites.list[index]);
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
                                        favorites.list[index].img,
                                        height: 100,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            favorites.list[index].name,
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
                                                    FavoritesRepository>(
                                                  context,
                                                  listen: false,
                                                ).remove(favorites.list[index]);
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
