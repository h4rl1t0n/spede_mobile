import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/helpers/loader.dart';
import '../../../../core/helpers/messages.dart';
import '../../../../core/ui/theme/styles/colors_app.dart';
import '../../../../enum/page_status.dart';
import '../../../../enum/tipo_caixa.dart';
import 'solicitacao_controller.dart';
import 'widget/acao_solcitacao_sheet/acao_solcitacao_sheet.dart';
import 'widget/filtro_categorias/filtro_categorias.dart';
import 'widget/item_solicitacao.dart';
import 'widget/sem_socitacao.dart';

class SolicitacaoPage extends StatefulWidget {
  final TipoCaixa caixa;
  const SolicitacaoPage({super.key, required this.caixa});

  @override
  State<SolicitacaoPage> createState() => _SolicitacaoPageState();
}

class _SolicitacaoPageState extends State<SolicitacaoPage> with Loader, Messages, AutomaticKeepAliveClientMixin {
  final controller = Modular.get<SolicitacaoController>();

  TipoCaixa get caixa => widget.caixa;
  String get descricao => caixa.descricao;

  late List<ReactionDisposer> disposers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => setupReactions());
  }

  @override
  void dispose() {
    for (var dispose in disposers) {
      dispose();
    }
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Observer(
            builder: (context) {
              final lista = controller.solicitacoes;

              return Visibility(
                visible: lista.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.business_center, color: context.colors.primary),
                      Text(
                        '$descricao (${lista.length})',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Observer(
              builder: (context) {
                final categoriaSelecionada = controller.categoriaSelecionada;
                final categorias = controller.contarCategorias;
                final lista = controller.solicitacoes;

                return Visibility(
                  visible: lista.isNotEmpty,
                  child: FiltroCategorias(
                    categorias: categorias,
                    selecionada: categoriaSelecionada,
                    onSelecionada: controller.alterarCategoria,
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: Observer(
              builder: (context) {
                final lista = controller.filtrarPorCategoria;
                final status = controller.status;
                final categoriaSelecionada = controller.categoriaSelecionada;

                if (lista.isEmpty && status == PageStatus.loading) {
                  return Center(child: Text('Carregando ${descricao.toLowerCase()}...'));
                }

                if (lista.isEmpty) {
                  return SemSocitacao(caixa: caixa, solicitacao: categoriaSelecionada);
                }

                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    controller.solicitacoes.clear();
                    await controller.carregarSolicitacoes(caixa);
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12).copyWith(bottom: 20),
                    itemCount: lista.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final item = lista[index];
                      return ItemSolicitacao(solicitacao: item, controller: controller);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Observer(
        builder: (context) {
          final selecionados = controller.selecionados;
          return Visibility(
            visible: selecionados.isNotEmpty,
            child: FloatingActionButton.extended(label: Text('data'), onPressed: abrirAcoes),
          );
        },
      ),
    );
  }

  void setupReactions() {
    disposers = [
      reaction((_) => controller.status, (status) {
        switch (status) {
          case PageStatus.initial:
            break;
          case PageStatus.loading:
            showLoader();
            break;
          case PageStatus.loaded:
            hideLoader();
            break;
          case PageStatus.success:
            hideLoader();
            break;
          case PageStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro ao carregar as ${descricao.toLowerCase()}');
            break;
        }
      }),
      when((_) => controller.filtrarPorCategoria.isEmpty, () {
        controller.carregarSolicitacoes(caixa);
      }),
    ];
  }

  Future<void> abrirAcoes() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return AcaoSolcitacaoSheet(controller: controller, caixa: caixa);
      },
    );

    controller.acao = null;
    controller.selecionados.clear();
  }
}
