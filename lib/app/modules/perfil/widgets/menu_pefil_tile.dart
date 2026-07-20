import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/ui/theme/styles/text_styles.dart';

class MenuPefilTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? color;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;
  final bool isDestructive; // Útil para o botão de "Sair"

  const MenuPefilTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.color,
    this.trailing,
    this.showChevron = false,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final baseColor = isDestructive ? cs.error : (color ?? cs.primary);
    final isDisabled = onTap == null;

    return Padding(
      // Adiciona um pequeno respiro entre os itens da lista
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Material(
        // Fundo levemente cinza se for clicável, ou transparente
        color: isDisabled ? Colors.transparent : Colors.grey.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        // O InkWell gerencia o efeito de clique (ripple) respeitando o arredondamento
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: baseColor.withValues(alpha: 0.1),
          highlightColor: baseColor.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: baseColor.withValues(alpha: 0.12),
                    // Borda arredondada estilo "Squircle" (iOS / Modern Android)
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: isDisabled ? Colors.grey : baseColor, size: 22),
                ),

                const SizedBox(width: 16),

                // === TEXTOS ===
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: context.textStyles.textTitleItemList.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16, // Um pouco maior para leitura
                          color: isDisabled ? Colors.grey : (isDestructive ? cs.error : null),
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ],
                  ),
                ),

                // === TRAILING (Final da linha) ===
                if (trailing != null)
                  trailing!
                else if (showChevron)
                  Icon(
                    CupertinoIcons.chevron_forward,
                    size: 18,
                    color: isDisabled ? Colors.transparent : Colors.grey.shade400,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
