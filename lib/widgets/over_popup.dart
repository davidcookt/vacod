import 'package:flutter/material.dart';

class OverPopupPage extends StatefulWidget {
  final Offset showOffset;
  final Size buttonSize;
  final Function didChooseItem;

  OverPopupPage(
      {required this.showOffset,
      required this.buttonSize,
      required this.didChooseItem});

  @override
  _OverPopupPageState createState() => _OverPopupPageState();
}

class _OverPopupPageState extends State<OverPopupPage> {
  final List<Color> listColor = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent
  ];

  var opacity = 0.0;
  var heightPop = 0.0;
  var widthPop = 0.0;

  void _show(bool isVisible) {
    setState(() {
      opacity = isVisible ? 1.0 : 0.0;
      heightPop = isVisible ? 60.0 : 0.0;
      widthPop = isVisible ? 300.0 : 0.0;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _show(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(child: GestureDetector(
            onTap: () {
              _show(false);
              Navigator.of(context).pop();
            },
          )),
          Positioned(
              top: widget.showOffset.dy + widget.buttonSize.height + 10.0,
              left: widget.showOffset.dx - 80,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0)),
                  height: heightPop,
                  width: widthPop,
                  duration: Duration(milliseconds: 300),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    scrollDirection: Axis.horizontal,
                    children: listColor
                        .map((color) => InkWell(
                              onTap: () {
                                _show(false);
                                Navigator.of(context).pop();
                                widget.didChooseItem(color);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: CircleAvatar(
                                  backgroundColor: color,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
