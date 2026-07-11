import 'package:flutter/material.dart';

import '../../core/ui/theme/styles/text_styles.dart';
import '../login/login_page.dart';
import 'widgets/perfil_option_tile.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  bool isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = context.textStyles;
    final double headerHeight = 100;
    final double avatarRadius = 60;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: Text('Perfil Pessoal'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(height: headerHeight, width: double.infinity, color: theme.colorScheme.primary),
                Positioned(
                  bottom: -avatarRadius,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        'U',
                        style: textStyles.textHeadline.copyWith(
                          fontSize: 48,
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: avatarRadius + 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    'USUARIO DE TESTE',
                    textAlign: TextAlign.center,
                    style: textStyles.textTitle.copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, size: 24, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(
                        'Perfil Pessoal',
                        textAlign: .center,
                        style: textStyles.textCaption.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  PerfilOptionTile(
                    icon: Icons.person_outline,
                    iconBackgroundColor: theme.colorScheme.surfaceContainerHighest,
                    iconColor: theme.colorScheme.primary,
                    title: 'Meus Dados',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  PerfilOptionTile(
                    icon: Icons.notifications_none_outlined,
                    iconBackgroundColor: theme.colorScheme.surfaceContainerHighest,
                    iconColor: theme.colorScheme.primary,
                    title: 'Notificação habilitada',
                    trailing: Switch(
                      value: isNotificationEnabled,
                      activeThumbColor: theme.colorScheme.primary,
                      activeTrackColor: theme.colorScheme.primary.withValues(alpha: .3),
                      onChanged: (value) {
                        setState(() {
                          isNotificationEnabled = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  PerfilOptionTile(
                    icon: Icons.shield_outlined,
                    iconBackgroundColor: theme.colorScheme.surfaceContainerHighest,
                    iconColor: theme.colorScheme.primary,
                    title: 'Política de Privacidade',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  PerfilOptionTile(
                    icon: Icons.logout_outlined,
                    iconBackgroundColor: theme.colorScheme.errorContainer,
                    iconColor: theme.colorScheme.error,
                    title: 'Sair',
                    titleColor: theme.colorScheme.error,
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),
            Text('Versão: 1.16.2', style: textStyles.textCaption.copyWith(color: theme.colorScheme.outline)),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
