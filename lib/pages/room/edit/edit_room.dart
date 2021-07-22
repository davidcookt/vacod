import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/service/widgets/house_form_field.dart';
import 'package:vacod/providers/index.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/form_header.dart';
import 'package:vacod/widgets/index.dart';
import 'package:vacod/widgets/price_form_field.dart';

class EditRoomPage extends StatefulWidget {
  final String? roomID;
  EditRoomPage({
    Key? key,
    this.roomID,
  }) : super(key: key);
  static const String route = '/edit-room';

  @override
  _EditRoomPageState createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  TextEditingController _houseController = TextEditingController();
  TextEditingController _roomNameController = TextEditingController();
  TextEditingController _rentController = TextEditingController();
  TextEditingController _depositController = TextEditingController();
  int? _rent = 0, _deposit = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _currentHouseID;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _roomNameController.text =
          context.read<RoomProvider>().getActiveRoom.name;
      _currentHouseID = context.read<RoomProvider>().getActiveRoom.houseID;
      _rent = context.read<RoomProvider>().getActiveRoom.rent;
      _deposit = context.read<RoomProvider>().getActiveRoom.deposit;
      _rentController.text = AppConstant.formatMoney(_rent!);
      _depositController.text = AppConstant.formatMoney(_deposit!);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa phòng'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: AppDimension.sizePadding25,
          right: AppDimension.sizePadding25,
          left: AppDimension.sizePadding25,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const FormHeader(
                  title: 'Nhà áp dụng',
                  isRequired: true,
                ),
                SizedBox(height: 10),
                HouseFormField(
                  houseController: _houseController,
                  isEdit: true,
                  key: ValueKey(_currentHouseID),
                  currentvalue: _currentHouseID,
                ),
                SizedBox(height: 10),
                const FormHeader(
                  title: 'Tên phòng',
                  isRequired: true,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _roomNameController,
                  decoration: InputDecoration(
                    hintText: 'P.101',
                  ),
                  validator: (val) {
                    if (val!.isEmpty) return 'Tên phòng không được để trống';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                const FormHeader(
                  title: 'Tiền phòng',
                  isRequired: true,
                ),
                SizedBox(height: 10),
                PriceFormField(
                  isBilling: false,
                  validator: (val) {
                    if (val!.isEmpty) return 'Tiền cọc không được để trống';
                    return null;
                  },
                  // key: ValueKey(_rent),
                  controller: _rentController,
                  price: _rent,
                  valueChanged: (value) {
                    print(value);
                    _rent = value;
                  },
                ),
                SizedBox(height: 10),
                const FormHeader(
                  title: 'Tiền cọc',
                  isRequired: true,
                ),
                SizedBox(height: 10),
                PriceFormField(
                  isBilling: false,
                  validator: (val) {
                    if (val!.isEmpty) return 'Tiền cọc không được để trống';
                    return null;
                  },
                  // key: ValueKey(_deposit),
                  controller: _depositController,
                  price: _deposit,
                  valueChanged: (value) {
                    print(value);
                    _deposit = value;
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: DefaultButton(
                    widget: Text('Lưu'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<RoomProvider>().updateRoom(
                              _roomNameController.text,
                              _houseController.text,
                              widget.roomID!,
                              _deposit!,
                              _rent!,
                            );
                        Navigator.of(context).pop();
                      }
                    },
                    buttonColor: lightAccentColor,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: DefaultButton(
                    widget: Text('Xoá'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<RoomProvider>().deleteRoom(
                              widget.roomID!,
                            );
                        Navigator.of(context).pop();
                      }
                    },
                    buttonColor: lightRedColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
