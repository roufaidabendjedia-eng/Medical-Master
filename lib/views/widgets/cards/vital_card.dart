import 'package:flutter/material.dart';

import '../../../core/utils/color_utils.dart';
import '../common/glass_panel.dart';

class VitalCard extends StatelessWidget {
  const VitalCard({
    super.key,
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
    return GlassPanel(
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
                    color: withOpacity(colors.last, 0.35),
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
