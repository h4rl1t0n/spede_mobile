import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isNull;
  final VoidCallback onTap;
  final bool enabled;

  const ActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isNull,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isNull ? Colors.grey : colorScheme.primary;

    return Material(
      color: Colors.grey.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(14),
      child: ListTile(
        enabled: enabled,
        dense: true,
        onTap: onTap,
        leading: Icon(icon, color: color, size: 20),
        title: Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Cabin'),
        ),
        // subtitle: Text(
        //   subtitle,
        //   textAlign: .justify,
        //   style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, fontFamily: 'Cabin'),
        // ),
      ),
    );
  }
}
