import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../enum/tipo_caixa.dart';
import '../../../../models/setor_model.dart';
import 'solicitacao_controller.dart';
import 'widget/filtro_categorias/filtro_categorias.dart';
import 'widget/item_solicitacao.dart';
import 'widget/sem_socitacao.dart';

class SolicitacaoPage extends StatefulWidget {
  final TipoCaixa caixa;
  final SetorModel? setor;
  const SolicitacaoPage({super.key, required this.caixa, required this.setor});

  @override
  State<SolicitacaoPage> createState() => _SolicitacaoPageState();
}

class _SolicitacaoPageState extends State<SolicitacaoPage> {
  final controller = SolicitacaoController();

  TipoCaixa get caixa => widget.caixa;
  SetorModel? get setor => widget.setor;

  bool result = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    controller.setorSelecionado = setor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            spacing: 5,
            children: [
              Icon(Icons.business_center, color: cs.primary),
              Text(caixa.descricao, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                onSelecionada: (categoria) {
                  controller.alterarCategoria(categoria);
                },
              );
            },
          ),
        ),

        const Divider(height: 1),

        Expanded(
          child: Observer(
            builder: (context) {
              final lista = controller.filtrarPorCategoria;

              if (lista.isEmpty) {
                return const SemSocitacao();
              }

              return ListView.separated(
                padding: const EdgeInsets.all(12).copyWith(bottom: 20),
                itemCount: lista.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  final item = lista[index];
                  return ItemSolicitacao(solicitacao: item, controller: controller);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
