import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covid19_drc/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart' as wb;
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  static const String rooteName = '/webpage';
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final Completer<wb.WebViewController> _controller =
      Completer<wb.WebViewController>();

  bool connected = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  Widget notDataConnection() {
    return connected
        ? Container()
        : notConnected(
            context: context,
            title: "Connexion impossible",
            subtitle: "Veuillez vérifier votre connexion internet",
            img: 'assets/images/Findfood_No_Network.png',
            onRetry: () {},
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (_) {
            return OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                connected = connectivity != ConnectivityResult.none;
                return Scaffold(
                  body: Stack(
                    fit: StackFit.expand,
                    children: [
                      wb.WebView(
                        initialUrl: 'https://covid19drc.uptodatedevelopers.com',
                        javascriptMode: wb.JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (wb.WebViewController webViewController) {
                          // print(_controller.future.);
                          _controller.complete(webViewController);
                        },
                        javascriptChannels: <wb.JavascriptChannel>[
                          snackbarJavascriptChannel(context),
                        ].toSet(),
                        onPageFinished: (finish) {
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                      notDataConnection(),
                      isLoading
                          ? Center(
                              child: Container(
                                height: 100.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                alignment: FractionalOffset.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SpinKitCircle(
                                      color: Theme.of(context).primaryColor,
                                      size: 50.0,
                                    ),
                                    Text(
                                      'Loading data',
                                      style: GoogleFonts.dMSans(
                                        textStyle: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  floatingActionButton: FutureBuilder<WebViewController>(
                      future: _controller.future,
                      builder: (BuildContext context,
                          AsyncSnapshot<WebViewController> snapshot) {
                        print(snapshot.connectionState);
                        final WebViewController controller = snapshot.data;
                        return snapshot.hasData
                            ? FloatingActionButton(
                                backgroundColor: Theme.of(context).primaryColor,
                                onPressed: isLoading
                                    ? null
                                    : () async {
                                        if (connected) {
                                          await controller.reload();
                                          setState(() {
                                            isLoading = true;
                                          });
                                        }
                                      },
                                child: isLoading
                                    ? SpinKitCircle(
                                        color: Colors.white,
                                        size: 20.0,
                                      )
                                    : Icon(Icons.rotate_left),
                              )
                            : Container();
                      }),
                );
              },
              child: Center(
                child: Text(""),
              ),
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
