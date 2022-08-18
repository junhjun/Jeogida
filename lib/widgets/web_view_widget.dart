import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl:
              "http://ec2-3-37-217-255.ap-northeast-2.compute.amazonaws.com:8081/5", // webview initial page
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progess) {
            setState(() {
              loadingPercentage = progess;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebViewCreated: (webViewController) {
            widget.controller.complete(webViewController);
          },
        ),
        if (loadingPercentage < 100)
          Center(
              child:
                  CircularProgressIndicator(value: loadingPercentage / 100.0))
      ],
    );
  }
}

class WebViewControls extends StatelessWidget {
  const WebViewControls({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done ||
            controller == null) {
          return const Icon(Icons.replay);
        }
        return IconButton(
            onPressed: () async {
              logger.i("refresh webview");
              controller.reload();
            },
            icon: const Icon(Icons.replay));
      },
    );
  }
}
