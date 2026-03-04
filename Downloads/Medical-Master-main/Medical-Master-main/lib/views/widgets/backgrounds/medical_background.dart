import 'dart:math' as math;

import 'package:flutter/material.dart';

class MedicalBackground extends StatefulWidget {
  const MedicalBackground({super.key});

  @override
  State<MedicalBackground> createState() => _MedicalBackgroundState();
}

class _MedicalBackgroundState extends State<MedicalBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 9000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = _controller.value;
          final begin = Alignment.lerp(
            Alignment.topLeft,
            Alignment.topRight,
            t,
          );
          final end = Alignment.lerp(
            Alignment.bottomRight,
            Alignment.bottomLeft,
            t,
          );
          final glowCenter = Alignment.lerp(
            Alignment.topRight,
            Alignment.bottomLeft,
            t,
          );
          final glowOpacity = 0.12 + (0.12 * math.sin(t * math.pi * 2));
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xFF4FA3E3),
                      Color(0xFF9AD7FF),
                      Color(0xFFF7FCFF),
                    ],
                    begin: begin ?? Alignment.topLeft,
                    end: end ?? Alignment.bottomRight,
                  ),
                ),
              ),
              Opacity(
                opacity: glowOpacity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: const [Color(0xFFD9F0FF), Colors.transparent],
                      center: glowCenter ?? Alignment.topRight,
                      radius: 1.1,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
