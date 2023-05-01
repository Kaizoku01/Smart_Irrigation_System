import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:irrigation_control_panel/globalConstants.dart' as global;
import 'homePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    global.deviceHeight = size.height;
    global.deviceWidth = size.width;
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Jost'),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


