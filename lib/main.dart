import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controller/dependency.dart';
import 'package:teste/scream/first_scream.dart';

Future<void> main() async {
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScream(),
    );
  }
}
