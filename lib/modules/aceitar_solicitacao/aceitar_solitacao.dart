import 'dart:developer';

import 'package:flutter/material.dart';

import '../../enum/tipo_solicitacao.dart';
import '../../models/documento_model.dart';
import '../rejeitar_solicitacao/widgets/secao_header.dart';
import 'widgets/item_solicitacao_aceitar_card.dart';
import 'widgets/secao_autenticacao.dart';

class AceitarSolicitacao extends StatefulWidget {
  final List<DocumentoModel> solicitacoes;

  const AceitarSolicitacao({super.key, required this.solicitacoes});

  @override
  State<AceitarSolicitacao> createState() => _AceitarSolicitacaoState();
}

class _AceitarSolicitacaoState extends State<AceitarSolicitacao> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  /// Verifica se todas as solicitações são do tipo ciência.
  bool get _isCiencia {
    return widget.solicitacoes.every(
      (s) => s.tipoSolicitacao == TipoSolicitacao.ciencia,
    );
  }

  /// Retorna o título da AppBar baseado no tipo de solicitação.
  String get _titulo {
    if (_isCiencia) {
      return 'Dar Ciência';
    }
    return 'Aceitar Solicitações';
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(_titulo)),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!_isCiencia) ...[
                  SecaoAutenticacao(
                    usuarioController: _usuarioController,
                    senhaController: _senhaController,
                  ),
                ],

                SecaoHeader(title: 'Solicitações Selecionadas'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: widget.solicitacoes.map((doc) {
                      return ItemSolicitacaoAceitarCard(solicitacao: doc);
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: _isCiencia ? _darCiencia : _assinar,
                          child: Text(_isCiencia ? 'Dar Ciência' : 'Assinar'),
                        ),
                      ),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Voltar'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Ação de assinar (assinatura/visto) — valida usuário e senha.
  void _assinar() {
    if (_formKey.currentState!.validate()) {
      log('Usuário: ${_usuarioController.text}');
      log('Assinando ${widget.solicitacoes.length} solicitação(ões)');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solicitação assinada com sucesso!')),
      );
    }
  }

  /// Ação de dar ciência — não precisa de autenticação.
  void _darCiencia() {
    log('Dando ciência em ${widget.solicitacoes.length} solicitação(ões)');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ciência registrada com sucesso!')),
    );
  }
}
