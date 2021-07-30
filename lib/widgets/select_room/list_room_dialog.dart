import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/models/house.dart';
import 'package:vacod/models/house_model.dart';
import 'package:vacod/providers/house.dart';
import 'package:vacod/providers/index.dart';
import 'package:vacod/utils/colors.dart';
import 'package:vacod/widgets/loading_view.dart';

class ListRoomDialog extends StatefulWidget {
  const ListRoomDialog({
    Key? key,
    this.onChanged,
    this.roomIsSelected,
    this.roomName,
    this.houseID,
  }) : super(key: key);
  final ValueChanged<HouseModel>? onChanged;
  final String? roomIsSelected, roomName, houseID;
  @override
  _ListRoomDialogState createState() => _ListRoomDialogState();
}

class _ListRoomDialogState extends State<ListRoomDialog> {
  String _roomSelected = '', _roomName = '';
  @override
  void initState() {
    super.initState();
    _roomSelected = widget.roomIsSelected!;
    _roomName = widget.roomName!;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<RoomProvider>().getRooms(houseID: widget.houseID);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Danh sách phòng trọ'),
      content: Container(
        height: 200,
        width: 200,
        child: Consumer<RoomProvider>(
          builder: (context, data, _) {
            if (data.isLoading!) {
              return LoadingView();
            }
            if (data.isFailed!) {
              return Center(
                child: Text('Lỗi! Vui lòng thử lại!'),
              );
            }

            return ListView.builder(
              itemBuilder: (context, i) {
                return Container(
                  height: 50,
                  child: RadioListTile(
                    activeColor: lightAccentColor,
                    title: Text(data.getRoom(i).name),
                    value: data.getRoom(i).roomID,
                    groupValue: _roomSelected,
                    onChanged: (String? value) {
                      setState(() {
                        _roomSelected = value!;
                        _roomName = data.getRoom(i).name;
                        print(_roomSelected);
                      });
                    },
                  ),
                );
              },
              itemCount: data.roomCount,
            );
          },
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              widget.onChanged!(HouseModel(
                id: _roomSelected,
                name: _roomName,
              ));
              Navigator.of(context).pop();
            },
            child: Text('Xác nhận')),
        ElevatedButton(onPressed: () {}, child: Text('Huỷ')),
      ],
    );
  }
}
