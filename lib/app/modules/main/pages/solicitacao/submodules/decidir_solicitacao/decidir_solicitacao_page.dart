import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/constants/images.dart';
import '../../../../../../core/extensions/string_extension.dart';
import '../../../../../../core/helpers/loader.dart';
import '../../../../../../core/helpers/messages.dart';
import '../../../../../../core/ui/theme/styles/button_styles.dart';
import '../../../../../../enum/acao_solicitacao.dart';
import '../../../../../../enum/tipo_solicitacao.dart';
import '../../../../../../models/documento_model.dart';
import 'decidir_solicitacao_controller.dart';
import 'widgets/atender_solicitacao/atender_solicitacao.dart';
import 'widgets/item_solicitacao_decidir_card.dart';
import 'widgets/rejeitar_solicitacao/rejeitar_solicitacao.dart';
import 'widgets/secao_header.dart';

class DecidirSolicitacaoPage extends StatefulWidget {
  final AcaoSolicitacao acao;
  final List<DocumentoModel> selecionados;

  const DecidirSolicitacaoPage({super.key, required this.acao, required this.selecionados});

  @override
  State<DecidirSolicitacaoPage> createState() => _DecidirSolicitacaoPageState();
}

class _DecidirSolicitacaoPageState extends State<DecidirSolicitacaoPage> with Loader, Messages {
  final controller = Modular.get<DecidirSolicitacaoController>();

  AcaoSolicitacao get acao => widget.acao;
  bool get rejeitar => acao == AcaoSolicitacao.rejeitar;
  TipoSolicitacao get solicitacao => selecionados.first.tipoSolicitacao;
  List<DocumentoModel> get selecionados => widget.selecionados;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${rejeitar ? 'Rejeitar' : 'Atender'} ${selecionados.length == 1 ? 'Solicitação' : 'Solicitações'}',
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(Images.logoTCE), fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFormularioAcao(),
              SecaoHeader(title: 'Solicitações Selecionadas | ${solicitacao.label}'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: selecionados.length,
                  itemBuilder: (context, index) {
                    return ItemSolicitacaoDecidirCard(solicitacao: selecionados[index]);
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
            color: Colors.white,
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyles.instance.primary.copyWith(
                        backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
                        foregroundColor: WidgetStatePropertyAll(Colors.grey.shade900),
                      ),
                      child: const Text('Voltar'),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyles.instance.primary.copyWith(
                        backgroundColor: WidgetStatePropertyAll(rejeitar ? colorScheme.error : colorScheme.secondary),
                      ),
                      onPressed: _executarAcaoPrincipal,
                      child: Text(acao.name.capitalize()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormularioAcao() {
    if (acao == AcaoSolicitacao.rejeitar) {
      return RejeitarSolicitacao(controller: controller);
    }

    if (acao == AcaoSolicitacao.atender && solicitacao != TipoSolicitacao.ciencia) {
      return AtenderSolicitacao(controller: controller);
    }

    return const SizedBox.shrink();
  }

  void _executarAcaoPrincipal() {
    FocusScope.of(context).unfocus();

    if (rejeitar) {
      _rejeitar();
    } else if (solicitacao == TipoSolicitacao.ciencia) {
      _darCiencia();
    } else {
      _assinar();
    }
  }

  void _assinar() {
    if (controller.isAutenticacaoValida) {
      log('Usuário: ${controller.usuario}');
      log('Senha: ${controller.senha}');
      log('Assinando ${selecionados.length} solicitação(ões)');
      showSuccess('Solicitação assinada com sucesso!');
    } else {
      showError('Por favor, preencha o usuário e a senha corretamente.');
    }
  }

  void _darCiencia() {
    log('Dando ciência em ${selecionados.length} solicitação(ões)');
    showSuccess('Ciência registrada com sucesso!');
  }

  void _rejeitar() {
    if (controller.motivo == null) {
      showError('Por favor, selecione um motivo.');
      return;
    }

    if (controller.isRejeicaoValida) {
      log('Motivo: ${controller.motivo}');
      log('Observação: ${controller.observacao}');
      log('Rejeitando ${selecionados.length} solicitação(ões)');
      showSuccess('Solicitação rejeitada com sucesso!');
    } else {
      showError('Por favor, preencha os campos obrigatórios da rejeição.');
    }
  }
}
