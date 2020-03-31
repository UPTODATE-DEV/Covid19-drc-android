import 'package:flutter/material.dart';
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
