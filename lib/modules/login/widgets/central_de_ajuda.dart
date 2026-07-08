import 'package:flutter/material.dart';

class CentralDeAjuda extends StatelessWidget {
  const CentralDeAjuda({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: .center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              //await UrlUtils.launchURL(uriCentralAjuda);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F7FF),
                border: Border.all(color: const Color(0xFFD5E3FF)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.security, size: 18, color: primary),
                  Text(
                    'Política de Privacidade',
                    textAlign: .center,
                    style: TextStyle(
                      color: primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
