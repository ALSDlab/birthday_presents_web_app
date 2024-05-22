import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myk_market_app/di/get_it.dart';
import 'package:myk_market_app/router.dart';
import 'package:myk_market_app/url_strategy_mobile.dart'
if (dart.library.html) 'package:myk_market_app/url_strategy_web.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  diSetup();
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
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F362F))
              .copyWith(surface: Colors.white),
        ),
        routerConfig: router,
      ),
    );
  }
}
