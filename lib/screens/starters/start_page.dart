import 'package:covid19_drc/screens/index.dart';
import 'package:covid19_drc/screens/splash.dart';
import 'package:covid19_drc/screens/starters/start_four.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils.dart';

class Starters extends StatefulWidget {
  static const String rooteName = '/startpage';
  @override
  _StartersState createState() => _StartersState();
}

class _StartersState extends State<Starters> {
  List<Widget> staters = List();

  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
  @override
  void initState() {
    staters = [
      StartOne(
        context: context,
      ),
      StartTwo(
        context: context,
      ),
      StartThree(
        context: context,
      ),
      StartFour(
        context: context,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 300,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: PageView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: staters.length,
                          itemBuilder: (context, index) => staters[index],
                          onPageChanged: (value) {
                            setState(() {
                              currentIndex.value = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                pageViewIndicator(
                  context: context,
                  pageIndexNotifier: currentIndex,
                ),
                getStarted(),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonPasse() {
    return FlatButton(
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      child: Container(
        child: Text(
          "Passer",
          style: GoogleFonts.dMSans(
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      onPressed: () {},
    );
  }

  Widget getStarted() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: currentIndex.value == 3
            ? Theme.of(context).primaryColor
            : Colors.grey[100],
        child: Container(
          alignment: Alignment.center,
          width: 130,
          // height: 50,
          padding: EdgeInsets.all(12),
          child: Text(
            "Get Started",
            style: GoogleFonts.dMSans(
              textStyle: TextStyle(
                  color: currentIndex.value == 3
                      ? Colors.white
                      : Theme.of(context).primaryColor),
            ),
          ),
        ),
        onPressed: () {
          pref.setBool(isFirstKeyPref, true);
          Navigator.pushReplacementNamed(context, Splash.rooteName);
        },
      ),
    );
  }
}
