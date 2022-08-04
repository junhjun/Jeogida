import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/utility/menu.dart';
import 'package:parking_spot_frontend/widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  static const String routeName = "/home";

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        title: "Home Page",
      ),
      bottomNavigationBar: MyMenu(selectedIndex: 0),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
