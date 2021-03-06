import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:vacod/models/renter.dart';
import 'package:vacod/pages/service/widgets/house_form_field.dart';
import 'package:vacod/providers/renter.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/form_header.dart';
import 'package:vacod/widgets/index.dart';
import 'package:vacod/widgets/select_room/select_room_field.dart';

class EditRenterPage extends StatefulWidget {
  final String? renterID;
  EditRenterPage({
    Key? key,
    this.renterID,
  }) : super(key: key);
  static const String route = '/edit-renter';
  @override
  _EditRenterPageState createState() => _EditRenterPageState();
}

class _EditRenterPageState extends State<EditRenterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _renterNameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _renterIDController = TextEditingController();
  TextEditingController _renterAddressController = TextEditingController();
  TextEditingController _renterDOBController = TextEditingController();
  TextEditingController _houseController = TextEditingController();
  TextEditingController _roomController = TextEditingController();
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _renterNameController.text =
          context.read<RenterProvider>().getActiveRenter.renterName ?? '';
      _houseController.text =
          context.read<RenterProvider>().getActiveRenter.houseID ?? '';
      _roomController.text =
          context.read<RenterProvider>().getActiveRenter.roomID ?? '';
      _renterAddressController.text =
          context.read<RenterProvider>().getActiveRenter.address ?? '';
      _phoneNoController.text =
          context.read<RenterProvider>().getActiveRenter.phoneNo ?? '';
      _renterIDController.text =
          context.read<RenterProvider>().getActiveRenter.identityNo ?? '';
      setState(() {});
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
          title: Text('S???a kh??ch thu??'),
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
                    title: 'Ch???n nh??',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  HouseFormField(
                    houseController: _houseController,
                  ),
                  SizedBox(height: 10),
                  const FormHeader(
                    title: 'Ch???n ph??ng',
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
                    title: 'H??? v?? t??n',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _renterNameController,
                    decoration: InputDecoration(hintText: 'L?? V??n A'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'H??? v?? t??n kh??ng ???????c ????? tr???ng';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  const FormHeader(
                    title: 'S??T',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneNoController,
                    decoration: InputDecoration(hintText: '09xxxxxxxx'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'S??T kh??ng ???????c ????? tr???ng';
                      }
                      // else if (!Validator.isPhoneNovalid(value))
                      //   return 'S??T kh??ng ????ng ?????nh d???ng';
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
                    controller: _renterIDController,
                    decoration: InputDecoration(hintText: '3018231xx'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'T??n nh?? kh??ng ???????c ????? tr???ng';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppDimension.s10),
                  const FormHeader(
                    title: 'Ng??y sinh',
                  ),
                  SizedBox(height: AppDimension.s10),
                  TextFormField(
                    controller: _renterDOBController,
                    decoration: InputDecoration(hintText: 'T??n nh??'),
                    validator: (value) {
                      // if (value!.isEmpty) {
                      //   return 'T??n nh?? kh??ng ???????c ????? tr???ng';
                      // }
                      return null;
                    },
                  ),
                  SizedBox(height: AppDimension.s10),
                  const FormHeader(
                    title: '?????a ch???',
                    isRequired: false,
                  ),
                  SizedBox(height: AppDimension.s10),
                  TextFormField(
                    controller: _renterAddressController,
                    decoration: InputDecoration(hintText: 'T??n nh??'),
                    validator: (value) {
                      // if (value!.isEmpty) {
                      //   return 'T??n nh?? kh??ng ???????c ????? tr???ng';
                      // }
                      return null;
                    },
                  ),
                  SizedBox(height: AppDimension.s20),
                  Center(
                    child: DefaultButton(
                      widget: Text('L??u'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_houseController.text == '') {
                            EasyLoading.showError('Vui l??ng ch???n nh??');
                            return;
                          }

                          // context.read<RenterProvider>().addRenter(Renter(
                          //       renterName: _renterNameController.text,
                          //       address: _renterAddressController.text,
                          //       dob: null,
                          //       phoneNo: _phoneNoController.text,
                          //       identityNo: _renterIDController.text,
                          //       houseID: _houseController.text,
                          //       roomID: _roomController.text,
                          //       avatarPath: '',
                          //       listImagePaths: [],
                          //     ));

                          // Navigator.of(context).pop();
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
