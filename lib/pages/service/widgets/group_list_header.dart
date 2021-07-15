import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/providers/house.dart';

class GroupListHeader extends StatefulWidget {
  final String? houseID;
  const GroupListHeader({
    Key? key,
    this.houseID,
  }) : super(key: key);

  @override
  _GroupListHeaderState createState() => _GroupListHeaderState();
}

class _GroupListHeaderState extends State<GroupListHeader> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: context.read<HouseProvider>().getHouseName(widget.houseID),
      builder: (context, AsyncSnapshot<String> snapShot) {
        if (!snapShot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              snapShot.data!,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    );
  }
}
