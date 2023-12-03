import 'dart:async';

import 'package:bahn_bingo/di/service_locator.dart';
import 'package:bahn_bingo/presentation/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bfzldpgqxfeeovchjwdw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJmemxkcGdxeGZlZW92Y2hqd2R3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE1NjU3MTIsImV4cCI6MjAxNzE0MTcxMn0.ysbZBobLsQVpBaFnXCK_UP1kwxcXYCplfLO_IhmSuRI',
    authFlowType: AuthFlowType.pkce,
  );

  await setPreferredOrientations();
  await ServiceLocator.configureDependencies();

  runApp(MyApp());
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

final supabase = Supabase.instance.client;
