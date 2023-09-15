import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'Providers/app_provider.dart';
import 'Screen/Home/home.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => AppProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: Home(),
      builder: EasyLoading.init(),
    );
  }
}
