import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/models/space.dart';
import 'package:parking_spot_frontend/providers/find_car_provider.dart';
import 'package:parking_spot_frontend/providers/find_space_provider.dart';
import 'package:parking_spot_frontend/screens/car_tab_view.dart';
import 'package:parking_spot_frontend/screens/pakinglot_tab_view.dart';
import 'package:provider/provider.dart';
import '../models/car.dart';
import '../providers/location_provider.dart';

class BookMarkView extends StatefulWidget {
  const BookMarkView({super.key});

  @override
  State<BookMarkView> createState() => _BookMarkViewState();
}

class _BookMarkViewState extends State<BookMarkView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    context.read<LocationProvider>().setLocationList();
  }

  Widget getTabBar() {
    return TabBar(
        controller: _tabController,
        tabs: const <Tab>[Tab(text: "차량"), Tab(text: "주차장")],
        indicatorWeight: 7,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.cyan,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'GmarketSans'),
        labelColor: Colors.black,
        unselectedLabelColor: Color(0xff818181));
  }

  @override
  Widget build(BuildContext context) {
    logger.i("BookMarkView build");

    List<Car> carList = context.watch<FindCarProvider>().bookMarkCarList;
    List<bool> carCheckList =
        carList.isNotEmpty ? List.filled(carList.length, false) : [];
    List<Space> spaceList =
        context.watch<FindSpaceProvider>().bookMarkSpaceList;
    List<bool> spaceCheckList =
        spaceList.isNotEmpty ? List.filled(spaceList.length, false) : [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(child: getTabBar()),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xffededed)),
        child: TabBarView(
          controller: _tabController,
          children: [
            CarTabView(checkedList: carCheckList),
            ParkingLotTabView(checkedList: spaceCheckList)
          ],
        ),
      ),
    );
  }
}
