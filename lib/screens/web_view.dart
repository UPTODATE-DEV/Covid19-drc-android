import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as wb;

class WebView extends StatefulWidget {
  static const String rooteName = '/webpage';
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final Completer<wb.WebViewController> _controller =
      Completer<wb.WebViewController>();
  static bool _isLoadingPage;
  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return wb.WebView(
              initialUrl: 'https://covid19drc.uptodatedevelopers.com',
              javascriptMode: wb.JavascriptMode.unrestricted,
              onWebViewCreated: (wb.WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              javascriptChannels: <wb.JavascriptChannel>[
                snackbarJavascriptChannel(context),
              ].toSet(),
              onPageFinished: (finish) {
                setState(() {
                  _isLoadingPage = false;
                });
              },
            );
          },
        ),
      ),
    );
  }

  wb.JavascriptChannel snackbarJavascriptChannel(BuildContext context) {
    return wb.JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (wb.JavascriptMessage message) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
