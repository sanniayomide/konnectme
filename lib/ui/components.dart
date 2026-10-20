import 'package:flutter/material.dart';
import 'app_theme.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key});

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.teal, borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.hub_rounded, color: Colors.white)),
    const SizedBox(width: 12),
    const Text('konnectme', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -1)),
  ]);
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), border: Border.all(color: const Color(0xFFE1E7E2))),
    child: child,
  );
}

class DevicePreference extends StatelessWidget {
  const DevicePreference({required this.title, required this.subtitle, required this.icon, required this.value, required this.onChanged, super.key});
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => SwitchListTile.adaptive(
    contentPadding: EdgeInsets.zero,
    secondary: Icon(icon, color: AppTheme.teal),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
    subtitle: Text(subtitle),
    value: value,
    onChanged: onChanged,
  );
}
