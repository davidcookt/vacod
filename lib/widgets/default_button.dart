import 'package:flutter/material.dart';
import 'package:vacod/utils/index.dart';

class DefaultButton extends StatelessWidget {
  final double height, width;
  final Function onPressed;
  final Widget widget;
  final ButtonStyle buttonStyle;
  final Color buttonColor;
  const DefaultButton({
    Key key,
    this.height = 50,
    this.width = 315,
    @required this.widget,
    @required this.onPressed,
    this.buttonColor = lightAccentColor,
    this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: widget,
        style: buttonStyle ??
            ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => buttonColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: buttonColor),
                ),
              ),
            ),
      ),
    );
  }
}
