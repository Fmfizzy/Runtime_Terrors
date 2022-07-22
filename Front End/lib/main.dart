import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:wevolve_project/screens/homePage.dart';


void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const WeVolve(), // Wrap your app
  ),
);

class WeVolve extends StatelessWidget {
  const WeVolve({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      darkTheme: ThemeData.dark(),
      title: 'WeVolve',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: homePage(),
    );
  }
}




