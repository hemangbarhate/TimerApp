import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resqroom_escape/screens/home_screen.dart';

import 'models/StopwatchOperation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StopwatchOperation>(
      create: (BuildContext context) => StopwatchOperation(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
