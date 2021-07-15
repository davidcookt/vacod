import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:vacod/pages/home/home.dart';
import 'package:vacod/utils/index.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var listPage = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPage[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: lightPrimaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: lightTextColor,
            ),
            activeIcon: Icon(
              Icons.list,
              color: lightAccentColor,
            ),
            label: 'Phòng trọ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet,
              color: lightTextColor,
            ),
            activeIcon: Icon(
              Icons.account_balance_wallet,
              color: lightAccentColor,
            ),
            label: 'Hoá đơn',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pie_chart_rounded,
              color: lightTextColor,
            ),
            activeIcon: Icon(
              Icons.pie_chart_rounded,
              color: lightAccentColor,
            ),
            label: 'Thống kế',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              color: lightTextColor,
            ),
            activeIcon: Icon(
              Icons.account_box,
              color: lightAccentColor,
            ),
            label: 'Tuỳ chỉnh',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 5;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 12.0, color: color);
  }
}
