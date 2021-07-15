import 'package:flutter/material.dart';
import 'package:vacod/models/form_house.dart';
import 'package:vacod/utils/index.dart';

class ListRadioBox extends StatefulWidget {
  ListRadioBox({
    Key? key,
    this.onChanged,
    this.defaultValue,
  }) : super(key: key);
  final String? defaultValue;
  final ValueChanged<String>? onChanged;
  @override
  _ListRadioBoxState createState() => _ListRadioBoxState();
}

class _ListRadioBoxState extends State<ListRadioBox> {
  bool isSelected = false;
  List<FormHouse> _formHouses = [];
  @override
  void initState() {
    super.initState();
    _formHouses = defaultFormHouse
        .map((form) => FormHouse(
              id: form['id'].toString(),
              title: form['title'].toString(),
              isSelected: form['isSelected'] as bool,
            ))
        .toList();
    _formHouses.forEach((element) {
      print(' load ' + element.id.toString() + widget.defaultValue.toString());
      if (element.id == widget.defaultValue)
        element.isSelected = true;
      else
        element.isSelected = false;
    });
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 4 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            if (_formHouses[i].isSelected == false) {
              _formHouses.forEach((element) {
                if (element.id == _formHouses[i].id) {
                  element.isSelected = true;
                  widget.onChanged!(_formHouses[i].id!);
                } else {
                  element.isSelected = false;
                }
              });
            }

            setState(() {});
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              // color: Colors.yellow,
              border: Border.all(
                color: _formHouses[i].isSelected! ? lightOrange : Colors.yellow,
              ),
              color: _formHouses[i].isSelected! ? lightOrange : Colors.white,
            ),
            child: Center(
              child: Text(
                _formHouses[i].title!,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
      itemCount: _formHouses.length,
    );
  }
}
