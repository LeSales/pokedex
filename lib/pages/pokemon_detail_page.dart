import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

// ignore: must_be_immutable
class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;

  PokemonDetail({Key? key, required this.pokemon}) : super(key: key);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  var _controller = TextEditingController();
  String? obs = "";

  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.pokemon.name}'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Card(
                child: Center(
                  child: ListTile(
                    title: Text(
                      "Pokémon img",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        leading: Text("id: " + widget.pokemon.id.toString()),
                        title: Text(
                          widget.pokemon.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text("options"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          leading: Text("Obs:"),
                          title: Container(
                            child: (isEditing)
                                ? TextField(
                                    controller: _controller,
                                    maxLines: 3,
                                  )
                                : Text(
                                    obs!,
                                    maxLines: 3,
                                  ),
                            padding: EdgeInsets.all(5),
                          ),
                          trailing: (isEditing)
                              ? IconButton(
                                  icon: Icon(Icons.save),
                                  onPressed: () {
                                    setState(() {
                                      obs = _controller.text;
                                      print(isEditing);
                                      isEditing = !isEditing;
                                    });
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    setState(() {
                                      _controller.text = obs!;
                                      print(isEditing);
                                      isEditing = !isEditing;
                                    });
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
