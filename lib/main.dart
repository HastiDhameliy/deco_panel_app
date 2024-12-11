import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'RoutesManagment/pages.dart';
import 'RoutesManagment/routes.dart';
import 'RoutesManagment/screen_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DecoApp',
      color: Colors.white,
      theme: ThemeData(
        colorScheme:
            const ColorScheme.highContrastLight(background: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: RouteConstants.splashScreen,
      getPages: AllPages.getPages(),
      initialBinding: ScreenBindings(),
    );
  }
}
