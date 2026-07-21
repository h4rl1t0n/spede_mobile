import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/usuario_model.dart';
import 'widgets/button_action.dart';
import 'widgets/dashboard_item_card.dart';
import 'widgets/header_home_container.dart';

class HomePage extends StatefulWidget {
  final UsuarioModel usuarioLogado;
  const HomePage({super.key, required this.usuarioLogado});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UsuarioModel get usuarioLogado => widget.usuarioLogado;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final secondary = colorScheme.secondary;
    final tertiary = colorScheme.tertiary;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderHomeContainer(usuarioLogado: usuarioLogado),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: [
                  DashboardCard(
                    title: 'Solicitações Recebidas',
                    value: '964',
                    icon: CupertinoIcons.tray_arrow_down,
                    color: secondary,
                    items: [
                      DashboardSetor(
                        nomeSetor: 'Setin',
                        dashboards: [
                          DashboardItem('Assinatura', '1', Colors.red),
                          DashboardItem('Ciência', '3', Colors.orange),
                          DashboardItem('Visto', '51', Colors.blue),
                        ],
                      ),
                      DashboardSetor(
                        nomeSetor: 'Diproj',
                        dashboards: [
                          DashboardItem('Assinatura', '1', Colors.red),
                          DashboardItem('Ciência', '3', Colors.orange),
                          DashboardItem('Visto', '51', Colors.blue),
                        ],
                      ),
                      DashboardSetor(
                        nomeSetor: 'get-iti',
                        dashboards: [
                          DashboardItem('Assinatura', '1', Colors.red),
                          DashboardItem('Ciência', '3', Colors.orange),
                          DashboardItem('Visto', '51', Colors.blue),
                        ],
                      ),
                    ],
                  ),
                  DashboardCard(
                    title: 'Solicitações Enviadas',
                    value: '1.314',
                    icon: CupertinoIcons.tray_arrow_up,
                    color: tertiary,
                    items: [
                      DashboardSetor(
                        nomeSetor: 'Segin',
                        dashboards: [
                          DashboardItem('Assinatura', '1', Colors.orange),
                          DashboardItem('Ciência', '30', Colors.red),
                          DashboardItem('Visto', '1.283', Colors.green),
                        ],
                      ),
                      DashboardSetor(
                        nomeSetor: 'Deas',
                        dashboards: [
                          DashboardItem('Assinatura', '1', Colors.orange),
                          DashboardItem('Ciência', '30', Colors.red),
                          DashboardItem('Visto', '1.283', Colors.green),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Ações rápidas', style: Theme.of(context).textTheme.titleLarge),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      spacing: 10,
                      children: [
                        ButtonAction(icon: Icons.description_rounded, label: 'Solicitações Enviadas'),
                        ButtonAction(icon: Icons.chat_rounded, label: 'Solicitações Enviadas'),
                      ],
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
