import 'dart:developer';

import 'package:flutter/material.dart';

import '../../enum/tipo_solicitacao.dart';
import '../../models/documento_model.dart';
import '../solicitacao/widget/acao_solcitacao_sheet.dart';
import 'widgets/item_solicitacao_decidir_card.dart';
import 'widgets/secao_autenticacao.dart';
import 'widgets/secao_header.dart';
import 'widgets/secao_rejeicao.dart';

class DecidirSolicitacaoPage extends StatefulWidget {
  final List<DocumentoModel> solicitacoes;
  final AcaoSolicitacao acao;

  const DecidirSolicitacaoPage({
    super.key,
    required this.solicitacoes,
    required this.acao,
  });

  @override
  State<DecidirSolicitacaoPage> createState() => _DecidirSolicitacaoPageState();
}

class _DecidirSolicitacaoPageState extends State<DecidirSolicitacaoPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para Aceitar/Assinar
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  // Controllers para Rejeitar
  final _motivoController = TextEditingController();
  final _observacaoController = TextEditingController();

  final List<String> _motivosRejeicao = [
    'Ausência de Informação',
    'Devolução',
    'Inobservância do Modelo Padrão',
    'Solicitação indevida',
  ];

  /// Verifica se todas as solicitações são do tipo ciência.
  bool get _isCiencia {
    return widget.solicitacoes.every(
      (s) => s.tipoSolicitacao == TipoSolicitacao.ciencia,
    );
  }


  String get _titulo {
    if (widget.acao == AcaoSolicitacao.rejeitar) {
      return 'Rejeitar Solicitações';
    }
    return _isCiencia ? 'Dar Ciência' : 'Aceitar Solicitações';
  }

  String get _textoBotaoAcao {
    if (widget.acao == AcaoSolicitacao.rejeitar) {
      return 'Rejeitar';
    }
    return _isCiencia ? 'Dar Ciência' : 'Assinar';
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
                _buildFormularioAcao(),
                SecaoHeader(title: 'Solicitações Selecionadas'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: widget.solicitacoes.map((doc) {
                      return ItemSolicitacaoDecidirCard(solicitacao: doc);
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
                          onPressed: _executarAcaoPrincipal,
                          child: Text(_textoBotaoAcao),
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

  /// Constrói a seção de formulário dinamicamente baseada na ação.
  Widget _buildFormularioAcao() {
    if (widget.acao == AcaoSolicitacao.rejeitar) {
      return SecaoRejeicao(
        motivoController: _motivoController,
        observacaoController: _observacaoController,
        motivos: _motivosRejeicao,
        onMotivoSelected: (_) => setState(() {}),
      );
    }

    if (!_isCiencia) {
      return SecaoAutenticacao(
        usuarioController: _usuarioController,
        senhaController: _senhaController,
      );
    }

    // Se for ciência, não há campos adicionais acima das solicitações
    return const SizedBox.shrink();
  }

  /// Trata o clique no botão de ação principal.
  void _executarAcaoPrincipal() {
    if (widget.acao == AcaoSolicitacao.rejeitar) {
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
    if (_formKey.currentState!.validate()) {
      log('Usuário: ${_usuarioController.text}');
      log('Assinando ${widget.solicitacoes.length} solicitação(ões)');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solicitação assinada com sucesso!')),
      );
    }
  }

  /// Ação de dar ciência.
  void _darCiencia() {
    log('Dando ciência em ${widget.solicitacoes.length} solicitação(ões)');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ciência registrada com sucesso!')),
    );
  }

  /// Ação de rejeitar.
  void _rejeitar() {
    if (_motivoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione um motivo.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      log('Motivo: ${_motivoController.text}');
      log('Observação: ${_observacaoController.text}');
      log('Rejeitando ${widget.solicitacoes.length} solicitação(ões)');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solicitação rejeitada com sucesso!')),
      );
    }
  }
}
