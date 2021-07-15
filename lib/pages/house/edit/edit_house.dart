import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/models/house.dart';
import 'package:vacod/pages/house/widgets/list_radio_box.dart';
import 'package:vacod/providers/house.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/index.dart';

class EditHousePage extends StatefulWidget {
  final String? houseID;
  EditHousePage({Key? key, this.houseID}) : super(key: key);

  static const String route = '/edit-house';
  @override
  _EditHousePageState createState() => _EditHousePageState();
}

class _EditHousePageState extends State<EditHousePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _houseName = TextEditingController();
  TextEditingController _formId = TextEditingController();
  late String _formHouseID = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context
          .read<HouseProvider>()
          .getDetailHouse(widget.houseID)
          .then((value) {
        _houseName.text = context.read<HouseProvider>().getActiveHouse.name;
        _formHouseID = context.read<HouseProvider>().getActiveHouse.formID;
        setState(() {});
        // print(_formHouseID);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sửa nhà'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
            top: AppDimension.sizePadding25,
            left: AppDimension.sizePadding25,
            right: AppDimension.sizePadding25,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _houseName,
                    decoration: InputDecoration(hintText: 'Tên nhà'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tên nhà không được để trống';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppDimension.s10),
                  SizedBox(
                    height: 200,
                    child: ListRadioBox(
                      key: ValueKey(_formHouseID),
                      defaultValue: _formHouseID,
                      onChanged: (val) {
                        print(val);
                        _formHouseID = val;
                      },
                    ),
                  ),
                  SizedBox(height: AppDimension.s20),
                  DefaultButton(
                    widget: Text('Cập nhật'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<HouseProvider>().updateHouse(
                            _houseName.text, _formHouseID, widget.houseID!);
                        Navigator.of(context).pop();
                      }
                    },
                    buttonColor: lightAccentColor,
                  ),
                  SizedBox(height: AppDimension.s20),
                  DefaultButton(
                    widget: Text('Xoá'),
                    onPressed: () {
                      context.read<HouseProvider>().deleteHouse(widget.houseID);
                      Navigator.of(context).pop();
                    },
                    buttonColor: lightRedColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
