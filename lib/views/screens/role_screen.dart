import 'package:flutter/material.dart';

import '../../core/utils/color_utils.dart';
import '../../models/user_role.dart';
import '../widgets/cards/role_card.dart';
import '../widgets/common/delayed_fade_slide.dart';
import '../widgets/common/floating_orb.dart';
import '../widgets/common/glass_panel.dart';
import 'auth_screen.dart';

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
            child: FloatingOrb(
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
            child: FloatingOrb(
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
                  DelayedFadeSlide(
                    delay: const Duration(milliseconds: 120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bienvenue',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Choisissez votre rôle',
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
                                color: withOpacity(Colors.white, 0.2),
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
                  DelayedFadeSlide(
                    delay: const Duration(milliseconds: 220),
                    child: GlassPanel(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Identité de l’application',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Un accès rapide aux informations clés et aux actions essentielles.',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: RoleCard(
                                    title: 'Patient',
                                    subtitle: 'Suivi de vos données médicales',
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
                                  child: RoleCard(
                                    title: 'Professionnel',
                                    subtitle: 'Gestion de plusieurs patients',
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
                  DelayedFadeSlide(
                    delay: const Duration(milliseconds: 380),
                    child: Text(
                      'Après votre choix, vous serez redirigé vers l’inscription ou la connexion.',
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
