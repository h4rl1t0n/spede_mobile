import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../decidir_solicitacao_controller.dart';
import '../required_label.dart';
import '../secao_header.dart';

class AtenderSolicitacao extends StatelessWidget {
  final DecidirSolicitacaoController controller;

  const AtenderSolicitacao({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SecaoHeader(title: 'Assinatura'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RequiredLabel(label: 'Usuário'),
              const SizedBox(height: 8),

              Observer(
                builder: (_) {
                  return TextFormField(
                    initialValue: controller.usuario,
                    onChanged: controller.setUsuario,
                    decoration: InputDecoration(hintText: 'Digite seu usuário', errorText: controller.usuarioErro),
                  );
                },
              ),

              const SizedBox(height: 20),

              const RequiredLabel(label: 'Senha'),
              const SizedBox(height: 8),

              Observer(
                builder: (_) {
                  return TextFormField(
                    initialValue: controller.senha,
                    onChanged: controller.setSenha,
                    obscureText: controller.obscureText,
                    decoration: InputDecoration(
                      hintText: 'Digite sua senha',
                      errorText: controller.senhaErro,
                      suffixIcon: IconButton(
                        icon: Icon(controller.obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: controller.togglePassword,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
