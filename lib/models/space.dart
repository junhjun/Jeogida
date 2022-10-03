class Space {
  int id;
  String name;
  int total;

  Space(this.id, this.name, this.total);

  factory Space.fromJson(Map<String, dynamic> json) {
    int id = json["id"];
    String name = json["name"];
    int total = json["total"];
    return Space(id, name, total);
  }

  @override
  String toString() {
    return "id : $id, name : $name, total: $total\n";
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Space &&
            other.id == id &&
            other.name == name &&
            other.total == total);
  }
}
