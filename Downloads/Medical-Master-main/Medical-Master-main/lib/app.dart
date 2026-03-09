import 'package:flutter/material.dart';
import 'views/screens/intro_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon App',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.white,
          onPrimary: const Color(0xFF0F2A3C),
          secondary: const Color(0xFF5AA9E6),
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: const Color(0xFF0F2A3C),
          error: Colors.red,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0F2A3C),
        ),
        useMaterial3: true,
      ),
      home: const IntroScreen(),
    );
  }
}
