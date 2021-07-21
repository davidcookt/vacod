import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/service/widgets/house_form_field.dart';
import 'package:vacod/providers/index.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/default_button.dart';
import 'package:vacod/widgets/form_header.dart';
import 'package:vacod/widgets/price_form_field.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({Key? key}) : super(key: key);
  static const String route = '/create-room';

  @override
  _CreateRoomPageState createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  TextEditingController _houseController = TextEditingController();
  TextEditingController _roomNameController = TextEditingController();
  int? _rent, _deposit;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo phòng'),
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
                  valueChanged: (value) {
                    print(value);
                    _deposit = value;
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: DefaultButton(
                    widget: Text('Xác nhận'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<RoomProvider>().addRoom(
                              _roomNameController.text,
                              _houseController.text,
                              _rent!,
                              _deposit!,
                            );
                        Navigator.of(context).pop();
                      }
                    },
                    buttonColor: lightAccentColor,
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
