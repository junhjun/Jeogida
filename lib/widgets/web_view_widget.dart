import 'dart:async';

import 'package:flutter/material.dart';
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
              "http://3.37.217.255:8080/swagger-ui/index.html#/", // api page
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
          CircularProgressIndicator(value: loadingPercentage / 100.0)
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
          return Icon(Icons.replay);
        }
        return IconButton(
            onPressed: () async {
              print("reload");
              controller.reload();
            },
            icon: const Icon(Icons.replay));
      },
    );
  }
}
