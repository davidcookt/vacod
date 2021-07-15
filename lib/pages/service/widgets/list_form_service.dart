import 'package:flutter/material.dart';
import 'package:vacod/models/form_service.dart';
import 'package:vacod/utils/index.dart';

class ListFormService extends StatefulWidget {
  final String? defaultValue;
  final ValueChanged<String>? onChanged;
  ListFormService({
    Key? key,
    this.defaultValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _ListFormServiceState createState() => _ListFormServiceState();
}

class _ListFormServiceState extends State<ListFormService> {
  bool isSelected = false;
  List<FormService> _formService = [];
  @override
  void initState() {
    super.initState();
    _formService = defaultFormService
        .map((form) => FormService(
              id: form['id'].toString(),
              title: form['title'].toString(),
              isSelected: form['isSelected'] as bool,
            ))
        .toList();
    _formService.forEach((element) {
      // print(' load ' + element.id.toString() + widget.defaultValue.toString());
      if (element.id == widget.defaultValue)
        element.isSelected = true;
      else
        element.isSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 4 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            if (_formService[i].isSelected == false) {
              _formService.forEach((element) {
                if (element.id == _formService[i].id) {
                  element.isSelected = true;
                  widget.onChanged!(_formService[i].id!);
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
                color:
                    _formService[i].isSelected! ? lightOrange : Colors.yellow,
              ),
              color: _formService[i].isSelected! ? lightOrange : Colors.white,
            ),
            child: Center(
              child: Text(
                _formService[i].title!,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyles.bodyS14.copyWith(
                  fontWeight: _formService[i].isSelected!
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: _formService[i].isSelected!
                      ? Colors.white
                      : lightTextColor,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: _formService.length,
    );
  }
}
