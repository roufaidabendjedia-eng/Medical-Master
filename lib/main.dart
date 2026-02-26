import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

const Color kAccent = Color(0xFF64D3C6);
const Color kAccent2 = Color(0xFF4C6FFF);

Color _withOpacity(Color color, double opacity) {
  return color.withValues(alpha: opacity);
}

InputDecoration _inputDecoration(String label, {IconData? icon}) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Colors.white70),
    prefixIcon: icon == null ? null : Icon(icon, color: Colors.white70),
    filled: true,
    fillColor: _withOpacity(Colors.white, 0.08),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.white24),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.white24),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: kAccent),
    ),
  );
}

void main() {
  runApp(const MyApp());
}

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
            child: _FloatingOrb(
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
            child: _FloatingOrb(
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
                            color: _withOpacity(Colors.white, 0.2),
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
                    "MediPulse",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Suivi intelligent de votre santé",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Centralisez vos données médicales et échangez avec des professionnels en toute simplicité.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, height: 1.4),
                    ),
                  ),
                  const SizedBox(height: 26),
                  _DelayedFadeSlide(
                    delay: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: 220,
                      child: _GlowButton(
                        label: "Commencer",
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

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

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
            top: -70,
            right: -40,
            child: _FloatingOrb(
              size: 220,
              colors: [Color(0xFF8AF5E7), Color(0xFF20C9BC)],
              dx: 18,
              dy: 12,
              duration: Duration(milliseconds: 4600),
            ),
          ),
          const Positioned(
            bottom: -100,
            left: -60,
            child: _FloatingOrb(
              size: 260,
              colors: [Color(0xFF8B7BFF), Color(0xFF4CC6FF)],
              dx: 16,
              dy: 10,
              duration: Duration(milliseconds: 5200),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DelayedFadeSlide(
                    delay: const Duration(milliseconds: 120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bienvenue",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Choisissez votre rôle",
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6AF0E0), Color(0xFF4B6CFF)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _withOpacity(Colors.white, 0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.bolt, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  _DelayedFadeSlide(
                    delay: const Duration(milliseconds: 220),
                    child: _GlassPanel(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Identité de l’application",
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Un accès rapide aux informations clés et aux actions essentielles.",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _RoleCard(
                                    title: "Patient",
                                    subtitle: "Suivi de vos données médicales",
                                    icon: Icons.favorite,
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const AuthScreen(
                                          role: UserRole.patient,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _RoleCard(
                                    title: "Professionnel",
                                    subtitle: "Gestion de plusieurs patients",
                                    icon: Icons.medical_services,
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const AuthScreen(
                                          role: UserRole.professionnel,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  _DelayedFadeSlide(
                    delay: const Duration(milliseconds: 380),
                    child: Text(
                      "Après votre choix, vous serez redirigé vers l’inscription ou la connexion.",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
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

enum UserRole { patient, professionnel }

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.role});

  final UserRole role;

  String get _roleLabel =>
      role == UserRole.patient ? "Patient" : "Professionnel de santé";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text("Accès $_roleLabel"),
      ),
      body: Stack(
        children: [
          const _LoginBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DelayedFadeSlide(
                    delay: const Duration(milliseconds: 120),
                    child: Text(
                      "Renseignez vos informations pour continuer.",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _DelayedFadeSlide(
                    delay: const Duration(milliseconds: 220),
                    child: _GlassPanel(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextField(
                              decoration: _inputDecoration(
                                "Nom",
                                icon: Icons.person,
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextField(
                              decoration: _inputDecoration(
                                "Email",
                                icon: Icons.email,
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextField(
                              decoration: _inputDecoration(
                                "Mot de passe",
                                icon: Icons.lock,
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            _GlowButton(
                              label: "Créer un compte",
                              colors: const [kAccent, kAccent2],
                              onPressed: () {
                                if (role == UserRole.patient) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const PatientDashboardScreen(),
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white30),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text("Se connecter"),
                            ),
                          ],
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

class PatientDashboardScreen extends StatefulWidget {
  const PatientDashboardScreen({super.key});

  @override
  State<PatientDashboardScreen> createState() => _PatientDashboardScreenState();
}

class _PatientDashboardScreenState extends State<PatientDashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _MedicalBackground(),
          const Positioned(
            top: -80,
            right: -60,
            child: _FloatingOrb(
              size: 220,
              colors: [Color(0xFF7B61FF), Color(0xFF49E2D4)],
              dx: 18,
              dy: 12,
              duration: Duration(milliseconds: 5200),
            ),
          ),
          const Positioned(
            bottom: -100,
            left: -70,
            child: _FloatingOrb(
              size: 240,
              colors: [Color(0xFF8AF5E7), Color(0xFF20C9BC)],
              dx: 16,
              dy: 10,
              duration: Duration(milliseconds: 5600),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tableau de bord patient",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Vos indicateurs vitaux du jour",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 22),
                  _VitalCard(
                    title: "Rythme cardiaque",
                    value: "72 bpm",
                    icon: Icons.favorite,
                    colors: const [Color(0xFF20C9BC), Color(0xFF64F5E6)],
                  ),
                  const SizedBox(height: 16),
                  _VitalCard(
                    title: "Température",
                    value: "36.8°C",
                    icon: Icons.thermostat,
                    colors: const [Color(0xFF4CC6FF), Color(0xFF8B7BFF)],
                  ),
                  const SizedBox(height: 16),
                  _VitalCard(
                    title: "Fréquence respiratoire",
                    value: "16 rpm",
                    icon: Icons.air,
                    colors: const [Color(0xFF49E2D4), Color(0xFF7B61FF)],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFF0F1D2E),
        selectedItemColor: kAccent,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Profil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_rounded),
            label: "Notifications",
          ),
        ],
      ),
    );
  }
}

class _LoginBackground extends StatelessWidget {
  const _LoginBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A3B85), Color(0xFF2E6CC9), Color(0xFF1F4B9E)],
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
                colors: [Color(0xFF7FB3FF), Colors.transparent],
                center: Alignment(-0.2, -0.6),
                radius: 1.2,
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.18,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Color(0xFF0B1C3B)],
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

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [Color(0xFF1E3A58), Color(0xFF2B6C82)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: _withOpacity(Colors.black, 0.2),
              blurRadius: 16,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: _withOpacity(Colors.white, 0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white),
              ),
              const Spacer(),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MedicalBackground extends StatefulWidget {
  const _MedicalBackground();

  @override
  State<_MedicalBackground> createState() => _MedicalBackgroundState();
}

class _MedicalBackgroundState extends State<_MedicalBackground>
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
                      Color(0xFF0F1D2E),
                      Color(0xFF124B6B),
                      Color(0xFF0FD1C6),
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
                      colors: const [Color(0xFF64F5E6), Colors.transparent],
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

class _VitalCard extends StatelessWidget {
  const _VitalCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.colors,
  });

  final String title;
  final String value;
  final IconData icon;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(colors: colors),
                boxShadow: [
                  BoxShadow(
                    color: _withOpacity(colors.last, 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingOrb extends StatefulWidget {
  const _FloatingOrb({
    required this.size,
    required this.colors,
    required this.dx,
    required this.dy,
    required this.duration,
  });

  final double size;
  final List<Color> colors;
  final double dx;
  final double dy;
  final Duration duration;

  @override
  State<_FloatingOrb> createState() => _FloatingOrbState();
}

class _FloatingOrbState extends State<_FloatingOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value * math.pi * 2;
        final offset = Offset(math.sin(t) * widget.dx, math.cos(t) * widget.dy);
        return Transform.translate(offset: offset, child: child);
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: widget.colors),
          boxShadow: [
            BoxShadow(
              color: _withOpacity(widget.colors.last, 0.4),
              blurRadius: 40,
              offset: const Offset(0, 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white24),
            gradient: LinearGradient(
              colors: [
                _withOpacity(Colors.white, 0.18),
                _withOpacity(Colors.white, 0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GlowButton extends StatelessWidget {
  const _GlowButton({
    required this.label,
    required this.colors,
    required this.onPressed,
  });

  final String label;
  final List<Color> colors;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const height = 48.0;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: _withOpacity(colors.last, 0.35),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DelayedFadeSlide extends StatefulWidget {
  const _DelayedFadeSlide({required this.child, required this.delay});

  final Widget child;
  final Duration delay;

  @override
  State<_DelayedFadeSlide> createState() => _DelayedFadeSlideState();
}

class _DelayedFadeSlideState extends State<_DelayedFadeSlide> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 700);
    const offsetY = 0.2;
    return AnimatedOpacity(
      duration: duration,
      opacity: _visible ? 1 : 0,
      child: AnimatedSlide(
        duration: duration,
        curve: Curves.easeOutCubic,
        offset: _visible ? Offset.zero : const Offset(0, offsetY),
        child: widget.child,
      ),
    );
  }
}
