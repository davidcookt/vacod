import 'package:flutter/material.dart';
import '../utils/index.dart';

class DefaultButton extends StatelessWidget {
  final double height, width;
  final Function onPressed;
  final Widget widget;
  final ButtonStyle? buttonStyle;
  final Color buttonColor;
  final BorderRadius borderRadius;
  const DefaultButton({
    Key? key,
    this.height = 50,
    this.width = 315,
    required this.widget,
    required this.onPressed,
    this.buttonColor = lightPrimaryColor,
    this.buttonStyle,
    this.borderRadius = Corners.verylgBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        child: widget,
        style: buttonStyle ??
            ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => buttonColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: borderRadius,
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
              shadowColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.transparent),
              overlayColor: MaterialStateProperty.resolveWith(
                  (states) => lightPrimaryColor.withOpacity(0.5)),
            ),
      ),
    );
  }
}
