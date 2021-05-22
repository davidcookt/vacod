import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:vacod/pages/home/home.dart';
import 'package:vacod/pages/authorization/login/login.dart';
import 'package:vacod/pages/authorization/sign_up/sign_up.dart';
import 'package:vacod/providers/login.dart';
import 'package:vacod/providers/sign_up.dart';
import 'package:vacod/providers/theme.dart';
import 'package:vacod/routes/routes.dart';
import 'package:vacod/theme/theme.dart';

import 'providers/app_language.dart';
import 'utils/app_localizations.dart';

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
        ChangeNotifierProvider<LoginProvider>(
            create: (_) => LoginProvider.instance()),
        ChangeNotifierProvider<SignUpProvider>(create: (_) => SignUpProvider()),
      ],
      builder: (context, child) => MaterialApp(
        home: showScreen(context),
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: context.watch<ThemeProvider>().currentThemeMode,
        supportedLocales: [
          Locale('vi', ''),
          Locale('en', 'US'),
        ],
        locale: context.watch<AppLanguage>().appLocal,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // builder: (context, widget) => ResponsiveWrapper.builder(
        //   BouncingScrollWrapper.builder(context, widget),
        //   maxWidth: 1200,
        //   minWidth: 320,
        //   defaultScale: true,
        //   breakpoints: [
        //     ResponsiveBreakpoint.resize(320, name: MOBILE),
        //     ResponsiveBreakpoint.autoScale(380, name: MOBILE),
        //     ResponsiveBreakpoint.autoScale(800, name: TABLET),
        //     ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        //     ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        //     ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        //   ],
        // ),
      ),
    );
  }

  Widget showScreen(BuildContext context) {
    switch (context.watch<LoginProvider>().appState) {
      case AppState.authenticating:
      case AppState.unauthenticated:
        return LoginPage();
      case AppState.initial:
        return Container();
      case AppState.authenticated:
        return HomePage();
    }
    return Container();
  }
}
