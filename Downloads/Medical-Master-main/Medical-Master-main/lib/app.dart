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
          primary: const Color(0xFF5AA9E6),
          onPrimary: Colors.white,
          secondary: const Color(0xFF9AD7FF),
          onSecondary: const Color(0xFF0F2A3C),
          surface: Colors.white,
          onSurface: const Color(0xFF0F2A3C),
          error: Colors.red,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF5AA9E6),
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const IntroScreen(),
    );
  }
}
