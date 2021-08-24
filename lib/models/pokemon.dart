class Pokemon {
  int id;
  String icon;
  String name;
  String type1;
  String type2;
  String total;
  int hp;
  int attack;
  int defense;
  int spAtk;
  int spDef;
  int speed;
  bool legendary;

  Pokemon({
    required this.id,
    required this.icon,
    required this.name,
    required this.type1,
    required this.type2,
    required this.total,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAtk,
    required this.spDef,
    required this.speed,
    required this.legendary,
  });
}
