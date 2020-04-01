import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences pref;
const String isFirstKeyPref = "isFirstKeyPref";

PageViewIndicator pageViewIndicator({
  BuildContext context,
  ValueNotifier<int> pageIndexNotifier,
}) {
  return PageViewIndicator(
    pageIndexNotifier: pageIndexNotifier,
    length: 4,
    normalBuilder: (animationController, index) => Circle(
      size: 5.0,
      color: Colors.grey[400],
    ),
    highlightedBuilder: (animationController, index) => ScaleTransition(
      scale: CurvedAnimation(
        parent: animationController,
        curve: Curves.ease,
      ),
      child: Circle(
        size: 8.0,
        color: Theme.of(context).primaryColor,
      ),
    ),
  );
}

Future<String> isConnected() async {
  bool connected = await DataConnectionChecker().hasConnection;

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none) {
    if (connected) {
      return 'internet access';
    } else {
      return "Veuillez vérifier votre connexion internet";
    }
  } else {
    return "Vous n'êtes pas connecté à internet \nReésayer votre demande ultérieurement";
  }
}

Widget notConnected(
    {BuildContext context,
    String title,
    String subtitle,
    Function onRetry,
    @required String img}) {
  return Center(
    child: Container(
        padding: EdgeInsets.only(top: 80.0, left: 30, right: 30),
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 150,
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "$title",
              style: GoogleFonts.dMSans(
                textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Text(
              "$subtitle",
              style: GoogleFonts.dMSans(
                textStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 45.0,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.refresh,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Réessayer",
                      style: GoogleFonts.dMSans(
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: onRetry,
              ),
            ),
          ],
        )),
  );
}
