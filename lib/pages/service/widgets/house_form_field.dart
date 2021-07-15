import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/providers/house.dart';

import 'list_houses_dialog.dart';

class HouseFormField extends StatefulWidget {
  HouseFormField({
    Key? key,
    this.houseController,
    this.isEdit = false,
    this.currentvalue,
  }) : super(key: key);
  final TextEditingController? houseController;
  final bool? isEdit;
  final String? currentvalue;
  @override
  _HouseFormFieldState createState() => _HouseFormFieldState();
}

class _HouseFormFieldState extends State<HouseFormField> {
  TextEditingController _serviceNameController = TextEditingController();
  @override
  void initState() {
    super.initState();

    if (widget.isEdit!) {
      if (widget.currentvalue != null) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
          await context
              .read<HouseProvider>()
              .getDetailHouse(widget.currentvalue);
          widget.houseController?.text = widget.currentvalue!;
          _serviceNameController.text =
              context.read<HouseProvider>().getActiveHouse.name;
          setState(() {});
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return ListHouseDialog(
                housesIsSelected: widget.houseController?.text,
                houseName: _serviceNameController.text,
                onChanged: (data) {
                  setState(() {
                    widget.houseController?.text = data.id!;
                    // _houseIsSelectedName = data.name!;
                    _serviceNameController.text = data.name!;
                  });
                },
              );
            });
      },
      child: TextFormField(
        enabled: false,
        controller: _serviceNameController,
        decoration: InputDecoration(
          hintText: 'Nhà',
        ),
      ),
    );
  }
}
