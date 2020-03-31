import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartFour extends StatelessWidget {
  final BuildContext context;

  const StartFour({Key key, this.context}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          imageToShow(),
          textTitle(),
          text(),
        ],
      ),
    );
  }

  Widget text() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 10,
          left: 20,
          right: 20,
        ),
        child: Text(
          "Stay home and self-isolate from others in the household if you feel unwell",
          textAlign: TextAlign.center,
          style: GoogleFonts.dMSans(
            textStyle: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ),
      ),
    );
  }

  Widget textTitle() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
        ),
        child: Text(
          "Stay home if you can",
          textAlign: TextAlign.center,
          style: GoogleFonts.dMSans(
            textStyle: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget imageToShow() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width - 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Home.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
