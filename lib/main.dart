import 'package:flutter/material.dart';
import 'package:musong_cafe/database/database_helper.dart';
import 'package:musong_cafe/views/insert_name.dart';
import 'package:musong_cafe/views/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.db;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 4)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Splash();
        } else {
          return MaterialApp(
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                canvasColor: Colors.black,
              ),
              debugShowCheckedModeBanner: false,
              home: InputName());
        }
      },
    );
  }
}
