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
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              leading: SizedBox(
                                child: Text('icon'),
                                width: 40,
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    favorites.list[index].name,
                                  ),
                                ],
                              ),
                              trailing: Container(
                                margin: EdgeInsets.only(bottom: 3),
                                padding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10,
                                ),
                                child: PopupMenuButton(
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: Text('Remover'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Provider.of<FavoritesRepository>(
                                            context,
                                            listen: false,
                                          ).remove(favorites.list[index]);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                showDetails(favorites.list[index]);
                              },
                            ),
                          ],
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
