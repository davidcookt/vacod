import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/house/widgets/list_radio_box.dart';
import 'package:vacod/providers/house.dart';
import 'package:vacod/utils/colors.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/default_button.dart';

class CreateHousePage extends StatefulWidget {
  const CreateHousePage({Key? key}) : super(key: key);
  static const String route = '\create-house';

  @override
  _CreateHousePageState createState() => _CreateHousePageState();
}

class _CreateHousePageState extends State<CreateHousePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _houseName = TextEditingController();
  TextEditingController _formId = TextEditingController();
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
          title: Text('Tạo nhà'),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  // TextFormField(
                  //   controller: _formId,
                  //   decoration: InputDecoration(hintText: 'Loại nhà'),
                  // ),
                  Text('Loại nhà'),
                  SizedBox(height: AppDimension.s10),
                  SizedBox(
                    height: 200,
                    child: ListRadioBox(
                      onChanged: (val) {
                        print(val);
                        _formHouseID = val;
                      },
                    ),
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
                          context
                              .read<HouseProvider>()
                              .addHouse(_houseName.text, _formId.text);
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
