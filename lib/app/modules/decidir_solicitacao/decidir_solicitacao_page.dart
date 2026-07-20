import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/helpers/loader.dart';
import '../../core/helpers/messages.dart';
import '../../enum/acao_solicitacao.dart';
import '../../enum/tipo_solicitacao.dart';
import '../../mock/motivos_rejeicao.dart';
import '../home/pages/solicitacao/solicitacao_controller.dart';
import 'widgets/item_solicitacao_decidir_card.dart';
import 'widgets/secao_autenticacao.dart';
import 'widgets/secao_header.dart';
import 'widgets/secao_rejeicao.dart';

class DecidirSolicitacaoPage extends StatefulWidget {
  final SolicitacaoController controller;

  const DecidirSolicitacaoPage({super.key, required this.controller});

  @override
  State<DecidirSolicitacaoPage> createState() => _DecidirSolicitacaoPageState();
}

class _DecidirSolicitacaoPageState extends State<DecidirSolicitacaoPage> with Loader, Messages {
  SolicitacaoController get controller => widget.controller;

  late final GlobalKey<FormState> _formKey;

  // Controllers para Aceitar [Assinatura | Visto]
  late final TextEditingController _usuarioController;
  late final TextEditingController _senhaController;
  // Controllers para Rejeitar
  late final TextEditingController _motivoController;
  late final TextEditingController _observacaoController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _usuarioController = TextEditingController(text: '');
    _senhaController = TextEditingController(text: '123456');
    _motivoController = TextEditingController();
    _observacaoController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    _motivoController.dispose();
    _observacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(title: Text(_titulo), centerTitle: true),
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildFormularioAcao(),
                  const SecaoHeader(title: 'Solicitações Selecionadas'),
                  Expanded(
                    child: Observer(
                      builder: (context) {
                        final selecionados = controller.selecionados;
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: selecionados.length,
                          itemBuilder: (context, index) {
                            return ItemSolicitacaoDecidirCard(solicitacao: selecionados[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
              ),
              child: BottomAppBar(
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed: _executarAcaoPrincipal, child: Text(_textoBotaoAcao)),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                        child: const Text('Voltar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Verifica se todas as solicitações são do tipo ciência.
  bool get _isCiencia {
    final selecionados = controller.selecionados;
    return selecionados.every((s) => s.tipoSolicitacao == TipoSolicitacao.ciencia);
  }

  String get _nomesSolicitacoes {
    final selecionados = controller.selecionados;
    return selecionados.map((s) => s.tipoSolicitacao.name).first;
  }

  String get _titulo {
    final acao = controller.acao;
    if (acao == AcaoSolicitacao.rejeitar) {
      return 'Rejeitar Solicitações';
    }
    return 'Atender Solicitações ($_nomesSolicitacoes)';
  }

  String get _textoBotaoAcao {
    final acao = controller.acao;
    if (acao == AcaoSolicitacao.rejeitar) {
      return 'Rejeitar';
    }
    return 'Atender';
  }

  /// Constrói a seção de formulário dinamicamente baseada na ação.
  Widget _buildFormularioAcao() {
    final acao = controller.acao;

    if (acao == AcaoSolicitacao.rejeitar) {
      return SecaoRejeicao(
        observacaoController: _observacaoController,
        motivos: motivos,
        onMotivoSelected: (_) => setState(() {}),
      );
    }

    if (!_isCiencia) {
      return SecaoAutenticacao(usuarioController: _usuarioController, senhaController: _senhaController);
    }

    // Se for ciência, não há campos adicionais acima das solicitações
    return const SizedBox.shrink();
  }

  /// Trata o clique no botão de ação principal.
  void _executarAcaoPrincipal() {
    final acao = controller.acao;

    if (acao == AcaoSolicitacao.rejeitar) {
      _rejeitar();
    } else {
      if (_isCiencia) {
        _darCiencia();
      } else {
        _assinar();
      }
    }
  }

  /// Ação de assinar (visto/assinatura).
  void _assinar() {
    final selecionados = controller.selecionados;
    if (_formKey.currentState!.validate()) {
      log('Usuário: ${_usuarioController.text}');
      log('Assinando ${selecionados.length} solicitação(ões)');
      showSuccess('Solicitação assinada com sucesso!');
    }
  }

  /// Ação de dar ciência.
  void _darCiencia() {
    final selecionados = controller.selecionados;
    log('Dando ciência em ${selecionados.length} solicitação(ões)');
    showSuccess('Ciência registrada com sucesso!');
  }

  /// Ação de rejeitar.
  void _rejeitar() {
    if (_motivoController.text.isEmpty) {
      showError('Por favor, selecione um motivo.');
      return;
    }

    if (_formKey.currentState!.validate()) {
      final selecionados = controller.selecionados;

      log('Motivo: ${_motivoController.text}');
      log('Observação: ${_observacaoController.text}');
      log('Rejeitando ${selecionados.length} solicitação(ões)');
      showSuccess('Solicitação rejeitada com sucesso!');
    }
  }
}
