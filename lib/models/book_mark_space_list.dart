import 'book_mark_space.dart';

class BookMarkSpaceList {
  List<BookMarkSpace> spaces;

  BookMarkSpaceList(this.spaces);

  factory BookMarkSpaceList.fromJson(List<dynamic> json) {
    List<BookMarkSpace> spaces =
        json.map((e) => BookMarkSpace.fromJson(e)).toList();
    return BookMarkSpaceList(spaces);
  }

  List<BookMarkSpace> getSpaces() {
    return spaces;
  }
}
