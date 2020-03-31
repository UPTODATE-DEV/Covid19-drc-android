// import 'package:flutter/material.dart';
import 'package:covid19_drc/screens/splash.dart';
import 'package:covid19_drc/screens/starters/start_one.dart';
import 'package:covid19_drc/screens/starters/start_page.dart';
import 'package:covid19_drc/screens/starters/start_two.dart';
import 'package:covid19_drc/screens/web_view.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0XFF022e57),
      statusBarIconBrightness: Brightness.light));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(Covid19());
}

class Covid19 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shule System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0XFF022e57),
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        Splash.rooteName: (_) => Splash(),
        Starters.rooteName: (_) => Starters(),
        WebView.rooteName: (_) => WebView(),
      },
      home: Splash(),
    );
  }
}
