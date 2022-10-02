class Car {
  int id;
  String number;
  String name;
  int userId;

  Car(this.id, this.number, this.name, this.userId);

  factory Car.fromJson(Map<String, dynamic> json) {
    int id = json["id"];
    String number = json["number"];
    String name = json["name"];
    int userId = json["user_id"];
    return Car(id, number, name, userId);
  }

  @override
  String toString() {
    return "id : $id, number : $number, name : $name, userId: $userId\n";
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Car &&
            other.id == id &&
            other.number == number &&
            other.name == name &&
            other.userId == userId);
  }
}
