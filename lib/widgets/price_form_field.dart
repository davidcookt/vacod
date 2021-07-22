import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vacod/utils/index.dart';

class PriceFormField extends StatefulWidget {
  PriceFormField({
    Key? key,
    this.price,
    this.valueChanged,
    this.isBilling = false,
    this.validator,
    this.controller,
  }) : super(key: key);
  final int? price;
  final ValueChanged<int>? valueChanged;
  final bool? isBilling;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  @override
  _PriceFormFieldState createState() => _PriceFormFieldState();
}

class _PriceFormFieldState extends State<PriceFormField> {
  // TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // if (widget.price != null) {
    //   _controller.text =
    //       NumberFormat.currency(locale: 'vi', decimalDigits: 0, symbol: '')
    //               .format(widget.price)
    //               .trim() +
    //           'đ';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      inputFormatters: [CurrencyInputFormatter()],
      onChanged: (value) {
        widget.valueChanged!(int.parse(value.replaceAll(RegExp('[^0-9]'), '')));
      },
      validator: widget.validator,
      keyboardType: TextInputType.number,
      decoration: widget.isBilling!
          ? InputDecoration(
              hintText: '',
              // contentPadding: EdgeInsets.symmetric(
              //   vertical: 15,
              //   horizontal: 10,
              // ),
              errorMaxLines: 2,
            )
          : InputDecoration(
              hintText: '0đ',
              // contentPadding: EdgeInsets.symmetric(
              //   vertical: 15,
              //   horizontal: 10,
              // ),
            ),
      textAlign: widget.isBilling! ? TextAlign.right : TextAlign.left,
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '0');
    } else if (newValue.text.compareTo(oldValue.text) != 0 &&
        newValue.text.length > 2) {
      var num = int.parse(newValue.text.replaceAll(RegExp('[^0-9]'), ''));

      final nStr = AppConstant.formatMoney(num);
      return TextEditingValue(
        text: nStr,
        selection: TextSelection.collapsed(offset: nStr.length - 2),
      );
    } else if (newValue.text.replaceAll(RegExp('[^0-9]'), '').isEmpty) {
      final nStr = AppConstant.formatMoney(0);
      return TextEditingValue(
        text: nStr,
        selection: TextSelection.collapsed(offset: nStr.length - 2),
      );
    } else {
      var num = int.parse(newValue.text.replaceAll(RegExp('[^0-9]'), ''));
      final nStr = AppConstant.formatMoney(num);
      return TextEditingValue(
        text: nStr,
        selection: TextSelection.collapsed(offset: nStr.length - 2),
      );
    }
  }
}
