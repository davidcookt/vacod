import 'package:flutter/material.dart';
import 'package:vacod/utils/index.dart';
import 'dart:math' as math;

class AuthorizationTemplate extends StatelessWidget {
  final Widget? widget;
  const AuthorizationTemplate({Key? key, @required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppConstant.hideKeyboard(context),
      child: Scaffold(
        backgroundColor: lightPrimaryColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 135,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  child: Stack(
                    children: [
                      Positioned(
                        top: -64,
                        left: 100,
                        child: Transform.rotate(
                          angle: math.pi / 6,
                          child: Container(
                            width: 62,
                            height: 126,
                            decoration: BoxDecoration(
                              color: lightAccentColor,
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: 30,
                        child: SizedBox(
                          height: 76,
                          width: 75,
                          child: AppIcons.smallLogo,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [widget!],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
