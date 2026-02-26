import 'package:flutter/material.dart';

import '../../core/utils/color_utils.dart';
import '../widgets/common/delayed_fade_slide.dart';
import '../widgets/common/floating_orb.dart';
import '../widgets/common/glow_button.dart';
import 'role_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _pulse = Tween<double>(
      begin: 0.96,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B2D2B),
                  Color(0xFF0E5E5A),
                  Color(0xFF0FD1C6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          const Positioned(
            top: -60,
            right: -40,
            child: FloatingOrb(
              size: 200,
              colors: [Color(0xFF8AF5E7), Color(0xFF20C9BC)],
              dx: 16,
              dy: 12,
              duration: Duration(milliseconds: 4200),
            ),
          ),
          const Positioned(
            bottom: -80,
            left: -60,
            child: FloatingOrb(
              size: 240,
              colors: [Color(0xFF8B7BFF), Color(0xFF4CC6FF)],
              dx: 18,
              dy: 14,
              duration: Duration(milliseconds: 5200),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _pulse,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6AF0E0), Color(0xFF4B6CFF)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: withOpacity(Colors.white, 0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'MediPulse',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Suivi intelligent de votre santé',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Centralisez vos données médicales et échangez avec des professionnels en toute simplicité.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, height: 1.4),
                    ),
                  ),
                  const SizedBox(height: 26),
                  DelayedFadeSlide(
                    delay: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: 220,
                      child: GlowButton(
                        label: 'Commencer',
                        colors: const [Color(0xFF64F5E6), Color(0xFF4C6FFF)],
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RoleScreen()),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
