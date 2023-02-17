import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtuard/screens/explore.dart';
import 'package:virtuard/screens/home.dart';
import 'package:virtuard/screens/profilescreen.dart';
import 'package:virtuard/screens/screenfive.dart';
import 'package:virtuard/screens/screenfour.dart';

class BottomNavBar extends StatefulWidget {
  var connectedornot;

  BottomNavBar({super.key, required this.connectedornot});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  int _page = 2;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 60.0,
        items: const <Widget>[
          FaIcon(
            FontAwesomeIcons.user,
            size: 20,
            color: Colors.white,
          ),
          FaIcon(
            FontAwesomeIcons.house,
            size: 20,
            color: Colors.white,
          ),
          FaIcon(
            FontAwesomeIcons.plus,
            size: 20,
            color: Colors.white,
          ),
          FaIcon(
            FontAwesomeIcons.eye,
            size: 20,
            color: Colors.white,
          ),
          FaIcon(
            FontAwesomeIcons.cartShopping,
            size: 20,
            color: Colors.white,
          ),
        ],
        onTap: (selectedindex) {
          setState(() {
            _page = selectedindex;
          });
        },
        color: Colors.black26,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
      ),
      body: getSelectedWidget(index: _page),
    );
  }

  Widget getSelectedWidget({required int index}) {
    var connectedornot;
    Widget widget;
    switch (index) {
      case 0:
        widget = Homepage();
        break;
      case 1:
        widget = const Explore();
        break;
      case 2:
        widget = const Profilescreen();
        break;
      case 3:
        widget = const ScreenFour();
        break;
      case 4:
        widget = const ScreenFive();
        break;
      default:
        widget = const ScreenFour();
    }
    return widget;
  }
}
