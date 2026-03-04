import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/patient_dashboard_controller.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/backgrounds/medical_background.dart';
import '../widgets/cards/vital_card.dart';
import '../widgets/common/glass_panel.dart';

class PatientDashboardScreen extends StatefulWidget {
  const PatientDashboardScreen({super.key});

  @override
  State<PatientDashboardScreen> createState() => _PatientDashboardScreenState();
}

class _PatientDashboardScreenState extends State<PatientDashboardScreen> {
  final PatientDashboardController _controller = PatientDashboardController();

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
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  child: SingleChildScrollView(child: _buildContent(context)),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _controller.selectedIndex,
            onTap: _controller.onTabChanged,
            backgroundColor: const Color(0xFFEAF6FF),
            selectedItemColor: kAccent,
            unselectedItemColor: const Color(0xFF5A84A6),
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

  Widget _buildContent(BuildContext context) {
    switch (_controller.selectedIndex) {
      case 1:
        return _buildProfile(context);
      case 2:
        return _buildNotifications(context);
      default:
        return _buildDashboard(context);
    }
  }

  Widget _buildDashboard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tableau de bord patient',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Vos indicateurs vitaux du jour',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 22),
        const VitalCard(
          title: 'Rythme cardiaque',
          value: '72 bpm',
          icon: Icons.favorite,
          colors: [Color(0xFF5AA9E6), Color(0xFFD9F0FF)],
        ),
        const SizedBox(height: 16),
        const VitalCard(
          title: 'Température',
          value: '36.8°C',
          icon: Icons.thermostat,
          colors: [Color(0xFF4FA3E3), Color(0xFFCFEAFF)],
        ),
        const SizedBox(height: 16),
        const VitalCard(
          title: 'Fréquence respiratoire',
          value: '16 rpm',
          icon: Icons.air,
          colors: [Color(0xFF7DBEF0), Color(0xFFF7FCFF)],
        ),
      ],
    );
  }

  Widget _buildProfile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profil patient',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Informations du patient',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 22),
        GlassPanel(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                SizedBox(
                  width: 72,
                  height: 72,
                  child: ClipOval(
                    child: Image.asset(
                      _controller.patientPhotoAssetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) {
                        return Image.network(
                          _controller.patientPhotoUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, _, __) {
                            return Container(
                              color: Colors.white10,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white70,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _controller.patientName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Patient',
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.location_on, color: Colors.white),
                    onPressed: () => _openPatientLocation(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openPatientLocation(BuildContext context) async {
    final lat = _controller.patientLatitude;
    final lng = _controller.patientLongitude;
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    final canLaunch = await canLaunchUrl(url);
    if (!context.mounted) {
      return;
    }
    if (!canLaunch) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تعذر فتح الخريطة')));
      return;
    }
    final launched = await launchUrl(url, mode: LaunchMode.externalApplication);
    if (!context.mounted) {
      return;
    }
    if (!launched) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تعذر فتح الخريطة')));
    }
  }

  Widget _buildNotifications(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifications',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Vos messages récents',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 22),
        GlassPanel(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Aucune notification pour le moment.',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: Colors.white70),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfessionalPatient {
  const _ProfessionalPatient({
    required this.name,
    required this.subtitle,
    required this.photoAssetPath,
    required this.photoUrl,
    required this.temperature,
    required this.heartRate,
    required this.respiratoryRate,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final String subtitle;
  final String photoAssetPath;
  final String photoUrl;
  final double temperature;
  final int heartRate;
  final int respiratoryRate;
  final double latitude;
  final double longitude;
}

class ProfessionalDashboardScreen extends StatefulWidget {
  const ProfessionalDashboardScreen({super.key});

  @override
  State<ProfessionalDashboardScreen> createState() =>
      _ProfessionalDashboardScreenState();
}

class _ProfessionalDashboardScreenState
    extends State<ProfessionalDashboardScreen> {
  final List<_ProfessionalPatient> _patients = const [
    _ProfessionalPatient(
      name: 'Amina El Idrissi',
      subtitle: 'Suivi cardiologique',
      photoAssetPath: 'assets/images/humberto-chavez-FVh_yqLR9eA-unsplash.jpg',
      photoUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=facearea&w=256&h=256&q=80',
      temperature: 36.8,
      heartRate: 72,
      respiratoryRate: 16,
      latitude: 33.5731,
      longitude: -7.5898,
    ),
    _ProfessionalPatient(
      name: 'Youssef Amrani',
      subtitle: 'Suivi diabète',
      photoAssetPath: 'assets/images/humberto-chavez-FVh_yqLR9eA-unsplash.jpg',
      photoUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=facearea&w=256&h=256&q=80',
      temperature: 37.1,
      heartRate: 80,
      respiratoryRate: 18,
      latitude: 34.0209,
      longitude: -6.8416,
    ),
    _ProfessionalPatient(
      name: 'Salma Benjelloun',
      subtitle: 'Suivi post-opératoire',
      photoAssetPath: 'assets/images/humberto-chavez-FVh_yqLR9eA-unsplash.jpg',
      photoUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=facearea&w=256&h=256&q=80',
      temperature: 36.5,
      heartRate: 68,
      respiratoryRate: 15,
      latitude: 31.6295,
      longitude: -7.9811,
    ),
  ];
  int _selectedPatientIndex = 0;

  _ProfessionalPatient get _selectedPatient => _patients[_selectedPatientIndex];

  @override
  Widget build(BuildContext context) {
    final patient = _selectedPatient;
    return Scaffold(
      body: Stack(
        children: [
          const MedicalBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patients pris en charge',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sélectionnez un patient pour voir ses données',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    _buildPatientList(context),
                    const SizedBox(height: 22),
                    GlassPanel(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 72,
                              height: 72,
                              child: ClipOval(
                                child: Image.asset(
                                  patient.photoAssetPath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, _, __) {
                                    return Image.network(
                                      patient.photoUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, _, __) {
                                        return Container(
                                          color: Colors.white10,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white70,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    patient.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    patient.subtitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                onPressed: () => _openPatientLocation(
                                  context,
                                  patient.latitude,
                                  patient.longitude,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Données médicales détaillées',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Mesures actuelles du patient sélectionné',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 18),
                    VitalCard(
                      title: 'Température corporelle',
                      value: '${patient.temperature.toStringAsFixed(1)}°C',
                      icon: Icons.thermostat,
                      colors: const [Color(0xFF4FA3E3), Color(0xFFCFEAFF)],
                    ),
                    const SizedBox(height: 14),
                    VitalCard(
                      title: 'Fréquence cardiaque',
                      value: '${patient.heartRate} bpm',
                      icon: Icons.favorite,
                      colors: const [Color(0xFF5AA9E6), Color(0xFFD9F0FF)],
                    ),
                    const SizedBox(height: 14),
                    VitalCard(
                      title: 'Fréquence respiratoire',
                      value: '${patient.respiratoryRate} rpm',
                      icon: Icons.air,
                      colors: const [Color(0xFF7DBEF0), Color(0xFFF7FCFF)],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientList(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < _patients.length; i++) ...[
          _buildPatientTile(context, _patients[i], i),
          if (i != _patients.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _buildPatientTile(
    BuildContext context,
    _ProfessionalPatient patient,
    int index,
  ) {
    final isSelected = index == _selectedPatientIndex;
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          return;
        }
        setState(() {
          _selectedPatientIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: isSelected ? kAccent : Colors.transparent,
            width: 1.4,
          ),
        ),
        child: GlassPanel(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 54,
                  height: 54,
                  child: ClipOval(
                    child: Image.asset(
                      patient.photoAssetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) {
                        return Image.network(
                          patient.photoUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, _, __) {
                            return Container(
                              color: Colors.white10,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white70,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        patient.subtitle,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openPatientLocation(
    BuildContext context,
    double lat,
    double lng,
  ) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    final canLaunch = await canLaunchUrl(url);
    if (!context.mounted) {
      return;
    }
    if (!canLaunch) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تعذر فتح الخريطة')));
      return;
    }
    final launched = await launchUrl(url, mode: LaunchMode.externalApplication);
    if (!context.mounted) {
      return;
    }
    if (!launched) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تعذر فتح الخريطة')));
    }
  }
}
