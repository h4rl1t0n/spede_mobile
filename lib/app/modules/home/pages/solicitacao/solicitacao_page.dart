import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/helpers/loader.dart';
import '../../../../core/helpers/messages.dart';
import '../../../../core/ui/theme/styles/colors_app.dart';
import '../../../../enum/page_status.dart';
import '../../../../enum/tipo_caixa.dart';
import '../../../../models/documento_model.dart';
import 'solicitacao_controller.dart';
import 'widget/filtro_categorias/filtro_categorias.dart';
import 'widget/item_solicitacao.dart';
import 'widget/sem_socitacao.dart';

class SolicitacaoPage extends StatefulWidget {
  final List<DocumentoModel> solicitacaoes;
  final TipoCaixa tipoCaixa;

  const SolicitacaoPage({super.key, required this.tipoCaixa, required this.solicitacaoes});

  @override
  State<SolicitacaoPage> createState() => _SolicitacaoPageState();
}

class _SolicitacaoPageState extends State<SolicitacaoPage> with Loader, Messages, AutomaticKeepAliveClientMixin {
  final controller = Modular.get<SolicitacaoController>();

  List<DocumentoModel> get solicitacaoes => widget.solicitacaoes;
  TipoCaixa get tipoCaixa => widget.tipoCaixa;
  String get descricao => tipoCaixa.descricao;

  late List<ReactionDisposer> disposers = [];

  @override
  void initState() {
    super.initState();
    controller.iniciarController(solicitacaoes);

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            spacing: 8,
            children: [
              Icon(Icons.business_center, color: context.colors.primary),
              Text(descricao, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Observer(
            builder: (context) {
              final categoriaSelecionada = controller.categoriaSelecionada;
              final categorias = controller.contarCategorias;

              return FiltroCategorias(
                categorias: categorias,
                selecionada: categoriaSelecionada,
                onSelecionada: controller.alterarCategoria,
              );
            },
          ),
        ),

        Expanded(
          child: Observer(
            builder: (context) {
              final lista = controller.filtrarPorCategoria;
              final status = controller.status;

              if (lista.isEmpty && status == PageStatus.loading) {
                return Center(child: Text('Carregando ${descricao.toLowerCase()}...'));
              }

              if (lista.isEmpty) {
                return const SemSocitacao();
              }

              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  await controller.carregarSolicitacoes(tipoCaixa);
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
    ];
  }
}
