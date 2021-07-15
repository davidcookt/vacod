import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/service/widgets/house_form_field.dart';
import 'package:vacod/pages/service/widgets/list_form_service.dart';
import 'package:vacod/pages/service/widgets/list_houses_dialog.dart';
import 'package:vacod/providers/service.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/form_header.dart';
import 'package:vacod/widgets/index.dart';
import 'package:vacod/widgets/price_form_field.dart';

class CreateServicePage extends StatefulWidget {
  const CreateServicePage({Key? key}) : super(key: key);
  static const String route = '/create-service';

  @override
  _CreateServicePageState createState() => _CreateServicePageState();
}

class _CreateServicePageState extends State<CreateServicePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _serviceNameController = TextEditingController();
  TextEditingController _unitPriceController = TextEditingController();
  TextEditingController _houseController = TextEditingController();
  String? _formServiceId, _houseId;
  int? _unitPrice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo dịch vụ'),
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
                    validator: (val) {
                      if (val!.isEmpty) return 'Đơn giá không được để trống';
                      return null;
                    },
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
                    houseController: _houseController,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: DefaultButton(
                      widget: Text('Lưu'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ServiceProvider>().addService(
                              _serviceNameController.text,
                              _houseController.text,
                              _formServiceId!,
                              _unitPrice!);
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
