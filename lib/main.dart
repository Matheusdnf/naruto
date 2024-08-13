import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controller/dependency.dart';
import 'package:teste/screens/screen_routes/tela_inicio.dart';

Future<void> main() async {
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstScream(),
    );
  }
}
