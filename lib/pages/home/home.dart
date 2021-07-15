import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/house/house.dart';
import 'package:vacod/pages/room/room.dart';
import 'package:vacod/pages/service/service.dart';
import 'package:vacod/providers/app_language.dart';
import 'package:vacod/providers/theme.dart';
import 'package:vacod/utils/app_localizations.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/over_popup.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var buttonColor = Colors.blueAccent;
  List<Map<String, dynamic>> listMenus = [
    {
      'id': '0',
      'title': 'Quản lý nhà',
      'color': lightPurple,
      'image': Icon(Icons.ac_unit),
    },
    {
      'id': '1',
      'title': 'Quản lý phòng',
      'color': lightBlueLight,
      'image': Icon(Icons.ac_unit),
    },
    {
      'id': '2',
      'title': 'Quản lý dịch vụ',
      'color': lightGreen,
      'image': Icon(Icons.ac_unit),
    },
    {
      'id': '3',
      'title': 'Quản lý điện nước',
      'color': lightGrey,
      'image': Icon(Icons.ac_unit),
    },
    {
      'id': '4',
      'title': 'Quản lý khách thuê',
      'color': lightOrange,
      'image': Icon(Icons.ac_unit),
    },
    {
      'id': '5',
      'title': 'Hoá đơn',
      'color': lightRose,
      'image': Icon(Icons.ac_unit),
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VACOD',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 25,
          left: 25,
          right: 25,
        ),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 4 / 3),
                itemBuilder: (context, i) {
                  return Material(
                    color: listMenus[i]['color'],
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {
                        _menuNavigator(listMenus[i]['id']);
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            listMenus[i]['image'],
                            SizedBox(height: 10),
                            Center(
                              child: Text(listMenus[i]['title'],
                                  style: TextStyles.bodyS14B.copyWith(
                                    color: lightPrimaryColor,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: listMenus.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  _menuNavigator(String id) {
    switch (id) {
      case '0':
        return Navigator.of(context).pushNamed(HousePage.route);
      case '1':
        return Navigator.of(context).pushNamed(RoomPage.route);
      case '2':
        return Navigator.of(context).pushNamed(ServicePage.route);
      default:
        return Navigator.of(context).pushNamed(HousePage.route);
    }
  }
}
