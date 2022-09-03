import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/screens/find_car_view.dart';
import 'package:parking_spot_frontend/widgets/web_view_widget.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../providers/find_car_provider.dart';

class WebViewZoomView extends StatefulWidget {
  int? mapId;
  WebViewZoomView({required this.mapId, Key? key}) : super(key: key);

  @override
  State<WebViewZoomView> createState() => _WebViewZoomViewState();
}

class _WebViewZoomViewState extends State<WebViewZoomView> {
  final controller = Completer<WebViewController>();
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  Widget build(BuildContext context) {
    String initial;
    if (widget.mapId != null) {
      initial =
          "http://ec2-3-37-217-255.ap-northeast-2.compute.amazonaws.com:8081/${widget.mapId}";
    } else {
      initial =
          "http://ec2-3-37-217-255.ap-northeast-2.compute.amazonaws.com:8081";
    }
    logger.i("webview zoom url : $initial");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: WebView(
          initialUrl: initial,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
