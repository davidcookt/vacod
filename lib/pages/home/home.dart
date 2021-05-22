import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/providers/app_language.dart';
import 'package:vacod/providers/theme.dart';
import 'package:vacod/utils/app_localizations.dart';
import 'package:vacod/widgets/over_popup.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var buttonColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ABC'),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              AppLocalizations.of(context).translate('title'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var currentThemeState = ThemeState.dark;
              // Provider.of<ThemeProvider>(context, listen: false)
              //     .doChangeTheme(currentThemeState);
              context.read<ThemeProvider>().doChangeTheme(currentThemeState);
            },
            child: Text('Change Theme Dark'),
          ),
          ElevatedButton(
            onPressed: () {
              var currentThemeState = ThemeState.light;
              // Provider.of<ThemeProvider>(context, listen: false)
              //     .doChangeTheme(currentThemeState);
              context.read<ThemeProvider>().doChangeTheme(currentThemeState);
            },
            child: Text('Change Theme Light'),
          ),
          Text(
            AppLocalizations.of(context).translate('Message'),
            style: TextStyle(fontSize: 32),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  appLanguage.changeLanguage(Locale("en"));
                },
                child: Text('English'),
              ),
              ElevatedButton(
                onPressed: () {
                  appLanguage.changeLanguage(Locale("vi"));
                },
                child: Text('Tiếng Việt'),
              )
            ],
          ),
          ElevatedButton(
              key: myKey,
              style: ElevatedButton.styleFrom(primary: buttonColor),
              onPressed: () {
                RenderBox renderBox =
                    myKey.currentContext?.findRenderObject() as RenderBox;
                final tapLocationOffset = renderBox.localToGlobal(Offset.zero);
                final Size buttonSize = renderBox.size;
                //Todo: Show the popup
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation1, animation2) {
                      return OverPopupPage(
                        showOffset: tapLocationOffset,
                        buttonSize: buttonSize,
                        didChooseItem: (color) {
                          setState(() {
                            buttonColor = color;
                          });
                        },
                      );
                    }));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("Day 1"),
              )),
        ],
      ),
    );
  }
}
