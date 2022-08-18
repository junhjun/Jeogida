import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/widgets/web_view_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewZoomView extends StatefulWidget {
  const WebViewZoomView({Key? key}) : super(key: key);

  @override
  State<WebViewZoomView> createState() => _WebViewZoomViewState();
}

class _WebViewZoomViewState extends State<WebViewZoomView> {
  final controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
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
        body: Container(child: WebViewStack(controller: controller)),
      ),
    );
  }
}
