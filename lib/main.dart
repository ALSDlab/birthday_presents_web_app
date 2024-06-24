import 'package:Birthday_Presents_List/router.dart';
import 'package:Birthday_Presents_List/url_strategy_mobile.dart'
    if (dart.library.html) 'package:Birthday_Presents_List/url_strategy_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'di/get_it.dart';
import 'firebase_options.dart';

Future<ByteData> fetchFont() async {
  return rootBundle.load('assets/fonts/KoPubWorld Dotum Bold.ttf');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  diSetup();
  var fontLoader = FontLoader('Kopub');
  fontLoader.addFont(fetchFont());
  await fontLoader.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 900),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          fontFamily: 'Kopub',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFF9C4))
              .copyWith(surface: Colors.black),
        ),
        routerConfig: router,
      ),
    );
  }
}
