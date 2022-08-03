class BookMarkCar {
  int id;
  String number;
  String name;
  int userid;

  BookMarkCar(this.id, this.number, this.name, this.userid);

  factory BookMarkCar.fromJson(Map<String, dynamic> json) {
    int id = json["id"];
    String number = json["number"];
    String name = json["name"];
    int userid = json["user_id"];
    return BookMarkCar(id, number, name, userid);
  }
}
