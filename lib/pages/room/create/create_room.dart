import 'package:flutter/material.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/default_button.dart';

class CreateRoomPage extends StatelessWidget {
  const CreateRoomPage({Key? key}) : super(key: key);
  static const String route = '/create-room';
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
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Chọn nhà',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Tên phòng',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Tiền phòng',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Tiền cọc',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Khách trọ',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Số người trọ',
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: DefaultButton(
                    widget: Text('Xác nhận'),
                    onPressed: () {},
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
