import 'dart:async';
import 'package:covid19_drc/screens/starters/start_page.dart';
import 'package:covid19_drc/screens/universal/fade_animation.dart';
import 'package:covid19_drc/screens/web_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class Splash extends StatefulWidget {
  static const String rooteName = '/splash';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    init();
// chuckStater();
    super.initState();
  }

  init() async {
    await SharedPreferences.getInstance().then((prefs) {
      pref = prefs;
      chuckStater();
    });
  }

  void chuckStater() async {
    bool testPref = pref.getBool(isFirstKeyPref) ?? false;
    if (testPref) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, WebView.rooteName);
      });
    } else {
      Navigator.pushReplacementNamed(context, Starters.rooteName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                FadeAnimation(
                  1.3,
                  imageSplash(),
                ),
                Spacer(),
                FadeAnimation(
                  1.9,
                  buildBy(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageSplash() {
    return Container(
      width: 200,
      height: 100.0,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/logoCovidLogo.png'),
            fit: BoxFit.contain),
      ),
    );
  }

  Widget buildBy() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
        'Build by Uptodate Developers',
        style: GoogleFonts.dMSans(
          textStyle: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }
}
