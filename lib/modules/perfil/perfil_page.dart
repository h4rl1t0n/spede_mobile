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

    // Altura do header do topo
    final double headerHeight = 180;
    // Raio do avatar
    final double avatarRadius = 60;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Bloco do topo com fundo primary do tema
                Container(
                  height: headerHeight,
                  width: double.infinity,
                  color: theme.colorScheme.primary,
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            Text(
                              'Perfil Pessoal',
                              style: textStyles.textTitle.copyWith(color: theme.colorScheme.onPrimary, fontSize: 20),
                            ),
                            // SizedBox invisível para centralizar o título
                            const SizedBox(width: 48),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Avatar sobreposto na borda inferior do header
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
            // Espaçamento para compensar a metade inferior do avatar
            SizedBox(height: avatarRadius + 24),

            // Informações do Usuário
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

            // Lista de Opções do Perfil
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
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
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
