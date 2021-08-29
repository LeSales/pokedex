class Pokemon {
  String name;
  int id;
  //String icon;
  int height;
  int weight;
  // List<Object> type;
  String? obs;

  Pokemon(
      {required this.name,
      required this.id,
      //required this.icon,
      required this.height,
      required this.weight,
      this.obs
      //required this.type,
      });
}
