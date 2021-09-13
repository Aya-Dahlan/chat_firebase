class CountryModel {
  String id;
  String name;
  List<dynamic> city;

  CountryModel(this.name, this.city);

  CountryModel.fromJason(Map map) {
    this.id = map['id'];
    this.name = map['name'];
    this.city = map['city'];
  }
}
