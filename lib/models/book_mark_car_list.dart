import 'book_mark_car.dart';

class BookMarkCarList {
  List<BookMarkCar> cars;

  BookMarkCarList(this.cars);

  factory BookMarkCarList.fromJson(List<dynamic> json) {
    List<BookMarkCar> cars = json.map((e) => BookMarkCar.fromJson(e)).toList();
    return BookMarkCarList(cars);
  }

  List<BookMarkCar> getCars() {
    return cars;
  }
}
