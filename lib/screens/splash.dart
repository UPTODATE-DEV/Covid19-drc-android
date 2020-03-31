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
    Timer(Duration(seconds: 3), () {
      chuckStater();
    });
    super.initState();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pref = prefs;
  }

  void chuckStater() async {
    bool testPref = pref.getBool(isFirstKeyPref) ?? false;
    if (testPref) {
      Navigator.pushReplacementNamed(context, WebView.rooteName);
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
      child: RichText(
        text: TextSpan(
            text: "Build",
            style: GoogleFonts.dMSans(
              textStyle: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            children: [
              TextSpan(text: " by uptodate"),
            ]),
      ),
    );
  }
}
