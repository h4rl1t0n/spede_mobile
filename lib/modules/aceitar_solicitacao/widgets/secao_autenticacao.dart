import 'package:flutter/material.dart';

import '../../rejeitar_solicitacao/widgets/secao_header.dart';

class SecaoAutenticacao extends StatefulWidget {
  final TextEditingController usuarioController;
  final TextEditingController senhaController;

  const SecaoAutenticacao({
    super.key,
    required this.usuarioController,
    required this.senhaController,
  });

  @override
  State<SecaoAutenticacao> createState() => _SecaoAutenticacaoState();
}

class _SecaoAutenticacaoState extends State<SecaoAutenticacao> {
  bool _senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SecaoHeader(title: 'Autenticação de Assinatura'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Usuário',
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                  children: [
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: widget.usuarioController,
                decoration: const InputDecoration(hintText: 'Digite seu usuário'),
                validator: (value) {
                  final usuario = value ?? '';
                  if (usuario.trim().isEmpty) {
                    return 'O usuário é obrigatório.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              RichText(
                text: TextSpan(
                  text: 'Senha',
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                  children: [
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: widget.senhaController,
                obscureText: !_senhaVisivel,
                decoration: InputDecoration(
                  hintText: 'Digite sua senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _senhaVisivel = !_senhaVisivel;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  final senha = value ?? '';
                  if (senha.trim().isEmpty) {
                    return 'A senha é obrigatória.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
