import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/models/house.dart';
import 'package:vacod/models/house_model.dart';
import 'package:vacod/providers/house.dart';
import 'package:vacod/utils/colors.dart';
import 'package:vacod/widgets/loading_view.dart';

class ListHouseDialog extends StatefulWidget {
  const ListHouseDialog({
    Key? key,
    this.onChanged,
    this.housesIsSelected,
    this.houseName,
  }) : super(key: key);
  final ValueChanged<HouseModel>? onChanged;
  final String? housesIsSelected, houseName;
  @override
  _ListHouseDialogState createState() => _ListHouseDialogState();
}

class _ListHouseDialogState extends State<ListHouseDialog> {
  String _houseSelected = '', _houseName = '';
  @override
  void initState() {
    super.initState();
    _houseSelected = widget.housesIsSelected!;
    _houseName = widget.houseName!;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<HouseProvider>().getHouses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Do something'),
      content: Container(
        height: 200,
        width: 200,
        child: Consumer<HouseProvider>(
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
                    title: Text(data.getHouse(i).name),
                    value: data.getHouse(i).houseID,
                    groupValue: _houseSelected,
                    onChanged: (String? value) {
                      setState(() {
                        _houseSelected = value!;
                        _houseName = data.getHouse(i).name;
                        print(_houseSelected);
                      });
                    },
                  ),
                );
              },
              itemCount: data.houseCount,
            );
          },
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              widget.onChanged!(HouseModel(
                id: _houseSelected,
                name: _houseName,
              ));
              Navigator.of(context).pop();
            },
            child: Text('Xác nhận')),
        ElevatedButton(onPressed: () {}, child: Text('Huỷ')),
      ],
    );
  }
}
