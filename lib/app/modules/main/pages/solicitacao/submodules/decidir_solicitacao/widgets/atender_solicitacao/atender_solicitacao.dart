import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../../../core/global/local_storage_utils.dart';
import '../../decidir_solicitacao_controller.dart';
import '../required_label.dart';
import '../secao_header.dart';

class AtenderSolicitacao extends StatefulWidget {
  final DecidirSolicitacaoController controller;

  const AtenderSolicitacao({super.key, required this.controller});

  @override
  State<AtenderSolicitacao> createState() => _AtenderSolicitacaoState();
}

class _AtenderSolicitacaoState extends State<AtenderSolicitacao> {
  DecidirSolicitacaoController get controller => widget.controller;

  late final TextEditingController usuarioTEC;
  late final TextEditingController senhaTEC;

  @override
  void initState() {
    super.initState();
    usuarioTEC = TextEditingController();
    senhaTEC = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => carregarUsuario());
  }

  @override
  void dispose() {
    usuarioTEC.dispose();
    senhaTEC.dispose();
    super.dispose();
  }

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
                    enabled: false,
                    controller: usuarioTEC,
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
                    controller: senhaTEC,
                    onChanged: controller.setSenha,
                    obscureText: controller.obscureText,
                    decoration: InputDecoration(
                      errorText: controller.senhaErro,
                      hintText: 'Digite sua senha',
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

  Future<void> carregarUsuario() async {
    final usuario = await LocalStorageUtils.getUsuario();
    usuarioTEC.text = controller.usuario = usuario.username;
  }
}
