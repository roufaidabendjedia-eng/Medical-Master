import 'package:flutter/material.dart';

import 'views/screens/intro_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A9C98)),
        useMaterial3: true,
      ),
      home: const IntroScreen(),
    );
  }
}
