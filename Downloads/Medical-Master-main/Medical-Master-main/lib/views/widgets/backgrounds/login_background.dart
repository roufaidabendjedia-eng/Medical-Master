import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4FA3E3), Color(0xFF9AD7FF), Color(0xFFF7FCFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Opacity(
          opacity: 0.22,
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFFD9F0FF), Colors.transparent],
                center: Alignment(-0.2, -0.6),
                radius: 1.2,
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.12,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Color(0xFF2D5F8F)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.12,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white,
                  Colors.transparent,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0.0, 0.18, 0.36, 0.58, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
