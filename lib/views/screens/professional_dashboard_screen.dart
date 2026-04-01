import 'package:flutter/material.dart';
import 'package:mon_app/controllers/professional_dashboard_controller.dart';

import '../../core/theme/app_colors.dart';
import '../widgets/backgrounds/medical_background.dart';
import '../widgets/cards/vital_card.dart';
import '../widgets/common/floating_orb.dart';

class ProfessionalDashboardScreen extends StatefulWidget {
  const ProfessionalDashboardScreen({super.key});

  @override
  State<ProfessionalDashboardScreen> createState() => _ProfessionalDashboardScreenState();
}

class _ProfessionalDashboardScreenState extends State<ProfessionalDashboardScreen> {
  final ProfessionalDashboardController _controller = ProfessionalDashboardController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          body: Stack(
            children: [
              const MedicalBackground(),
              const Positioned(
                top: -80,
                right: -60,
                child: FloatingOrb(
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
                child: FloatingOrb(
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
                        'Tableau de bord Professional',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Vos indicateurs vitaux du jour',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 22),
                      const VitalCard(
                        title: 'Rythme cardiaque',
                        value: '72 bpm',
                        icon: Icons.favorite,
                        colors: [Color(0xFF20C9BC), Color(0xFF64F5E6)],
                      ),
                      const SizedBox(height: 16),
                      const VitalCard(
                        title: 'Température',
                        value: '36.8°C',
                        icon: Icons.thermostat,
                        colors: [Color(0xFF4CC6FF), Color(0xFF8B7BFF)],
                      ),
                      const SizedBox(height: 16),
                      const VitalCard(
                        title: 'Fréquence respiratoire',
                        value: '16 rpm',
                        icon: Icons.air,
                        colors: [Color(0xFF49E2D4), Color(0xFF7B61FF)],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _controller.selectedIndex,
            onTap: _controller.onTabChanged,
            backgroundColor: const Color(0xFF0F1D2E),
            selectedItemColor: kAccent,
            unselectedItemColor: Colors.white60,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_rounded),
                label: 'Notifications',
              ),
            ],
          ),
        );
      },
    );
  }
}
