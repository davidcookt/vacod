import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:vacod/app.dart';
import 'package:vacod/init/firebase.dart';
import 'package:vacod/models/house.dart';
import 'package:vacod/models/service.dart';
import 'package:vacod/providers/app_language.dart';
import 'package:vacod/providers/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  await Hive.initFlutter();
  Hive.registerAdapter(HouseAdapter());
  Hive.registerAdapter(ServiceAdapter());
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  Provider.debugCheckInvalidValueType = null;
}
