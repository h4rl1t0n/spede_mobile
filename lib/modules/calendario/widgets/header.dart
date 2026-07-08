import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const Header({super.key, required this.month, required this.onPrevious, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      color: colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            _NavigationButton(icon: Icons.chevron_left_rounded, onTap: onPrevious),

            Text(
              month,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, letterSpacing: -.5),
            ),

            _NavigationButton(icon: Icons.chevron_right_rounded, onTap: onNext),
          ],
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavigationButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: SizedBox(width: 44, height: 44, child: Icon(icon, size: 26)),
      ),
    );
  }
}
