import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/app.dart';
import 'package:vacod/init/firebase.dart';
import 'package:vacod/providers/app_language.dart';
import 'package:vacod/providers/theme.dart';

void main() async {
  await init();
  runApp(
    MyApp(),
  );
}

GlobalKey myKey = GlobalKey();

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  Provider.debugCheckInvalidValueType = null;
}
