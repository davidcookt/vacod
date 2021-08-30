import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:vacod/providers/house.dart';
import 'package:vacod/providers/index.dart';
import 'package:vacod/widgets/select_room/list_room_dialog.dart';

class SelectRoomField extends StatefulWidget {
  SelectRoomField({
    Key? key,
    this.roomController,
    this.isEdit = false,
    this.currentvalue,
    this.houseController,
  }) : super(key: key);
  final TextEditingController? roomController, houseController;
  final bool? isEdit;
  final String? currentvalue;
  @override
  _SelectRoomFieldState createState() => _SelectRoomFieldState();
}

class _SelectRoomFieldState extends State<SelectRoomField> {
  TextEditingController _serviceNameController = TextEditingController();
  @override
  void initState() {
    super.initState();

    if (widget.isEdit!) {
      if (widget.currentvalue != null) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
          context
              .read<RoomProvider>()
              .getRooms(houseID: widget.roomController!.text);
          widget.roomController?.text = widget.currentvalue!;
          _serviceNameController.text =
              context.read<RoomProvider>().getActiveRoom.name;
          setState(() {});
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      enableInteractiveSelection: true,
      onTap: () {
        if (widget.houseController?.text == null ||
            widget.houseController!.text.length <= 0) {
          EasyLoading.showError('Vui lòng chọn nhà trước khi chọn phòng!');
        } else {
          showDialog(
              context: context,
              builder: (_) {
                return ListRoomDialog(
                  key: ValueKey(widget.houseController?.text),
                  roomIsSelected: widget.roomController?.text,
                  roomName: _serviceNameController.text,
                  houseID: widget.houseController?.text,
                  onChanged: (data) {
                    setState(() {
                      widget.roomController?.text = data.id!;
                      // _houseIsSelectedName = data.name!;
                      _serviceNameController.text = data.name!;
                    });
                  },
                );
              });
        }
      },
      controller: _serviceNameController,
      decoration: InputDecoration(
        hintText: 'Phòng',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Phòng không được để trống';
        }
        return null;
      },
    );
  }
}
