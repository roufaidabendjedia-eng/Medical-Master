import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../models/user_role.dart';
import '../widgets/backgrounds/login_background.dart';
import '../widgets/common/delayed_fade_slide.dart';
import '../widgets/common/glass_panel.dart';
import '../widgets/common/glow_button.dart';
import 'patient_dashboard_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final controller = AuthController(role);
    void openDashboard() {
      if (controller.canOpenPatientDashboard) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PatientDashboardScreen()),
        );
        return;
      }
      if (controller.canOpenProfessionalDashboard) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProfessionalDashboardScreen(),
          ),
        );
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF0F2A3C),
        title: Text('Accès ${controller.roleLabel}'),
      ),
      body: Stack(
        children: [
          const LoginBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DelayedFadeSlide(
                    delay: const Duration(milliseconds: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bienvenue',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: const Color(0xFF3C6E8C),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Connexion rapide et sécurisée',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: const Color(0xFF0F2A3C),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Renseignez vos informations pour continuer.',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: const Color(0xFF3C6E8C)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  DelayedFadeSlide(
                    delay: const Duration(milliseconds: 180),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF5AA9E6), Color(0xFFBFE2FF)],
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.health_and_safety,
                              color: Color(0xFF5AA9E6),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.roleLabel,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Accès personnalisé à vos dossiers',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  DelayedFadeSlide(
                    delay: const Duration(milliseconds: 220),
                    child: GlassPanel(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextField(
                              decoration: _buildInputDecoration(
                                'Nom',
                                icon: Icons.person,
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextField(
                              decoration: _buildInputDecoration(
                                'Email',
                                icon: Icons.email,
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextField(
                              decoration: _buildInputDecoration(
                                'Mot de passe',
                                icon: Icons.lock,
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            GlowButton(
                              label: 'Créer un compte',
                              colors: const [
                                Color(0xFF5AA9E6),
                                Color(0xFF9AD7FF),
                              ],
                              onPressed: openDashboard,
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: openDashboard,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF0F2A3C),
                                side: const BorderSide(
                                  color: Color(0xFF9AD7FF),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Text('Se connecter'),
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

  InputDecoration _buildInputDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF3C6E8C)),
      prefixIcon: icon == null
          ? null
          : Icon(icon, color: const Color(0xFF3C6E8C)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFD9F0FF)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFD9F0FF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF5AA9E6)),
      ),
    );
  }
}
