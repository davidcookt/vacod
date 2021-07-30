import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vacod/pages/service/widgets/house_form_field.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/form_header.dart';
import 'package:vacod/widgets/index.dart';
import 'package:vacod/widgets/select_room/select_room_field.dart';

class CreateRenterPage extends StatefulWidget {
  CreateRenterPage({Key? key}) : super(key: key);
  static const String route = '/create-renter';
  @override
  _CreateRenterPageState createState() => _CreateRenterPageState();
}

class _CreateRenterPageState extends State<CreateRenterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _houseName = TextEditingController();
  TextEditingController _formId = TextEditingController();
  TextEditingController _houseController = TextEditingController();
  TextEditingController _roomController = TextEditingController();
  bool isSelected = false;
  String? _formHouseID = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thêm khách thuê'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
            left: AppDimension.sizePadding25,
            right: AppDimension.sizePadding25,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  const FormHeader(
                    title: 'Chọn nhà',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  HouseFormField(
                    houseController: _houseController,
                  ),
                  SizedBox(height: 10),
                  const FormHeader(
                    title: 'Chọn phòng',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  SelectRoomField(
                    roomController: _roomController,
                    houseController: _houseController,
                    key: ValueKey(_houseController.text),
                  ),
                  SizedBox(height: 10),
                  const FormHeader(
                    title: 'Họ và tên',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _houseName,
                    decoration: InputDecoration(hintText: 'Lê Văn A'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Họ và tên không được để trống';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  const FormHeader(
                    title: 'SĐT',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _houseName,
                    decoration: InputDecoration(hintText: '09xxxxxxxx'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tên nhà không được để trống';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppDimension.s10),
                  const FormHeader(
                    title: 'CMND/CCCD',
                    isRequired: true,
                  ),
                  SizedBox(height: AppDimension.s10),
                  TextFormField(
                    controller: _houseName,
                    decoration: InputDecoration(hintText: '3018231xx'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tên nhà không được để trống';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppDimension.s10),
                  const FormHeader(
                    title: 'Ngày sinh',
                  ),
                  SizedBox(height: AppDimension.s10),
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
                  const FormHeader(
                    title: 'Địa chỉ',
                    isRequired: false,
                  ),
                  SizedBox(height: AppDimension.s10),
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
                  SizedBox(height: AppDimension.s20),
                  Center(
                    child: DefaultButton(
                      widget: Text('Tạo'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_formHouseID == '') {
                            EasyLoading.showError('Vui lòng chọn loại nhà');
                            return;
                          }
                          // context
                          //     .read<HouseProvider>()
                          //     .addHouse(_houseName.text, _formId.text);
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
      ),
    );
  }
}
