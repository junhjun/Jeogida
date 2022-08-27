class CarInfo {
  int id;
  int number;
  bool isParked;
  String changedAt;
  int parkingLotId;
  int carId;

  CarInfo(this.id, this.number, this.isParked, this.changedAt,
      this.parkingLotId, this.carId);

  factory CarInfo.fromJson(Map<String, dynamic> json) {
    int id = json["id"];
    int number = json["number"];
    bool isParked = json["is_parked"];
    String changedAt = json["changed_at"];
    int parkingLotId = json["parking_lot_id"];
    int carId = json["car_id"];
    return CarInfo(id, number, isParked, changedAt, parkingLotId, carId);
  }

  @override
  String toString() {
    return "id : ${id}\n" +
        "number : ${number}\n" +
        "isParked : ${isParked}\n" +
        "changedAt : ${changedAt}\n" +
        "parkingLotId : ${parkingLotId}\n" +
        "carId : ${carId}";
  }
}
