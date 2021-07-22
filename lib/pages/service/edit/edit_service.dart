import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/service/widgets/house_form_field.dart';
import 'package:vacod/pages/service/widgets/list_form_service.dart';
import 'package:vacod/pages/service/widgets/list_houses_dialog.dart';
import 'package:vacod/providers/service.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/form_header.dart';
import 'package:vacod/widgets/index.dart';
import 'package:vacod/widgets/price_form_field.dart';

class EditServicePage extends StatefulWidget {
  final String? serviceID;
  const EditServicePage({
    Key? key,
    this.serviceID,
  }) : super(key: key);
  static const String route = '/edit-service';

  @override
  _EditServicePageState createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _serviceNameController = TextEditingController();
  TextEditingController _houseController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  String? _formServiceId, _currentHouseID;
  int? _unitPrice;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // context
      //     .read<ServiceProvider>()
      //     .getDetailService(widget.serviceID)
      //     .then((value) {

      //   // print(_formHouseID);
      // });
      _serviceNameController.text =
          context.read<ServiceProvider>().getActiveService.serviceName;
      _formServiceId =
          context.read<ServiceProvider>().getActiveService.formServiceID;
      // print(_formServiceId);
      _currentHouseID =
          context.read<ServiceProvider>().getActiveService.houseID;
      print('3 $_currentHouseID');
      _unitPrice = context.read<ServiceProvider>().getActiveService.unitPrice;
      _priceController.text =
          NumberFormat.currency(locale: 'vi', decimalDigits: 0, symbol: '')
                  .format(_unitPrice)
                  .trim() +
              'đ';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print('2');
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa dịch vụ'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          // top: AppDimension.sizePadding25,
          left: AppDimension.sizePadding25,
          right: AppDimension.sizePadding25,
        ),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  const FormHeader(
                    title: 'Tên dịch vụ',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _serviceNameController,
                    validator: (val) {
                      if (val!.isEmpty || val.length < 1)
                        return 'Tên dịch vụ không được để trống';
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Tên dịch vụ',
                    ),
                  ),
                  SizedBox(height: 10),
                  const FormHeader(
                    title: 'Loại dịch vụ',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 280,
                    child: ListFormService(
                      key: ValueKey(_formServiceId),
                      defaultValue: _formServiceId,
                      onChanged: (value) {
                        print(value);
                        _formServiceId = value;
                      },
                    ),
                  ),
                  // SizedBox(height: 10),
                  const FormHeader(
                    title: 'Đơn giá',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  PriceFormField(
                    isBilling: false,
                    controller: _priceController,
                    validator: (val) {
                      if (val!.isEmpty) return 'Đơn giá không được để trống';
                      return null;
                    },
                    // key: ValueKey(_unitPrice),
                    price: _unitPrice,
                    valueChanged: (value) {
                      print(value);
                      _unitPrice = value;
                    },
                  ),
                  SizedBox(height: 10),
                  const FormHeader(
                    title: 'Nhà áp dụng',
                    isRequired: true,
                  ),
                  SizedBox(height: 10),
                  HouseFormField(
                    key: ValueKey(_currentHouseID),
                    currentvalue: _currentHouseID,
                    houseController: _houseController,
                    isEdit: true,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: DefaultButton(
                      widget: Text('Lưu'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ServiceProvider>().updateService(
                              _serviceNameController.text,
                              _formServiceId!,
                              widget.serviceID!,
                              _houseController.text,
                              _unitPrice!);
                          Navigator.of(context).pop();
                        }
                      },
                      buttonColor: lightAccentColor,
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              )),
        ),
      ),
    );
  }
}
