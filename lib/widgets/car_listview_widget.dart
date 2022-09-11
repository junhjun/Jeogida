import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:parking_spot_frontend/providers/book_mark_provider.dart';
import '../models/book_mark_car_list.dart';
import '../services/bookmark_service.dart';


class CarListView extends StatefulWidget {
  const CarListView({Key? key}) : super(key: key);

  @override
  State<CarListView> createState() => _CarListViewState();
}

class _CarListViewState extends State<CarListView> {
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));
  late Future<BookMarkCarList> bookMarkModel;

  @override
  void initState() {
    super.initState();
    bookMarkModel = BookMarkService.getBookmarkCarList(
        context.read<UserProvider>().user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookMarkCarList>(
      future: bookMarkModel,
      builder:
          (BuildContext context, AsyncSnapshot<BookMarkCarList> snapshot) {
        if (snapshot.hasData) {
          print("-------");
          for(int i=0; i<snapshot.data!.cars.length; i++) {
            print(context.read<BookMarkProvider>().isCheckedCar[i]);
          }
          print("-------");
          return Container(
            width: MediaQuery.of(context).size.width * 0.88,
            child: ListView.builder(
              // 차량 리스트
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.cars.length, // ListTile 개수
              itemBuilder: (context, i) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  margin: EdgeInsets.fromLTRB(0, 6.5, 0, 6.5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: CheckboxListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.data!.cars[i].name,
                            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                        Text(snapshot.data!.cars[i].number,
                            style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w400))
                      ],
                    ),
                    selected: context.watch<BookMarkProvider>().isCheckedCar[i],
                    value : context.watch<BookMarkProvider>().isCheckedCar[i],
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool? value) {
                      setState(() {
                        context.read<BookMarkProvider>().isCheckedCar[i] = value!;
                      });
                    },
                    activeColor: Colors.cyan,
                    checkboxShape: CircleBorder(),
                  ),
                );
              },
            ),
          );
        }
        else if (snapshot.hasError) {
          logger.e("error : ${snapshot.error}");
          return Text("error : ${snapshot.error}"); // Error
        } else {
          return const CircularProgressIndicator();
        }
      });
  }
}