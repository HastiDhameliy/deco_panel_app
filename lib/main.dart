import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'RoutesManagment/pages.dart';
import 'RoutesManagment/routes.dart';
import 'RoutesManagment/screen_bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBal17y1PxbqIAM7jl5AlPTnM5AXibiVI0',
      appId: '1:872125002397:android:35d6af0685296fe640da74',
      messagingSenderId: '885031020744',
      projectId: 'deco-panel',
      storageBucket: 'deco-panel.firebasestorage.app',
    ),
  );
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
