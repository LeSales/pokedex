class Pokemon {
  String name;
  int id;
  String img;
  String? obs;
  //List<Object> type;

  Pokemon({
    required this.name,
    required this.id,
    required this.img,
    //required this.type,
    this.obs,
  });
}
