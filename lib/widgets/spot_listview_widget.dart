import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/models/book_mark_space_list.dart';
import 'package:provider/provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:parking_spot_frontend/providers/book_mark_provider.dart';
import '../models/book_mark_space_list.dart';
import '../services/bookmark_service.dart';


class SpotListView extends StatefulWidget {
  const SpotListView({Key? key}) : super(key: key);

  @override
  State<SpotListView> createState() => _SpotListViewState();
}

class _SpotListViewState extends State<SpotListView> {
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));
  late Future<BookMarkSpaceList> bookMarkModel;

  @override
  void initState() {
    super.initState();
    bookMarkModel = BookMarkService.getBookmarkSpaceList(
        context.read<UserProvider>().user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookMarkSpaceList>(
        future: bookMarkModel,
        builder:
            (BuildContext context, AsyncSnapshot<BookMarkSpaceList> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.88,
              child: ListView.builder(
                // 주차장 리스트
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.spaces.length,
                // itemCount: widget.data_spot.length, // 리스트의 길이만큼 ListTile 개수 설정
                itemBuilder: (context, i) {
                  // 필수 파라미터 2개
                  return Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    margin: EdgeInsets.fromLTRB(0, 6.5, 0, 6.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: CheckboxListTile(
                      title: Text(snapshot.data!.spaces[i].name,
                          style: TextStyle(fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      selected: context.watch<BookMarkProvider>().isCheckedSpot[i],
                      value : context.watch<BookMarkProvider>().isCheckedSpot[i],
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          context.read<BookMarkProvider>().isCheckedSpot[i] = value!;
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
        }
    );
  }
}