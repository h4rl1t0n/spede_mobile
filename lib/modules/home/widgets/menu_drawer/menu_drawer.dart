import 'package:flutter/material.dart';

import '../../../../core/ui/theme/styles/text_styles.dart';

class MenuDrawer extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuDrawer({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(right: 8, left: 4, top: 4, bottom: 4),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: cs.primary.withValues(alpha: 0.1),
        child: Icon(icon, color: cs.primary, size: 20),
      ),
      title: Text(
        title,
        style: context.textStyles.textTitleItemList.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      // subtitle: Text(
      //   'Teste para verificar como fica isso aqui',
      //   maxLines: 3,
      //   overflow: .ellipsis,
      //   textAlign: .justify,
      //   style: context.textStyles.textSubTitleItemList,
      // ),
      trailing: Badge.count(count: 6, maxCount: 10, padding: .all(4), backgroundColor: cs.secondary),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
