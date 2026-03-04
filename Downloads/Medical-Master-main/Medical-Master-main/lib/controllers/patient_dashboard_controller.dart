import 'package:flutter/foundation.dart';

class PatientDashboardController extends ChangeNotifier {
  int _selectedIndex = 0;
  final String _patientName = 'Amina El Idrissi';
  final String _patientPhotoAssetPath =
      'assets/images/humberto-chavez-FVh_yqLR9eA-unsplash.jpg';
  final double _patientLatitude = 33.5731;
  final double _patientLongitude = -7.5898;
  final String _patientPhotoUrl =
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=facearea&w=256&h=256&q=80';

  int get selectedIndex => _selectedIndex;
  String get patientName => _patientName;
  String get patientPhotoAssetPath => _patientPhotoAssetPath;
  double get patientLatitude => _patientLatitude;
  double get patientLongitude => _patientLongitude;
  String get patientPhotoUrl => _patientPhotoUrl;

  void onTabChanged(int index) {
    if (_selectedIndex == index) {
      return;
    }
    _selectedIndex = index;
    notifyListeners();
  }
}
