import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './notificacao_controller.dart';

class NotificacaoPage extends StatefulWidget {
  const NotificacaoPage({super.key});

  @override
  State<NotificacaoPage> createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  final controller = inject<NotificacaoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notificações')),
      body: Center(child: Text('Notificações')),
    );
  }
}
