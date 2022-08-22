class BookMarkSpace {
  int id;
  String name;
  int total;

  BookMarkSpace(this.id, this.name, this.total);

  factory BookMarkSpace.fromJson(Map<String, dynamic> json) {
    int id = json["id"];
    String name = json["name"];
    int total = json["total"];
    return BookMarkSpace(id, name, total);
  }
}
