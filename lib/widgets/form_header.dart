import 'package:flutter/material.dart';
import 'package:vacod/utils/index.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({
    Key? key,
    @required this.title,
    this.isRequired = false,
  }) : super(key: key);
  final String? title;
  final bool? isRequired;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: TextStyles.bodyS14.copyWith(color: lightTextColor),
          children: [
            TextSpan(text: title),
            TextSpan(
              text: isRequired == false ? '' : ' *',
              style: TextStyles.bodyS14.copyWith(color: lightRedColor),
            ),
          ]),
    );
  }
}
